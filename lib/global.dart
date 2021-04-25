import 'package:ocean_exchange_flutter/common/utils/storage.dart';

import 'common/bean/user.dart';

/// 全局配置
class Global {


  /// 用户配置
  static UserLoginResponseEntity profile = UserLoginResponseEntity(
    accessToken: null, channels: [],
  );





  ///
  /// 判断当前运行环境
  /// 当App运行在Release环境时 为true
  /// 当App运行在Debug和Profile环境时 为false
  ///
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static Future init() async{

    // 工具初始
    await StorageUtil().init();
  }
}