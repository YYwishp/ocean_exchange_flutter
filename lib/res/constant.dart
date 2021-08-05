import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:ocean_exchange_flutter/common/model/legal_tenders_entity.dart';
import 'package:uuid/uuid.dart';

///
///
/// 常量
///
///
class Constant{
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction  = kReleaseMode;


  static bool isDriverTest  = false;
  static bool isUnitTest  = false;


  static const String theme = 'AppTheme';
  static const String locale = 'locale';

  static const String uuid = 'uuid';
  static const String email = 'email';
  static const String token = 'token';
  static const String sn = 'sn';
  static const String legal_tender= 'legal_tender';


  //=================================================

  // 保存 法币汇率 集合
  static List<Data> legalTenders =[];
  // 保存 法币类型 code :USD
  static String current_LegalTender = '';




  static String DEVICE_ID = "";
  static String? TOKEN = '';
  static String _EMAIL = '';

  static set EMAIL(String value){
    _EMAIL = value;
    SpUtil.putString(Constant.email, value);

  }

  static String get EMAIL{
    if(_EMAIL.isEmpty){
      _EMAIL = SpUtil.getString(Constant.email)!;
    }
    return _EMAIL;
  }



  //=========================================================================================




  static configUUID() {
    if (DEVICE_ID.isEmpty) {
      DEVICE_ID = Uuid().v4();


      SpUtil.putString(Constant.uuid, DEVICE_ID);
    } else {
      DEVICE_ID = SpUtil.getString(Constant.uuid)!;
    }
  }



  ///
  /// 保存 法币汇率
  ///
  static void setLegalTenders(List<Data>? list ){

    if(list!=null){
      legalTenders.clear();
      legalTenders.addAll(list);
    }
  }

  ///
  /// 获取汇率
  ///
  static Data? findLegalTenders(String code){

    Data? temp;
    for (var value in legalTenders) {
      if (value.code==code) {
        temp = value;
        break;
      }
    }

    return temp;

  }

  ///
  /// 是否登陆
  ///
  static bool isLogin(){
    Constant.TOKEN = SpUtil.getString(Constant.token);

    return Constant.TOKEN!.isNotEmpty;
  }














}