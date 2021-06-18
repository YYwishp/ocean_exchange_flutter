import 'dart:async';

import 'package:flutter/services.dart';

class FlutterWebPlugin {
  static const METHOD_CHANNEL = "com.example.flutter_web_plugin/method_channel";

  static const MethodChannel _channel =
      const MethodChannel(METHOD_CHANNEL);


  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 弹出 Toast
  static Future<String> showToast(String string) async {


    // 传递参数给 native
    final Map params = <String,dynamic>{
      'messages':string,
    };



    String formNativeMsg = await _channel.invokeMethod("showToast",params);

    return formNativeMsg;


  }
}
