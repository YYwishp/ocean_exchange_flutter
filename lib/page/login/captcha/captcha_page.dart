import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:ocean_exchange_flutter/global/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_web_plugin/web_view.dart' as web_view;

class CaptchaPage extends StatefulWidget {
  final arguments;

  CaptchaPage({this.arguments});

  @override
  _CaptchapageState createState() => _CaptchapageState();
}

class _CaptchapageState extends State<CaptchaPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    var type = widget.arguments['type'];

    var captchaUrl = '';

    switch (type) {
      case 'tencent':
        captchaUrl = CAPTCHA_TENCENT_URL();

        break;
      case 'google':
        captchaUrl = CAPTCHA_GOOGLE_URL();
        break;
    }

    print('============ $captchaUrl');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff101418),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Color(0xff101418),
        child: Column(
          children: <Widget>[
            Expanded(
              child: _getWebViewByPlatform(captchaUrl),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 20, top: 20, right: 20, bottom: 40),
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        print('启动登陆');
                        // _emailLogin();
                      },
                      child: Text('登录'),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /**
   * 根据 不同平台调用 不同的webview
   */
  Widget _getWebViewByPlatform(String captchaUrl) {
    if (Platform.isIOS) {
      return WebView(
        initialUrl: captchaUrl,
        //JS执行模式 是否允许JS执行
        javascriptMode: JavascriptMode.unrestricted,

        onWebViewCreated: (controller) {
          _controller = controller;
        },

        onPageFinished: (url) {
          _controller.evaluateJavascript("callbackHandler").then((result) {
            print('==== flutter 调用 js  $result');
          });
        },

        javascriptChannels: [
          JavascriptChannel(
              name: 'callbackHandler', //handleName
              onMessageReceived: (JavascriptMessage message) {
                print('===== js 调用flutter : ${message.message}');
                //接收到js返回的数据
                //自定义处理
              })
        ].toSet(),

        // onPageFinished: (url) {},
      );
    } else {
      print('android :自定义插件');
      return web_view.AndroidWebView(onWebViewViewCreated: _onWebViewCreated);
    }
  }

  void _onWebViewCreated(web_view.WebViewController controller) {
    controller.setUrl('https://oceanex.pro/zh/m/captcha');
  }
}
