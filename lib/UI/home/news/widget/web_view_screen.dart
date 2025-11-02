import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  WebViewScreen({super.key, required});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  var controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var url = ModalRoute.of(context)!.settings.arguments as String;
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
              setState(() => isLoading = true);
            },
            onPageStarted: (String url) {
              setState(() => isLoading = false);
            },
            onPageFinished: (String url) {},
            onHttpError: (HttpResponseError error) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(url));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //controllerWidget(),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).hintColor,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          controllerWidget(),
        ],
      ),
    );
  }

  Widget controllerWidget() {
    if (!mounted || controller == null) {
      return const SizedBox.shrink();
    }
    return WebViewWidget(controller: controller);
  }
}
