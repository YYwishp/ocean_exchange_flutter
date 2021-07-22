import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:ocean_exchange_flutter/global/url_constant.dart';
import 'package:ocean_exchange_flutter/res/constant.dart';
import 'package:ocean_exchange_flutter/widget/toast.dart';
import 'package:package_info/package_info.dart';

import '../global/Global.dart';
import 'OceanApi.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  CancelToken cancelToken = new CancelToken();
  late Dio dio;

  HttpUtil._internal();

  ///
  /// 第一步： 初始化，
  ///
  init() {
    getUserAgent().then((value) {
      // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
      BaseOptions options = BaseOptions(
        // 请求基地址,可以包含子路径
        baseUrl: getServerApiHost(),

        //连接服务器超时时间，单位是毫秒.
        connectTimeout: 10000,

        // 响应流上前后两次接受到数据的间隔，单位为毫秒。
        receiveTimeout: 5000,

        // Http请求头.
        headers: {
          "Accept-Language": LANG,
          "platform": PLATFORM,
          "user-agent": value,
        },

        /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
        /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
        /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
        /// 就会自动编码请求体.
        // contentType: 'application/json; charset=utf-8',
        // contentType: 'application/x-www-form-urlencoded',
        contentType: "application/x-www-form-urlencoded",

        /// [responseType] 表示期望以那种格式(方式)接受响应数据。
        /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
        ///
        /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
        /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
        ///
        /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
        responseType: ResponseType.json,
      );

      dio = Dio(options);

      // Cookie管理
      CookieJar cookieJar = CookieJar();
      // dio.interceptors.add(CookieManager(cookieJar));

      // 添加拦截器
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.next(options);
          },
          onResponse: (e, handler) {
            return handler.next(e);
          },
          onError: (e, handler) {
            ErrorEntity eInfo = createErrorEntity(e);
            // 错误提示
            toastInfo(msg: eInfo.message);

            // 错误交互处理
            var context = e.requestOptions.extra['context'];
            if (context != null) {
              switch (eInfo.code) {
                case 401: // 没有权限 重新登录
                  // goLoginPage(context);

                  print('==== 401 ====');
                  break;
                case 404:

                  print('连接超时 = ${e.requestOptions.path}');
                  // 404 符合情况，就切换host
                  if (e.requestOptions.path.contains('pc2f86w9')) {
                    switchEngineHost();

                  }

                  print('==== 404 ====');
                  break;
                default:
              }
            }

            return handler.next(e);
          },
        ),
      );
      // 日志拦截器
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));

      // 加内存缓存
      // dio.interceptors.add(NetCache());

      // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
      /*if (!Global.isRelease && PROXY_ENABLE) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY $PROXY_IP:$PROXY_PORT";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }*/

      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (cert, host, port) {
          return true;
        };
      };
    });
  }

  Future<String> getUserAgent() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String plantInfo;
    String brand;
    String model;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      plantInfo = "Android ${androidInfo.version.release}";
      brand = androidInfo.brand;
      model = androidInfo.model;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      plantInfo = "${iosInfo.systemName} ${iosInfo.systemVersion}";

      brand = 'apple';
      model = iosInfo.model;
    }

    return "OceanEx/$version ($packageName;build:$buildNumber;$plantInfo;${Constant.DEVICE_ID};$brand,$model) dio/4.0.0";
  }

  /*
   * error统一处理
   */
  // 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        {
          return ErrorEntity(code: -1, message: "请求取消");
        }
        break;
      case DioErrorType.connectTimeout:
        {
          print('连接超时 = ${error.requestOptions.path}');

          return ErrorEntity(code: -1, message: "连接超时");
        }
        break;
      case DioErrorType.sendTimeout:
        {
          return ErrorEntity(code: -1, message: "请求超时");
        }
        break;
      case DioErrorType.receiveTimeout:
        {
          return ErrorEntity(code: -1, message: "响应超时");
        }
        break;
      case DioErrorType.response:
        {
          try {
            int? errCode = error.response?.statusCode;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                {
                  return ErrorEntity(code: errCode, message: "请求语法错误");
                }
                break;
              case 401:
                {
                  SpUtil.remove(Constant.token);

                  Constant.TOKEN = null;

                  return ErrorEntity(code: errCode, message: "Token 过期请重新登录");
                }
                break;
              case 403:
                {
                  return ErrorEntity(code: errCode, message: "服务器拒绝执行");
                }
                break;
              case 404:
                {
                  return ErrorEntity(code: errCode, message: "无法连接服务器");
                }
                break;
              case 405:
                {
                  return ErrorEntity(code: errCode, message: "请求方法被禁止");
                }
                break;
              case 500:
                {
                  return ErrorEntity(code: errCode, message: "服务器内部错误");
                }
                break;
              case 502:
                {
                  return ErrorEntity(code: errCode, message: "无效的请求");
                }
                break;
              case 503:
                {
                  return ErrorEntity(code: errCode, message: "服务器挂了");
                }
                break;
              case 505:
                {
                  return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
                }
                break;
              default:
                {
                  // return ErrorEntity(code: errCode, message: "未知错误");

                  print('------- default');
                  return ErrorEntity(code: errCode, message: error.response?.statusMessage ?? "未知错误");
                }
            }
          } on Exception catch (_) {
            print('------- Exception');

            return ErrorEntity(code: -1, message: "未知错误");
          }
        }
        break;
      default:
        {
          print('------- other 错误');
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  // /// 读取本地配置
  // Map<String, dynamic> getAuthorizationHeader() {
  //   var headers;
  //   String? accessToken = Global.profile.accessToken;
  //   if (accessToken != null) {
  //     headers = {
  //       'Authorization': 'Bearer $accessToken',
  //     };
  //   }
  //   return headers;
  // }

  /// restful get 操作
  /// refresh 是否下拉刷新 默认 false
  /// noCache 是否不缓存 默认 true
  /// list 是否列表 默认 false
  /// cacheKey 缓存key
  /// cacheDisk 是否磁盘缓存
  Future get(
    String path, {
    required BuildContext context,
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(
      extra: {
        "context": context,
      },
    );

    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.copyWith(headers: _authorization);
    // }

    var response = await dio.get(
      path,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    // print('===response:=${response.requestOptions.path}');

    return response.data;
  }

  /// restful post 操作
  Future post(
    String path, {
    required BuildContext context,
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(
      extra: {
        "context": context,
      },
    );

    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.copyWith(headers: _authorization);
    // }

    var response = await dio.post(
      path,
      data: params,
      // options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}

// 异常处理
class ErrorEntity implements Exception {
  int? code;
  String message;

  ErrorEntity({required this.code, required this.message});

  String toString() {
    if (message == null) return "Exception";
    return "Exception: code $code, $message";
  }
}
