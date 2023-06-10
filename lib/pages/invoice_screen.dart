import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key, required this.id});

  final String id;

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  late final WebViewController controller;
  double webProgress = 0;

  @override
  void initState() {
    super.initState();

    final WebViewController _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(
          'https://testapi.happykhata.com/material_purchase/${widget.id}'));

    controller = _controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
      ),
      body: Column(
        children: [
          webProgress < 1
              ? SizedBox(
                  height: 5,
                  child: LinearProgressIndicator(
                    value: webProgress,
                    color: const Color(0xFF142D5D),
                    backgroundColor: Colors.white,
                  ),
                )
              : const SizedBox(),
          Expanded(
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}


/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key, required this.id});

  final String id;

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {

  WebViewController? webViewController;
  double webProgress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (await webViewController!.canGoBack()) {
            webViewController!.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: Column(
          children: [
            webProgress < 1
                ? SizedBox(
              height: 5,
              child: LinearProgressIndicator(
                value: webProgress,
                color: Color(0xFF142D5D),
                backgroundColor: Colors.white,
              ),
            )
                : SizedBox(),
            Expanded(
              child: WebView(
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                initialUrl: "https://www.youtube.com/results?search_query=how+to+use+url+launcher+for+in+app+bouse+in+flutter",
                javascriptMode:
                JavascriptMode.unrestricted,
                onProgress: (progress) {
                  setState(() {
                    this.webProgress = progress / 100;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/