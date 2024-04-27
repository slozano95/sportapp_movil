import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // print(request.url);
            if (request.url
                .startsWith("https://developers.strava.com/oauth2-redirect/")) {
              var code = request.url.split("code=")[1].split("&")[0];
              goBack(code);
            }
            return NavigationDecision.navigate;
          }))
      ..loadRequest(Uri.parse(
          'https://www.strava.com/api/v3/oauth/authorize?response_type=code&client_id=125569&redirect_uri=https%3A%2F%2Fdevelopers.strava.com%2Foauth2-redirect%2F&scope=activity:read_all,activity:write'));

    return Scaffold(
      appBar: AppBar(title: const Text('Strava Authorization')),
      body: WebViewWidget(controller: controller),
    );
  }

  void goBack(String code) {
    Navigator.pop(context, code);
  }
}
