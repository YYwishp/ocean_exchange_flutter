import 'package:ocean_exchange_flutter/common/utils/HttpUtil.dart';
import 'package:ocean_exchange_flutter/common/utils/storage.dart';
import 'package:ocean_exchange_flutter/global/constants.dart';


/// 全局配置
class Global {








  ///
  /// 判断当前运行环境
  /// 当App运行在Release环境时 为true
  /// 当App运行在Debug和Profile环境时 为false
  ///
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static Future init() async{

    // 工具初始
    await StorageUtil().init();

    Constants.configUUID();

    HttpUtil().init();






  }
}