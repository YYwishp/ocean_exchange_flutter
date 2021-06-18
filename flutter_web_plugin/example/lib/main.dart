import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugin/flutter_web_plugin.dart';
import 'package:flutter_web_plugin/web_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  // 1,创建EventChannel，注册“包名/标识符”的channel名
  static const EventChannel _channel = const EventChannel("com.example.flutter_web_plugin/event_channel");

  late StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    _enableEventReceiver();
  }

  @override
  void dispose() {
    super.dispose();
    _disableEventReceiver();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterWebPlugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child:

          /*Column(
            children: <Widget>[

              Text('Running on: $_platformVersion\n'),

              WebView( onWebViewViewCreated: _onWebViewCreated),



              ElevatedButton(
                onPressed: () {
                  showToast();
                },
                child: Text('点击'),
              )
            ],
          ),*/

          AndroidWebView( onWebViewViewCreated: _onWebViewCreated),

        ),
      ),
    );
  }

  showToast() async {
    await FlutterWebPlugin.showToast("url====12345678");
  }

  void _disableEventReceiver() {
    if (_streamSubscription != null) {
      //  3,调用StreamSubscriptoin#cancel时，监听被取消。
      _streamSubscription?.cancel();
      _streamSubscription = null;
    }
  }

  void _enableEventReceiver() {
    // 2,通过StreamSubscription#listen注册listener，其中cancelOnError参数表示遇到错误时是否自动结束监听
    _streamSubscription = _channel.receiveBroadcastStream().listen((dynamic event) {
      print('=================== 接收信息 =================');
      print('======= Received event: $event');
      setState(() {
        _platformVersion = event.toString();
      });
    }, onError: (dynamic error) {
      print('======= Received error: ${error.message}');
    }, cancelOnError: true);
  }


  void _onWebViewCreated(WebViewController controller) {

    controller.setUrl('https://oceanex.pro/zh/m/captcha');
  }
}










