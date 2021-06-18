import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void WebViewCreatedCallback(WebViewController controller);

class AndroidWebView extends StatefulWidget {


  final WebViewCreatedCallback onWebViewViewCreated;

  const AndroidWebView({
     Key? key,
     required this.onWebViewViewCreated,
  }) : super(key: key);



  @override
  State<StatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends State<AndroidWebView> {
  @override
  Widget build(BuildContext context) {

    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'plugins.gyx.views/webview',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text('$defaultTargetPlatform is not supported!');
  }

  void _onPlatformViewCreated(int id) {
    print('==============id: $id');
    if (widget.onWebViewViewCreated == null) return;
    widget.onWebViewViewCreated(new WebViewController._(id));



  }
}

class WebViewController {
  WebViewController._(int id) : _channel = new MethodChannel('plugins.gyx.views/webview_$id');

  final MethodChannel _channel;

  Future<void> setUrl(String url) async {
    assert(url != null);
    return _channel.invokeMethod('setUrl', url);
  }


}
