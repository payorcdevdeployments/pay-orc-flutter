import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:payorc/payorc.dart';

class PayOrcWebView extends StatefulWidget {
  final String paymentUrl;
  final Function(String? pOrderId)? onPopResult;

  const PayOrcWebView({
    super.key,
    required this.paymentUrl,
    this.onPopResult,
  });

  @override
  State<PayOrcWebView> createState() => _PayOrcWebViewState();
}

class _PayOrcWebViewState extends State<PayOrcWebView>
    with TickerProviderStateMixin {
  final GlobalKey webViewKey = GlobalKey();
  double progress = 0;
  bool isLoading = false;
  WebViewEnvironment? webViewEnvironment;
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      javaScriptEnabled: true,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      useShouldOverrideUrlLoading: true,
      cacheMode: CacheMode.LOAD_NO_CACHE,
      mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
      iframeAllowFullscreen: true);

  late BuildContext _buildContext;

  @override
  void initState() {
    _initializeWebView();
    super.initState();
  }

  void _initializeWebView() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
      final availableVersion = await WebViewEnvironment.getAvailableVersion();
      assert(
        availableVersion != null,
        'Failed to find an installed WebView2 runtime or non-stable Microsoft Edge installation.',
      );
      webViewEnvironment = await WebViewEnvironment.create(
        settings: WebViewEnvironmentSettings(
          additionalBrowserArguments: kDebugMode
              ? '--enable-features=msEdgeDevToolsWdpRemoteDebugging'
              : null,
          userDataFolder: 'custom_path',
        ),
      );
    }
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
    }
  }

  bool _gotPaymentStatus = false;
  String? orderId;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;

    return PopScope(
      canPop: _gotPaymentStatus,
      onPopInvokedWithResult: (didPop, result) async {
        bool? canGoBack = await webViewController?.canGoBack();
        if (!_gotPaymentStatus && (canGoBack ?? false)) {
          webViewController?.goBack();
        } else {
          widget.onPopResult?.call!(PayOrcFlutter.instance.orderId ?? orderId);
        }
      },
      child: Stack(
        children: [
          if (widget.paymentUrl.isEmpty)
            Center(
              child: Text("Invalid payment URL."),
            )
          else
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: InAppWebView(
                  key: webViewKey,
                  webViewEnvironment: webViewEnvironment,
                  initialUrlRequest:
                      URLRequest(url: WebUri.uri(Uri.parse(widget.paymentUrl))),
                  initialUserScripts: UnmodifiableListView<UserScript>([]),
                  initialSettings: settings,
                  onWebViewCreated: (controller) async {
                    webViewController = controller;
                  },
                  onLoadStart: (controller, url) {
                    setState(() {
                      isLoading = true; // Show loader when loading starts
                    });
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (controller, url) async {
                    setState(() {
                      isLoading = false; // Hide loader when loading stops
                    });
                    await _getPostData(context);
                  },
                  onReceivedError: (controller, request, error) {
                    debugPrint(error.description);
                  },
                  onProgressChanged: (controller, progress) {},
                  onUpdateVisitedHistory: (controller, url, isReload) {},
                  onConsoleMessage: (controller, consoleMessage) {
                    debugPrint(consoleMessage
                        .message); // To capture JavaScript console logs
                  },
                  onReceivedServerTrustAuthRequest:
                      (controller, challenge) async {
                    return ServerTrustAuthResponse(
                        action: ServerTrustAuthResponseAction.PROCEED);
                  },
                ),
              ),
            ),
          if (isLoading)
            Center(
              child: SizedBox(
                  height: 56,
                  width: 56,
                  child: Image.asset(
                      'packages/payorc_flutter/assets/loader.gif')),
            ),
          if (_gotPaymentStatus)
            Positioned(
              right: 32,
              top: 32,
              child: Container(
                width: 48, // Width of the rounded container
                height: 48, // Height of the rounded container
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  shape: BoxShape.circle, // Rounded shape
                ),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
            ),
          if (_gotPaymentStatus)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'You will be redirected to the Merchant site in ${_seconds.toString()} seconds.',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'sans-serif',
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Material(
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(true),
                            child: Text(
                              'Redirect Now',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'sans-serif',
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.underline,
                                  color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  int _seconds = 5; // Start from 10
  Timer? _timer;

  void startCountdown() {
    _timer?.cancel(); // Cancel any existing timer
    setState(() {
      _seconds = 5; // Reset counter
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 1) {
        setState(() {
          _seconds--;
        });
      } else {
        timer.cancel(); // Stop the timer at 1
        setState(() {
          _seconds = 0; // Ensure it shows 00 at the end
        });

        if (mounted) {
          Navigator.of(_buildContext).pop(true);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up the timer when widget is removed
    super.dispose();
  }

  Future<void> _getPostData(BuildContext context) async {
    // Inject your JavaScript code to capture post messages and listen for them
    await webViewController?.evaluateJavascript(source: """
            var eventMethod = window.addEventListener ? "addEventListener" : "attachEvent";
            var eventer = window[eventMethod];
            var messageEvent = eventMethod == "attachEvent" ? "onmessage" : "message";
            
            // Listen to message from child window
            eventer(messageEvent, function(e) {
              console.log(JSON.parse(e.data)); // This will show all the result attributes
              var result = JSON.parse(e.data);
              
              // if (result['status'] == "SUCCESS") {
              //   alert("Transaction successful. Transaction ID: " + result['transaction_id']);
              // } else if (result['status'] == "CANCELLED") {
              //   alert(result['remark']);
              // } else if (result['status'] == "FAILED") {
              //   alert("Transaction failed. Transaction ID: " + result['transaction_id']);
              // }
                            
              // Send the result data to Flutter for further processing
              window.flutter_inappwebview.callHandler('onPostMessage', e.data);
            }, false);
          """);

    webViewController?.addJavaScriptHandler(
        handlerName: 'onPostMessage',
        callback: (args) async {
          if (args.isNotEmpty) {
            final data = Transaction.fromJson(
                jsonDecode(args.first) as Map<String, dynamic>);
            debugPrint('onPostMessage : ${data.toJson()}');

            setState(() {
              PayOrcFlutter.instance.orderId = data.pOrderId;
              orderId = data.pOrderId;
              _gotPaymentStatus = true;
            });

            // Close the screen after 5 seconds
            Future.delayed(Duration(seconds: 2), () {
              startCountdown();
            });
          }
        });
  }
}
