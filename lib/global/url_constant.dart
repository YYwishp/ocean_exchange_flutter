import 'package:flustars/flustars.dart';
import 'package:ocean_exchange_flutter/net/OceanApi.dart';
import 'package:ocean_exchange_flutter/common/utils/storage.dart';
import 'package:ocean_exchange_flutter/global/Global.dart';
import 'package:ocean_exchange_flutter/res/constant.dart';
import 'package:uuid/uuid.dart';

const SERVER_API_URL = 'https://yapi.ducafecat.tech/mock/11';
const HOST = HostServer.CC;

var LANG = "en";
const PLATFORM = "android";

String RECAPTURE_APP_ID() {
  if (Constant.inProduction) {
    return "0dfbd5cac4f396b758985eb8d22ba453e223ffac226ae84671b7ea87d7778cfc";
  } else {
    return "0dfbd5cac4f396b758985eb8d22ba453e223ffac226ae84671b7ea87d7778cfc";
  }
}


String CAPTCHA_TENCENT_URL() {
  if (Constant.inProduction) {
    return "https://oceanex.pro/m/captchaTencent";
  } else {
    return  "https://oceanex.cc/m/captchaTencent";
  }
}


String CAPTCHA_GOOGLE_URL() {
  if (Constant.inProduction) {
    return "https://oceanex.pro/m/captcha";
  } else {

    return  "https://oceanex.cc/m/captcha";
  }
}









