import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:learning_app/constants/size_config.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  InAppWebViewController webView;

  String url = "";

  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Student HomePage'),
//      ),
      backgroundColor: Color(0xff293847),
      body: Container(
          child: Column(children: <Widget>[
//        Container(
//          padding: EdgeInsets.all(20.0),
//          child: Text(
//              "CURRENT URL\n${(url.length > 50) ? url.substring(0, 50) + "..." : url}"),
//        ),
          SizedBox(height: SizeConfig.heightMultiplier* 5,),
        Container(
           // padding: EdgeInsets.all(4.0),
            child: progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : Container()),
        Expanded(
          child: Container(
         //   margin: const EdgeInsets.all(4.0),
            decoration:
                BoxDecoration(
                   // border: Border.all(color: Colors.blueAccent)
                ),
            child: InAppWebView(
              initialUrl: "https://acilearning.com/",
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                debuggingEnabled: true,
              )),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {
                setState(() {
                  this.url = url;
                });
              },
              onLoadStop:
                  (InAppWebViewController controller, String url) async {
                setState(() {
                  this.url = url;
                });
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Icon(Icons.arrow_back),
              onPressed: () {
                if (webView != null) {
                  webView.goBack();
                }
              },
            ),
            RaisedButton(
              child: Icon(Icons.arrow_forward),
              onPressed: () {
                if (webView != null) {
                  webView.goForward();
                }
              },
            ),
            RaisedButton(
              child: Icon(Icons.refresh),
              onPressed: () {
                if (webView != null) {
                  webView.reload();
                }
              },
            ),
          ],
        ),
      ])),
    );
  }
}
