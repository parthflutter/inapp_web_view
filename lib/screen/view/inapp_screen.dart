import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:inapp_web_view/screen/provider/inapp_provider.dart';
import 'package:provider/provider.dart';

class inapp_view_screen extends StatefulWidget {
  const inapp_view_screen({Key? key}) : super(key: key);

  @override
  State<inapp_view_screen> createState() => _inapp_view_screenState();
}

TextEditingController txtsearch = TextEditingController();
Inapp_view_provider? inapp_view_providerTrue, inapp_view_providerFalse;
PullToRefreshController?pullToRefreshController;

class _inapp_view_screenState extends State<inapp_view_screen> {
  @override
  void initState() {
    super.initState();
    pullToRefreshController= PullToRefreshController(onRefresh:(){
      inapp_view_providerTrue!.inAppWebViewController?.reload();
    });
  }
  Widget build(BuildContext context) {
    inapp_view_providerTrue =
        Provider.of<Inapp_view_provider>(context, listen: true);
    inapp_view_providerFalse =
        Provider.of<Inapp_view_provider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 3,
                            spreadRadius: 3)
                      ]),
                  child: TextField(
                    controller: txtsearch,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: IconButton(
                        onPressed: () {
                          var newLink = txtsearch.text;
                          inapp_view_providerTrue!.inAppWebViewController!.loadUrl(
                              urlRequest: URLRequest(
                                  url: Uri.parse(
                                      "https://www.google.com/search?q=$newLink")));
                        },
                        icon: Icon(Icons.search_rounded),
                      ),
                    ),
                  ),
                ),
                LinearProgressIndicator(
                  value: inapp_view_providerTrue!.progessweb,
                ),
                Expanded(
                  child: InAppWebView(
                    initialUrlRequest:
                        (URLRequest(url: Uri.parse("https://www.google.com/"))),
                    pullToRefreshController: pullToRefreshController!,

                    onWebViewCreated: (controller) {
                      inapp_view_providerTrue!.inAppWebViewController =
                          controller;
                    },
                    onLoadError: (controller, url, code, message){
                      pullToRefreshController!.endRefreshing();
                      inapp_view_providerTrue!.inAppWebViewController =
                          controller;
                    },
                    onLoadStart: (controller, url) {
                      inapp_view_providerTrue!.inAppWebViewController =
                          controller;
                    },
                    onLoadStop: (controller, url,) {
                      pullToRefreshController!.endRefreshing();
                      inapp_view_providerTrue!.inAppWebViewController = controller;
                    },
                    onProgressChanged: (controller, progress) {
                      pullToRefreshController!.endRefreshing();
                      inapp_view_providerFalse!.changeprogress(progress / 100);
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          inapp_view_providerTrue!.inAppWebViewController!
                              .goBack();
                        },
                        icon: Icon(
                          Icons.arrow_back,color: Colors.black,
                        )),
                    IconButton(
                        onPressed: () {
                          inapp_view_providerTrue!.inAppWebViewController!
                              .reload();
                        },
                        icon: Icon(Icons.refresh)),
                    IconButton(
                        onPressed: () {
                          inapp_view_providerTrue!.inAppWebViewController!
                              .goForward();
                        },
                        icon: Icon(Icons.arrow_forward)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
