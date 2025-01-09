import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PayOrcWebView extends StatefulWidget {
  final String paymentUrl;
  final Function(bool success, {String? errorMessage}) onPaymentResult;
  final Function()? onPopResult;

  const PayOrcWebView({
    super.key,
    required this.paymentUrl,
    required this.onPaymentResult,
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
    iframeAllowFullscreen: true,
  );

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

  @override
  Widget build(BuildContext context) {
    return widget.onPopResult == null
        ? Stack(
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
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    final url = navigationAction.request.url!;
                    if (url.toString().contains("checkout/status")) {
                      widget.onPaymentResult(true);
                      // Navigator.pop(context); // Need to check and use it based on navigator usage.
                      return NavigationActionPolicy.CANCEL;
                    }
                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (controller, url) async {
                    setState(() {
                      isLoading = false; // Hide loader when loading stops
                    });
                    if (url != null) {
                      // Optionally, handle the URL here as well
                      if (url.toString().contains("checkout/status")) {
                        widget.onPaymentResult(true);
                        // Navigator.pop(context); // Need to check and use it based on navigator usage.
                      }
                    }
                  },
                  onReceivedError: (controller, request, error) {
                    debugPrint(error.description);
                    widget.onPaymentResult(false,
                        errorMessage: error.description);
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
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                ),
            ],
          )
        : PopScope(
            canPop: true,
            onPopInvokedWithResult: (didPop, result) {
              widget.onPopResult?.call();
            },
            child: Scaffold(
              appBar: AppBar(title: const Text("Payment")),
              body: Stack(
                children: [
                  if (widget.paymentUrl.isEmpty)
                    Center(
                      child: Text("Invalid payment URL."),
                    )
                  else
                    InAppWebView(
                      key: webViewKey,
                      webViewEnvironment: webViewEnvironment,
                      initialUrlRequest: URLRequest(
                          url: WebUri.uri(Uri.parse(widget.paymentUrl))),
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
                        final url = navigationAction.request.url!;
                        if (url.toString().contains("checkout/status")) {
                          widget.onPaymentResult(true);
                          // Navigator.pop(context); // Need to check and use it based on navigator usage.
                          return NavigationActionPolicy.CANCEL;
                        }
                        return NavigationActionPolicy.ALLOW;
                      },
                      onLoadStop: (controller, url) async {
                        setState(() {
                          isLoading = false; // Hide loader when loading stops
                        });
                        if (url != null) {
                          // Optionally, handle the URL here as well
                          if (url.toString().contains("checkout/status")) {
                            widget.onPaymentResult(true);
                            // Navigator.pop(context); // Need to check and use it based on navigator usage.
                          }
                        }
                      },
                      onReceivedError: (controller, request, error) {
                        debugPrint(error.description);
                        // widget.onPaymentResult(false,
                        //     errorMessage: error.description);
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
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    ),
                ],
              ),
            ),
          );
  }
}
