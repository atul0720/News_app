import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webView extends StatefulWidget {
  const webView({Key? key}) : super(key: key);

  @override
  State<webView> createState() => _webViewState();
}

class _webViewState extends State<webView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea( // for resposiveness in app view
          child: WebView(
            initialUrl: "https://timesofindia.indiatimes.com/india/maharashtra-political-crisis-news-live-updates-mva-government-shiv-sena-bjp-ncp-eknath-shinde-uddhav-thackeray-fadnavis-sharad-pawar-june-24/liveblog/92425000.cms",
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}
