import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_exchange_flutter/common/model/list_bean.dart';
import 'package:ocean_exchange_flutter/common/model/login_response.dart';
import 'package:ocean_exchange_flutter/common/routes/routes.dart';
import 'package:ocean_exchange_flutter/common/utils/OceanApi.dart';
import 'package:ocean_exchange_flutter/global/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
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

    _userPasswordController = TextEditingController();

    _userEmailController = TextEditingController();
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
        backgroundColor: Color(0xff101418),
        //状态栏 文字颜色 For example, the color might be dark grey, requiring white text.
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: ScreenUtil().screenHeight,
          //背景色
          color: Color(0xff101418),
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
                    color: Colors.white,
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
                  unselectedLabelColor: Colors.white,
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
                            style: TextStyle(color: Colors.white),

                            controller: _userEmailController,
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
                            style: TextStyle(color: Colors.white),
                            controller: _userPasswordController,
                            //输入模式，邮件
                            keyboardType: TextInputType.text,
                            // controller: _userPasswordController,
                            //输入内容，隐藏
                            obscureText: passwordVisible,
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
                              hintText: '密码',
                              hintStyle: TextStyle(
                                color: Color(0xff42495b),
                                fontSize: 14,
                              ),

                              // enabledBorder: ,
                              //下面是重点
                              suffixIcon: IconButton(
                                icon: Icon(
                                  //根据passwordVisible状态显示不同的图标
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
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
                                margin: EdgeInsets.only(
                                    left: 20, top: 20, right: 20, bottom: 0),
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    print('启动登陆');
                                    _emailLogin();
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

  _emailLogin() async {
    var params = {
      'account': 'yywishp@gmail.com',
      'account_type': 'email',
      'password': 'Gyx12345678',
      'application_id': RECAPTURE_APP_ID(),
      'device_id': Constants.DEVICE_ID
    };
    // 这么用是 表单类型 contentType ：multipart/form-data
    // var formData = FormData.fromMap(params);

    print(params);
    print(params.toString());

    var loginResponse = await OceanApi.login(context: context, params: params);
    switch (loginResponse.code) {
      case 0:
        break;

      case 1:
        break;
      case 8:
        break;
      case 4:
        break;
      case 1242:
        break;
      case 1222:
        break;
      case 1212:
        _checkCaptcha('tencent');

        break;

      case 1213:
        _checkCaptcha('google');




        break;

      default:
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



  _checkCaptcha(String captchaType){
    switch (captchaType) {
      case 'tencent':

        Navigator.pushNamed(context, Routes.captchaPage,arguments: {'type':'tencent'});

        break;
       case 'google':
         Navigator.pushNamed(context, Routes.captchaPage,arguments: {'type':'google'});

         break;

    }


  }

}
