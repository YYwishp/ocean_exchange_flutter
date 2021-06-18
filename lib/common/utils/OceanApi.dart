import 'package:flutter/cupertino.dart';
import 'package:ocean_exchange_flutter/common/model/login_response.dart';
import 'package:ocean_exchange_flutter/global/constants.dart';

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



///
///  接口
///
class OceanApi {


  static Future<LoginResponse> login({
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
}
