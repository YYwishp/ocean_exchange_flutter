import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ocean_exchange_flutter/common/model/funds_entity.dart';
import 'package:ocean_exchange_flutter/common/model/legal_tenders_entity.dart';
import 'package:ocean_exchange_flutter/common/model/login_response.dart';
import 'package:ocean_exchange_flutter/common/model/verifycode_response.dart';
import 'package:ocean_exchange_flutter/global/url_constant.dart';
import 'package:ocean_exchange_flutter/res/constant.dart';

import 'HttpUtil.dart';

//定义枚举类型
enum HostServer {
  PRO,
  CC,
}

String getServerApiHost() {
  if (HOST == HostServer.CC) {
    return "https://auth.oceanex.cc";
  } else {
    return "https://auth.oceanex.pro";
  }
}

const String ENGINE_API_VERSION = '/api/v2/';
const String ENGINE_GOOGLE_CDN = "https://pc2f86w9.oceanex.pro$ENGINE_API_VERSION";
const String ENGINE_GOOGLE = "https://engine.oceanex.pro$ENGINE_API_VERSION";

///
String ENGINE_HOST = ENGINE_GOOGLE_CDN;

/// 切换 Host
/// 先走 "pc2f86w9.oceanex.pro"
/// 不通后，
/// 再走 "engine.oceanex.pro"
void switchEngineHost() => ENGINE_HOST = ENGINE_GOOGLE;

String getEngineApiHost() {
  if (HOST == HostServer.CC) {
    return "https://engine.oceanex.cc$ENGINE_API_VERSION";
  } else {
    return ENGINE_HOST;
  }
}


///
/// 获取 法币汇率
///
String getWhaleHost(){
  if (HOST == HostServer.CC) {
    return "https://whale.oceanex.cc";
  } else {
    return "https://whale.oceanex.pro";
  }
}










///
///  接口
///
class OceanApi {
  static Future<LoginResponse> sessionsV2({
    required BuildContext context,
    Object? params,
  }) async {
    var response = await HttpUtil().post(
      '/api/v2/sessions',
      context: context,
      params: params,
    );

    // print(string);
    return LoginResponse.fromJson(response);
  }

  static Future<VerifycodeResponse> sendVerifyEmail({
    required BuildContext context,
    Object? params,
  }) async {
    var response = await HttpUtil().post(
      '/api/v1/security/send_email_verification_code',
      context: context,
      params: params,
    );

    // print(string);
    return VerifycodeResponse.fromJson(response);
  }

  /// 请求汇率
  ///
  ///
  ///
  ///
  //<editor-fold desc="====请求汇率">
  static Future<Map<String,dynamic>> requestPrice({
    required BuildContext context,
    Object? params,
  }) async {
    var response = await HttpUtil().get(
      '${getEngineApiHost()}currency/prices',
      context: context,
      params: params,
    );
    // print('======='+response.toString());

    return response;
  }

  //</editor-fold>

  static Future<FundsEntity> membersMe({
    required BuildContext context,
    Object? params,
  }) async {
    var options = Options(headers: {'Authorization': "Bearer ${Constant.TOKEN}"});
    // var options = Options(headers: {'Authorization': "Bearer sdfdsfasdfsdfsdfadsf "});

    var response = await HttpUtil().get(
      '${getEngineApiHost()}members/me',
      context: context,
      params: params,
      options: options,
    );
    // print('======='+response.toString());

    return FundsEntity.fromJson(response);
  }


  ///
  /// 获取 法币汇率
  ///
  static Future<LegalTendersEntity> legalTenders({
    required BuildContext context,
    Object? params,
  }) async {
    // var options = Options(headers: {'Authorization': "Bearer ${Constant.TOKEN}"});

    var response = await HttpUtil().get(
      '${getWhaleHost()}/info/legal_tenders',
      context: context,
      params: params,
      // options: options,
    );
    // print('======='+response.toString());

    return LegalTendersEntity.fromJson(response);
  }






}
