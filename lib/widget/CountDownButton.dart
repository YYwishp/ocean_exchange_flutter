import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ocean_exchange_flutter/common/utils/theme_utils.dart';

///  倒计时 按钮
class CountDownButton extends StatefulWidget {
  final String text;
  final VoidCallback? press;

  final Key key;

  final double width;
  final double height;

  const CountDownButton({
    required this.key,
    this.text = '',
    this.press,
    this.width = 80.0,
    this.height = 50.0,
  }) : super(key: key);

  @override
  CountDownButtonState createState() => CountDownButtonState();
}

class CountDownButtonState extends State<CountDownButton> {
  Timer? _countdownTimer;

  // String _codeCountdownStr = '获取验证码';
  String _codeCountdownStr = '获取';
  int _countdownNum = 10;
  VoidCallback? mPress;
  var color = Colors.black38;


  var isCountDowning = true;


  ///开启倒计时，不调用就不会自动倒计时
  void reGetCountdown(BuildContext context) {

    Color darkModelColor = context.isDark?Colors.white70:Colors.black38;

    if (_countdownTimer != null) {
      return;
    }
    // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
    setState(() {
      _codeCountdownStr = '${_countdownNum--}重新获取';
      color = darkModelColor;
    });


    _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownNum > 0) {
          isCountDowning = true;
          //不可点击
          mPress = null;
          color = darkModelColor;
          _codeCountdownStr = '${_countdownNum--}重新获取';
        } else {
          isCountDowning = false;
          _codeCountdownStr = '获取验证码';
          _countdownNum = 10;
          _countdownTimer?.cancel();
          _countdownTimer = null;
          color = Colors.blue;
          //重新点击
          mPress = widget.press;
        }
      });
    });
  }

  @override
  void initState() {
    // reGetCountdown();
    super.initState();

  }
  @override
  void didUpdateWidget(covariant CountDownButton oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    super.deactivate();
  }




  /// 不要忘记在这里释放掉Timer
  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var isDark = context.isDark;

    // 正在倒计时，需要判断是否黑暗模式，设置倒计时颜色
    if (isCountDowning) {
        color = context.isDark?Colors.white70:Colors.black38;
    }


    return Container(
      height: widget.height,
      // width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(140),
      ),
      child: ElevatedButton(

        style: ButtonStyle(
          // 边框粗细
          side: MaterialStateProperty.all(
              BorderSide(width: 2, color: color)),
          // 圆角 边框
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          //文字颜色
          foregroundColor: MaterialStateProperty.all(color),

          backgroundColor: MaterialStateProperty.all(isDark?Color(0xff101418):Colors.white),
          // 高亮色 按下的颜色
          overlayColor: MaterialStateProperty.all(Colors.orange),
          // 阴影 要和 elevation 配合使用
          /*shadowColor: MaterialStateProperty.all(Colors.red),
          elevation: MaterialStateProperty.all(10),*/
        ),

        onPressed: mPress,
        // onPressed: null,
        child: Text(_codeCountdownStr),
      ),
    );
  }


  // void onPressed(int count) {
  //   setState(() {
  //
  //   });
  // }
}
