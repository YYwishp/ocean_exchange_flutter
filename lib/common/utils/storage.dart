import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  /*/// 静态私有实例对象
  static final _instance=StorageUtil._init();
  /// 工厂构造函数 返回实例对象
  factory StorageUtil()=>_instance;
  /// SharedPreferences对象
  static SharedPreferences? _storage;


  /// 命名构造函数 用于初始化SharedPreferences实例对象
  StorageUtil._init(){
    _initStorage();
  }
  // 之所以这个没有写在 _init中，是因为SharedPreferences.getInstance是一个异步的方法 需要用await接收它的值
  _initStorage()async{
    // 若_不存在 则创建SharedPreferences实例
    if(_storage==null)
      _storage=await SharedPreferences.getInstance();
  }*/

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  StorageUtil._privateConstructor();

  static final _instance = StorageUtil._privateConstructor();

  /* 单例 调用 */
  factory StorageUtil() => _instance;

  static SharedPreferences? _prefs;

  /*初始化*/
  Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  ///
  /// 存数据
  ///
  Future<bool>? savePreference(String key, Object value) {
    if (value is int) {
      return _prefs?.setInt(key, value);
    } else if (value is double) {
      return _prefs?.setDouble(key, value);
    } else if (value is bool) {
      return _prefs?.setBool(key, value);
    } else if (value is String) {
      return _prefs?.setString(key, value);
    } else if (value is List<String>) {
      return _prefs?.setStringList(key, value);
    } else {
      throw new Exception("不能 存储 这种类型");
    }
  }

  ///
  ///
  /// 取数据
  ///
  ///
  getPreference(String key, Object defaultValue) {
    if (defaultValue is int) {
      print('int');
      return _prefs?.getInt(key);
    } else if (defaultValue is double) {
      print('double');
      return _prefs?.getDouble(key);
    } else if (defaultValue is bool) {
      print('bool');
      return _prefs?.getBool(key);
    } else if (defaultValue is String) {
      print('string');
      return _prefs?.getString(key);
    } else if (defaultValue is List) {
      print('List');

      return _prefs?.getStringList(key);
    } else {
      throw new Exception("不能 得到 这种类型");
    }
  }

  /// 删除指定数据
  void remove(String key) async {
    _prefs?.remove(key); //删除指定键
  }

  /// 清空整个缓存
  void clear() async {
    _prefs?.clear(); ////清空缓存
  }

  ///
  ///存储  List<Object> phoneList
  ///List<Object> phoneList
  ///
  void setSelectBeanList(List<Object> list, String key) async {
    String jsonStringA = jsonEncode(list);
    print("jsonStringA   --------- >" + jsonStringA);
    _prefs?.setString(key, jsonStringA);
  }

  ///
  /// 获取  List<Object> phoneList
  /// List<Object> phoneList
  ///
  Future getSelectBean(String key) async {
    String? getdata = _prefs?.getString("data");
    if (getdata == null) {
      return null;
    } else {
      List list = json.decode(getdata);
      return list;
    }
  }

//
// /***
//  *
//  * 存数据
//  *
//  */
//
// static Object savePreference(String key, Object value) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (value is int) {
//     await prefs.setInt(key, value);
//   } else if (value is double) {
//     await prefs.setDouble(key, value);
//   } else if (value is bool) {
//     await prefs.setBool(key, value);
//   } else if (value is String) {
//     await prefs.setString(key, value);
//   } else if (value is List<String>) {
//     await prefs.setStringList(key, value);
//   } else {
//     throw new Exception("不能得到这种类型");
//   }
// }
//
// /***
//  *
//  * 取数据
//  *
//  *
//  */
// static Future getPreference<T>(String key) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (T is int) {
//     return prefs.getInt(key);
//   } else if (T is double) {
//     return prefs.getDouble(key);
//   } else if (T is bool) {
//     return prefs.getBool(key);
//   } else if (T is String) {
//     return prefs.getString(key);
//   } else if (T is List<String>) {
//     return prefs.getStringList(key);
//   } else {
//     throw new Exception("不能得到这种类型");
//   }
// }
//
// /***
//  * 删除指定数据
//  */
// static void remove(String key) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.remove(key); //删除指定键
// }
//
// /***
//  * 清空整个缓存
//  */
// static void clear() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.clear(); ////清空缓存
// }
//
// /**
//  * 3.存储账本bookBean的list
//  *
//  * List<Object> phoneList
//  */
// static void setSelectBean(
//     BuildContext context, Object bean, String key) async {
//   List<Object> phoneList = [];
//   phoneList.add(bean);
//   String jsonStringA = jsonEncode(phoneList);
//   print("jsonStringA   --------- >" + jsonStringA);
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString(key, jsonStringA);
// }
//
// /**
//  * 存储  List<Object> phoneList
//  *
//  * List<Object> phoneList
//  */
// static void setSelectBeanList(List<Object> phoneList, String key) async {
//   String jsonStringA = jsonEncode(phoneList);
//   print("jsonStringA   --------- >" + jsonStringA);
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString(key, jsonStringA);
// }
//
// /**
//  * 获取  List<Object> phoneList
//  *
//  * List<Object> phoneList
//  */
// static Future getSelectBean(String key) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String getdata = (await prefs.getString("data"))!;
//   List list = json.decode(getdata);
//   return list;
// }
}
