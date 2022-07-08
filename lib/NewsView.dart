import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // for importing webView Flutter Package
import 'package:sizer/sizer.dart';
class NewsView extends StatefulWidget {

  String url;// for having url which we want to display through constructor
  NewsView(this.url); // for taking url

  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  String? finalUrl; // for Having final url
  final Completer<WebViewController> controller = Completer<WebViewController>(); // for Making Controller for webpage
  @override
  void initstate(){
    if(widget.url.toString().contains("http://")) // for replacing http to https
        {
      finalUrl = widget.url.toString().replaceAll("http://","https://"); // for changing http to https as our WEBVIEW always works with Https sites
    }
    else{
      finalUrl = widget.url;
    }
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent[400],
        title: Text(
          "Apna News",
          style: TextStyle(
              fontFamily: 'RobotoCondensed Bold',
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 15.sp),
        ),

        leading: IconButton( // for backbutton in app
          icon: Icon(Icons.arrow_back, color: Colors.white,size: 30,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 15,
      ),
      body: Container(
        child: WebView(
          initialUrl:widget.url, // Url which we want to show
          javascriptMode: JavascriptMode.unrestricted, // webView Properties
          onWebViewCreated: (WebViewController webViewController){ // for showing complete page in our APP when cLicked
            setState(() {
              controller.complete(webViewController); /// for passing Web View Controller in our App
            });
          }, // for showing Web View in App we pass controller
        ),
      ),
    );
  }
}
