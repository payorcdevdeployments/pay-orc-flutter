import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_pay_orc/flutter_pay_orc.dart';
import 'package:flutter_pay_orc/src/network/models/pay_orc_transaction.dart';

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

class _PayOrcWebViewState extends State<PayOrcWebView> {
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _gotPaymentStatus,
      onPopInvokedWithResult: (didPop, result) async {
        bool? canGoBack = await webViewController?.canGoBack();
        if (!_gotPaymentStatus && (canGoBack ?? false)) {
          webViewController?.goBack();
        } else {
          widget.onPopResult?.call!(FlutterPayOrc.instance.orderId);
        }
      },
      child: Stack(
        children: [
          if (widget.paymentUrl.isEmpty)
            Center(
              child: Text("Invalid payment URL."),
            )
          else
            InAppWebView(
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
              shouldOverrideUrlLoading: (controller, navigationAction) async {
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
              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED);
              },
            ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            ),
        ],
      ),
    );
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
            setState(() {
              _gotPaymentStatus = true;
            });

            final data = Transaction.fromJson(
                jsonDecode(args.first) as Map<String, dynamic>);
            debugPrint('onPostMessage : ${data.toJson()}');
            FlutterPayOrc.instance.orderId = data.pOrderId;
          }
        });
  }
}
