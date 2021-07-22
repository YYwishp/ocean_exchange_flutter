import 'dart:async';
import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as flutter_screenutil;
import 'package:ocean_exchange_flutter/net/OceanApi.dart';
import 'package:ocean_exchange_flutter/generated/l10n.dart';
import 'package:ocean_exchange_flutter/global/url_constant.dart';
import 'package:ocean_exchange_flutter/res/colors.dart';
import 'package:ocean_exchange_flutter/res/constant.dart';
import 'package:ocean_exchange_flutter/routes/routes.dart';
import 'package:ocean_exchange_flutter/widget/toast.dart';
import 'package:ocean_exchange_flutter/common/utils/theme_utils.dart';

///
/// 登录界面
///
///
///
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late TextEditingController _userPasswordController;
  late TextEditingController _userEmailController;

  var passwordVisible = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );

    _userPasswordController = TextEditingController(text: 'Gyx12345678');

    _userEmailController = TextEditingController(text: 'yywishp@gmail.com');
  }

  ///生命周期函数
  @override
  void dispose() {
    super.dispose();

    //最后销毁
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var screenHeight = ScreenUtil.getInstance().screenHeight;
    // var screenWidth = ScreenUtil.getInstance().screenWidth;
    // var adapterSize = ScreenUtil.getInstance().getAdapterSize(640);
    //
    //
    // print('===屏幕高度 $screenHeight  屏幕宽度 $screenWidth ----640大小 $adapterSize  ');
    //
    //
    // final physicalWidth = window.physicalSize.width;
    // final physicalHeight = window.physicalSize.height;
    // print('分辨率: $physicalWidth * $physicalHeight');
    //
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    //
    // print('分辨率222: $width * $height');
    //
    // final dpr = window.devicePixelRatio;
    // print("dpr: $dpr");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // backgroundColor: Color(0xff101418),
        //状态栏 文字颜色 For example, the color might be dark grey, requiring white text.
        // brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: flutter_screenutil.ScreenUtil().screenHeight,
          //背景色
          // color: Color(0xff101418),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
                child: Text(
                  '登录',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    // backgroundColor: Colors.blueAccent,
                    // color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.topStart,
                margin: EdgeInsets.only(left: 20),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: Color(0xff0074ff),
                  labelColor: Color(0xff0074ff),
                  labelPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  unselectedLabelColor: context.isDark ? Colours.dark_text : Colors.black,
                  //指示器 厚度
                  indicatorWeight: 1,
                  //指示器与文字等宽
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      text: '邮箱',
                    ),
                    Tab(
                      text: '手机',
                    ),
                  ],
                ),
              ),
              Container(
                height: 300.h,
                child: TabBarView(
                  //注意一定要加上
                  controller: _tabController,
                  children: [
                    //邮箱登陆 界面
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        //邮箱
                        Container(
                          child: TextFormField(
                            style: TextStyle(
                              color: context.isDark ? Colors.white : Colors.black,
                            ),

                            controller: _userEmailController,

                            onChanged: (value) {
                              // _userEmailController.text = value;
                            },

                            //输入模式，邮件
                            keyboardType: TextInputType.emailAddress,
                            // controller: _userPasswordController,
                            //输入内容，隐藏
                            // obscureText: passwordVisible,
                            decoration: InputDecoration(
                              //内容文字的 内部填充/边距
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 20,
                              ),

                              // border: OutlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.red)
                              // ),
                              //未选中时候的颜色
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff222529),
                                ),
                              ),
                              //选中时外边框颜色
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff42495b),
                                ),
                              ),

                              // labelText: '密码',
                              hintText: '邮箱',
                              hintStyle: TextStyle(
                                color: Color(0xff42495b),
                                fontSize: 14,
                              ),

                              // enabledBorder: ,
                              //下面是重点
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.cancel_rounded,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  /*setState(() {
                                        _userEmailController.text = '';
                                      });*/
                                  _userEmailController.text = '';
                                },
                              ),
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        ),

                        //密码
                        Container(
                          child: TextFormField(
                            // 正则 开头大写，8到20个字符
                            // inputFormatters: [
                            //   WhitelistingTextInputFormatter(RegExp("[a-zA-Z]{8,20}\$"))
                            // ],
                            style: TextStyle(color: context.isDark ? Colors.white : Colors.black),
                            controller: _userPasswordController,

                            //输入模式，邮件
                            keyboardType: TextInputType.emailAddress,
                            // controller: _userPasswordController,
                            //输入内容，隐藏
                            obscureText: passwordVisible,

                            onChanged: (value) {
                              // _userPasswordController.text = value;
                            },

                            decoration: InputDecoration(
                              //内容文字的 内部填充/边距
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 20,
                              ),

                              // border: OutlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.red)
                              // ),
                              //光标未选中时，边框的颜色
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff222529),
                                  // color: Colors.red,
                                ),
                              ),
                              //光标选中时，外边框颜色
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff42495b),
                                ),
                              ),

                              // labelText: '密码',
                              hintText: '密码',
                              hintStyle: TextStyle(
                                color: Color(0xff42495b),
                                fontSize: 14,
                              ),

                              // enabledBorder: ,
                              //位于输入框后面的图片,例如一般输入框后面会有个眼睛，控制输入内容是否明文
                              suffixIcon: IconButton(
                                icon: Icon(
                                  //根据passwordVisible状态显示不同的图标
                                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  //更新状态控制密码显示或隐藏
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    print('启动登陆');

                                    if (_userEmailController.text.isEmpty || _userPasswordController.text.isEmpty) {
                                      // 错误提示
                                      toastInfo(msg: "邮箱或密码，不能为空");
                                    } else {
                                      // 错误提示
                                      // toastInfo(msg: "邮箱${_userEmailController.text}，密码：${_userPasswordController.text}");
                                      var params = {
                                        'account': _userEmailController.text,
                                        'account_type': 'email',
                                        'password': _userPasswordController.text,
                                        'application_id': RECAPTURE_APP_ID(),
                                        'device_id': Constant.DEVICE_ID
                                      };

                                      ///第一次调用的地方，
                                      _getSessions2(params);
                                    }
                                  },
                                  child: Text('登录'),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                    //手机登陆 界面
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: RaisedButton(
                            child: Text('手机登陆'),
                            color: Colors.white,
                            textTheme: ButtonTextTheme.primary,
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///  请求接口
  _getSessions2(Map<String, String> params) async {
    // 这么用是 表单类型 contentType ：multipart/form-data
    // var formData = FormData.fromMap(params);

    print(params);
    print(params.toString());
    EasyLoading.show(status: 'Loading', dismissOnTap: false);

    var loginResponse = await OceanApi.sessionsV2(context: context, params: params);
    switch (loginResponse.code) {
      // 登录成功
      case 0:
        toastInfo(msg: S.of(context).login_successfully);
        var map = loginResponse.data!.toJson();

        SpUtil.putString(Constant.email, _userEmailController.text);

        var token = map['token'];

        print('----token :$token');
        SpUtil.putString(Constant.token, token);

        EasyLoading.dismiss();

        Navigator.of(context).pop();
        break;

      case 1:
        toastInfo(msg: '${loginResponse.message}');
        EasyLoading.dismiss();

        break;
      //  被锁住
      case 8:
        toastInfo(msg: 'Account has been locked,please try 2 hours later.');
        EasyLoading.dismiss();
        break;
      //  手机验证
      case 4:
        break;
      //  邮箱验证
      case 1242:

        ///去 邮箱验证界面
        Navigator.pushNamed(context, Routes.verifyCodePage, arguments: {'email': '${_userEmailController.text}'})
            .then((value) {
          value as Map;

          // 拿到验证码
          var emailParams = {
            'account': _userEmailController.text,
            'account_type': 'email',
            'password': _userPasswordController.text,
            'application_id': RECAPTURE_APP_ID(),
            'device_id': Constant.DEVICE_ID,
            'email_code': value['code'] as String
          };

          emailParams.addAll({'device_trust': value['isChecked'].toString()});

          _getSessions2(emailParams);

          // EasyLoading.dismiss();
        });

        break;
      //  otp 验证
      case 1222:
        break;
      //  google 验证
      case 1212:
        EasyLoading.dismiss();
        print('--- google 验证');
        _checkCaptcha('google');

        break;
      //  腾讯 验证
      case 1213:
        EasyLoading.dismiss();
        print('--- 腾讯 验证');
        _checkCaptcha('tencent');

        break;

      case 1223:
      case 1224:

      case 1233:
      case 1234:
      case 1235:

      case 1243:
      case 1244:
      case 1245:
        toastInfo(msg: '${loginResponse.message}');
        EasyLoading.dismiss();

        break;

      default:
        toastInfo(msg: '${loginResponse.message}');
        EasyLoading.dismiss();

        break;
    }

    /*String jsonStr12 = '{"data": [{"type": 1,"total": 0,"detail": "今天有0位客人哟..."},{"type": 2,"total": 0,"detail": "今天有0位客人..."}],"error": {"message": "执行成功","code": 1}}';

    // ListBean decode = json.decode(jsonStr12);

    Map<String, dynamic> news = jsonDecode(jsonStr12);
    Map<String, dynamic> decode = json.decode(jsonStr12);

    print("--- ${news['data']}");


    var listBean = ListBean.fromJson(jsonDecode(jsonStr12));
    List<Data_> data = listBean.data;
    for (var value in data) {
      print('=== ${value.toJson()}');
    }*/
  }

  ///邮箱验证，结束后，就是正常登陆拿到token
  _checkCaptcha(String captchaType) {
    Navigator.pushNamed(context, Routes.captchaPage, arguments: {'type': captchaType}).then((value) {
      print('==========  $value');
      if (value == null) {
        return;
      }

      value as Map;
      String type = value['type'] as String;
      var event = value['event'];

      // 这里必须要这么写，否则json无法解析,缺少双引号

      String jsonMap = jsonEncode(event);
      print('jsonMap === $jsonMap');
      Map decode = json.decode(jsonMap);

      switch (type) {
        case 'tencent':
          String ticket = decode['ticket'];
          String randstr = decode['randstr'];

          var params = {
            'account': 'yywishp@gmail.com',
            'account_type': 'email',
            'password': _userPasswordController.text,
            'application_id': RECAPTURE_APP_ID(),
            'device_id': Constant.DEVICE_ID,
            'recaptcha_type': 'tencent',
            'tx-recaptcha-response': ticket,
            'tx-randstr': randstr,
          };

          _getSessions2(params);

          break;

        case 'google':
          String ticket = decode['ticket'];

          var params = {
            'account': 'yywishp@gmail.com',
            'account_type': 'email',
            'password': _userPasswordController.text,
            'application_id': RECAPTURE_APP_ID(),
            'device_id': Constant.DEVICE_ID,
            'recaptcha_type': 'google',
            'g-recaptcha-response': ticket,
          };

          _getSessions2(params);

          break;
      }
    });
  }
}
