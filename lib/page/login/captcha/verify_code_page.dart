import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_exchange_flutter/net/OceanApi.dart';
import 'package:ocean_exchange_flutter/widget/CountDownButton.dart';
import 'package:ocean_exchange_flutter/widget/CountDownButton.dart';
import 'package:ocean_exchange_flutter/widget/toast.dart';



///
/// 邮件验证码 界面
///
///
///
class VerifyCodePage extends StatefulWidget {
  final arguments;

  VerifyCodePage({this.arguments});

  @override
  _VerifyCodePageState createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  late Timer? timer2;

  bool isChecked = false;

  GlobalKey<CountDownButtonState> textKey = GlobalKey();

  @override
  void initState() {
    sendVerifyEmail();
    super.initState();
  }

  @override
  void dispose() {
    // timer2?.cancel();
    // timer2 = null;
    super.dispose();
  }

  void sendVerifyEmail() {
    EasyLoading.show(status: 'Loading', dismissOnTap: true);
    var email = widget.arguments['email'];
    var params = {
      'email': email,
    };
    // var verifycodeResponse = await OceanApi.sendVerifyEmail(context: context, params: params);
    // if(verifycodeResponse.code ==0){
    //   //开始倒计时
    //   textKey.currentState!.reGetCountdown();
    //   EasyLoading.dismiss(animation: true);
    //
    //
    //
    // }else{
    //   EasyLoading.dismiss(animation: false);
    //   toastInfo(msg: verifycodeResponse.message!);
    //
    //
    // }
    ///请求 发送 验证码
        OceanApi.sendVerifyEmail(context: context, params: params)
        .then((verifycodeResponse) {
      if (verifycodeResponse.code == 0) {
        //开始倒计时
        textKey.currentState!.reGetCountdown(context);
      } else {
        toastInfo(msg: verifycodeResponse.message!);
      }
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    // timer2 = Timer.periodic(Duration(seconds: 4), (timer) {
    //   print('当前时间11 ${DateTime.now()} ');
    //   sleep(Duration(seconds: 2));
    //
    //
    //
    //   print('当前时间22 ${DateTime.now()} ');
    // });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_outlined),
        ),
        title: Text("邮件验证码"),
        centerTitle: true,
      ),
      body: Container(
        height: ScreenUtil().screenHeight,
        //背景色
        // color: Color(0xff101418),
        child: Column(
          children: <Widget>[
            Text(
              '请输入你的注册邮箱收到的验证码（xxx@gmail.com）',
              textAlign: TextAlign.start,
              style: TextStyle(
                // backgroundColor: Colors.blueAccent,
                fontSize: 14,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    // width: 280,
                    padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      // style: TextStyle(color: Colors.white),
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
                      ),

                      onChanged: (value) {


                        if (value.length == 6) {
                          /// 返回到登录界面，然后，拿验证码，再请求接口登录

                          Navigator.of(context).pop({'code':value,'isChecked':isChecked});

                        }
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                  //倒计时 控件
                  child: CountDownButton(
                    key: textKey,
                    press: () {
                      // 调用自己的方法，重新倒计时
                      textKey.currentState!.reGetCountdown(context);
                      sendVerifyEmail();
                      // 重新请求 验证码
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 10,),

                Checkbox(
                  /*
                  /// If [fillColor] returns a non-null color in the [MaterialState.selected]
                  /// state, it will be used instead of this color.
                  /// 说人话，就是fillColor为空的时候，就用 activeColor替代
                  activeColor: Colors.deepPurpleAccent,
                  //打钩的颜色
                  checkColor: Colors.red,
                  //按下时，水波纹颜色
                  hoverColor: Colors.blue,

                  focusColor: Colors.green,
                  //填充色，选中时的颜色
                  // fillColor: MaterialStateProperty.all(Colors.tealAccent),
                  // 边框颜色
                  side: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.red,
                    // 边框粗细
                    width: 2,
                  ),

                  // 按下时，水波纹颜色 会覆盖 hoverColor
                  overlayColor: MaterialStateProperty.all(Colors.amberAccent),
                  // 变宽形状
                  shape: RoundedRectangleBorder(
                    // 圆角 弧度
                    borderRadius: BorderRadius.circular(5),
                  ),*/

                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Text(
                  '信任设备，30天内登录将不再需要安全验证',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


























}
