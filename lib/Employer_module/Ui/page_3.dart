import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:learning_app/Employer_module/Notifiers/page1_notifier.dart';

import 'package:learning_app/constants/size_config.dart';
import 'package:learning_app/samples/sample_Notifier.dart';
import 'package:provider/provider.dart';

class EmployerHomePage3 extends StatefulWidget {
  final cvUrl;

  const EmployerHomePage3({Key key, this.cvUrl}) : super(key: key);
  @override
  _EmployerHomePage3State createState() => _EmployerHomePage3State();
}

class _EmployerHomePage3State extends State<EmployerHomePage3> {
  InAppWebViewController webView;

  String url = "";

  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Page1Provider>(
        create: (context) => Page1Provider(),
        child: Builder(builder: (context) {
          return Scaffold(
              backgroundColor: Color(0xffF5EBE8),
              appBar: AppBar(
                elevation: 20,
                shadowColor: Colors.black,
                backgroundColor: Color(0xff293847),
                title: Text("Curriculum Vitae "),
                leading: Container(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/aci_Logo.png',
                            width: SizeConfig.widthMultiplier * 15,
                          ),
                          Text(
                            'LEARNING',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.textMultiplier * 1.5),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              body: Consumer<Page1Provider>(
                builder: (context, provider, child) {
                  //print(widget.cvUrl);
                  return Container(
                      child: Column(children: <Widget>[
                    Container(
                        child: progress < 1.0
                            ? LinearProgressIndicator(value: progress)
                            : Container()),
                    Expanded(
                      child: Container(
                        child: widget.cvUrl == null
                            ? Center(
                                child: Text('NO C.V. Available'),
                              )
                            : InAppWebView(
                                initialUrl: widget.cvUrl,
                                initialHeaders: {},
                                initialOptions: InAppWebViewGroupOptions(
                                    crossPlatform: InAppWebViewOptions(
                                  debuggingEnabled: true,
                                )),
                                onWebViewCreated:
                                    (InAppWebViewController controller) {
                                  webView = controller;
                                },
                                onLoadStart: (InAppWebViewController controller,
                                    String url) {
                                  setState(() {
                                    this.url = url;
                                  });
                                },
                                onLoadStop: (InAppWebViewController controller,
                                    String url) async {
                                  setState(() {
                                    this.url = url;
                                  });
                                },
                                onProgressChanged:
                                    (InAppWebViewController controller,
                                        int progress) {
                                  setState(() {
                                    this.progress = progress / 100;
                                  });
                                },
                              ),
                      ),
                    ),
//                    Row(
//                      children: <Widget>[
//                        RaisedButton(
//                          child: Icon(Icons.arrow_back),
//                          onPressed: () {
//                            if (webView != null) {
//                              webView.goBack();
//                            }
//                          },
//                        ),
//                        RaisedButton(
//                          child: Icon(Icons.arrow_forward),
//                          onPressed: () {
//                            if (webView != null) {
//                              webView.goForward();
//                            }
//                          },
//                        ),
//                        RaisedButton(
//                          child: Icon(Icons.refresh),
//                          onPressed: () {
//                            if (webView != null) {
//                              webView.reload();
//                            }
//                          },
//                        ),
//                      ],
//                    ),
                  ]));
                },
              ));
        }));
  }
}
