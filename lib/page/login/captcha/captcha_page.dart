import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocean_exchange_flutter/common/utils/theme_utils.dart';
import 'package:ocean_exchange_flutter/generated/l10n.dart';

import 'package:ocean_exchange_flutter/global/url_constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_web_plugin/web_view.dart' as web_view;

///
/// webview 网页滑动验证 界面
///
///
class CaptchaPage extends StatefulWidget {
  final arguments;

  CaptchaPage({this.arguments});

  @override
  _CaptchapageState createState() => _CaptchapageState();
}

class _CaptchapageState extends State<CaptchaPage> {
  late WebViewController _controller;
  var captchaUrl = '';
  late Widget currentWeb;

  // 1,创建EventChannel，注册“包名/标识符”的channel名
  static const EventChannel _channel =
      const EventChannel("com.example.flutter_web_plugin/event_channel");
  StreamSubscription? _streamSubscription;

  late String type;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();


      _enableEventReceiver();

    }



    type = widget.arguments['type'];

    switch (type) {
      case 'tencent':
        captchaUrl = CAPTCHA_TENCENT_URL();

        break;
      case 'google':
        captchaUrl = CAPTCHA_GOOGLE_URL();
        break;
    }

    print('============初始化 $captchaUrl');

    currentWeb = _getWebViewByPlatform(captchaUrl, false);
    // currentWeb = _getWebViewByPlatform("https://oceanex.pro/m/captchaTencent", false);
    // currentWeb = _getWebViewByPlatform("https://oceanex.cc/m/captcha", false);
  }

  @override
  void dispose() {
    super.dispose();

    _disableEventReceiver();
  }

  /// 最后 监听被取消
  void _disableEventReceiver() {
    if (_streamSubscription != null) {
      //  3,调用StreamSubscriptoin#cancel时，监听被取消。
      _streamSubscription?.cancel();
      _streamSubscription = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // var captchaUrl = '';

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xff101418),
        // elevation: 0.5,
        // brightness: Brightness.dark,
        // systemOverlayStyle:SystemUiOverlayStyle.dark,
        // systemOverlayStyle:SystemUiOverlayStyle.light,
        // AppBarTheme.brightness

        leading: IconButton(
          color: ThemeUtils.getIconColor(context),
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('人机验证'),

      ),
      body: Container(
        // color: Color(0xff101418),
        child: Column(
          children: <Widget>[
            Expanded(
              child: currentWeb,
              // child: _getWebViewByPlatform(captchaUrl),
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
                        String captcha_tencent_url = CAPTCHA_TENCENT_URL();

                        String captcha_google_url = CAPTCHA_GOOGLE_URL();
                        if (captchaUrl == captcha_tencent_url) {
                          captchaUrl = captcha_google_url;
                          type = 'google';
                        } else {
                          captchaUrl = captcha_tencent_url;
                          type = 'tencent';
                        }
                        print('------ 改变后Url $captchaUrl');
                        currentWeb = _getWebViewByPlatform(captchaUrl, true);

                        setState(() {});
                      },
                      child: Text('切换验证方式'),
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

  /// 根据 不同平台调用 不同的webview
  Widget _getWebViewByPlatform(String captchaUrl, bool isChange) {
    GlobalKey<_CaptchapageState> webviewKey = GlobalKey();
    if (Platform.isIOS) {
      print('----- 当前 --- Url $captchaUrl');
      return WebView(
        key: webviewKey,
        initialUrl: captchaUrl,
        //JS执行模式 是否允许JS执行
        javascriptMode: JavascriptMode.unrestricted,

        onWebViewCreated: (controller) {
          _controller = controller;
        },

        // onPageFinished: (url) {
        //   _controller.evaluateJavascript("callbackHandler").then((result) {
        //     print('==== flutter 调用 js  $result');
        //   });
        // },

        javascriptChannels: [
          JavascriptChannel(
              name: 'callbackHandler', //handleName
              onMessageReceived: (JavascriptMessage message) {

                //接收到js返回的数据 不是json格式的，是要通过截取获取的
                /*{
                  appid = 2042983730;
                  randstr = "@0jj";
                  ret = 0;
                  ticket = "t03WJecAHCDhfTafo3nRdm0p0isy7fkPMLuWF7sr3Zd7ggoQoSJNodIwV332EIhvkaNCeJChg9oep8kFJrebZGBMI4WowsQBX9tgF8kG3WaLvg*";
                }*/

                String source= message.message;

                switch (type) {
                  case "google":


                    var event = {'randstr':'null','ticket':source};
                    var map = {'type': type, 'event':event};
                    // print('$map');

                    Navigator.of(context).pop(map );



                    break;
                  case "tencent":


                    List<String> split = source.split(';');
                    print('=== split:$split');

                    var randstr = split.singleWhere((element) {
                       return element.contains('randstr');
                    } ).trim();

                    // print('----where ${randstr}');

                    var indexOf_randstr = randstr.indexOf('"');
                    var lastIndexOf_randstr = randstr.lastIndexOf('"');
                    // print('indexOf= $indexOf  lastIndexOf = $lastIndexOf');

                    var randstr_substring = randstr.substring(indexOf_randstr+1,lastIndexOf_randstr);

                    // print('----substring ${randstr_substring}');

                    var ticket = split.singleWhere((element) {
                      return element.contains('ticket');
                    } ).trim();
                    // print('----where1 ${ticket}');

                    var indexOf_ticket = ticket.indexOf('"');
                    var lastIndexOf_ticket = ticket.lastIndexOf('"');
                    // print('indexOf= $indexOf_ticket  lastIndexOf = $lastIndexOf_ticket');

                    var ticket_substring = ticket.substring(indexOf_ticket+1,lastIndexOf_ticket);
                    // print('----ticket_substring ${ticket_substring}');
                    var event = {'randstr':randstr_substring,'ticket':ticket_substring};
                    var map = {'type': type, 'event':event};
                    // print('$map');

                    Navigator.of(context).pop(map );


                    break;
                }



              })
        ].toSet(),

        // onPageFinished: (url) {},
      );
    } else {
      print('android :自定义插件');
      // return web_view.AndroidWebView(onWebViewViewCreated: _onWebViewCreated);
      return web_view.AndroidWebView(
        key: webviewKey,
        onWebViewViewCreated: (controller) {
          print('----- 当前Url $captchaUrl');
          controller.setUrl(captchaUrl);
        },
      );
    }
  }

  ///  启用 EventChannel 监听 JavaScript 返回的数据
  void _enableEventReceiver() {
    // 2,通过StreamSubscription#listen注册listener，其中cancelOnError参数表示遇到错误时是否自动结束监听
    _streamSubscription =
        _channel.receiveBroadcastStream().listen((dynamic event) {
      print('=================== 接收信息 =================');
      print('===type:$type==== Received event: $event');

      Navigator.of(context).pop({'type': type, 'event': event});
    }, onError: (dynamic error) {
      print('======= Received error: ${error.message}');
    }, cancelOnError: true);
  }
}
