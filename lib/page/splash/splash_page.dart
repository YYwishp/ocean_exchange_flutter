import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ocean_exchange_flutter/routes/routes.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this )
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('动画结束');
         Navigator.of(context).pop();
        
        Navigator.pushNamed(context, Routes.navigationBarPage);
        
        
        }
    });

  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
      designSize: Size(360, 690),
    );



    return MaterialApp(
      home: Scaffold(

        backgroundColor: Color(0xff000000),
        body: Center(
          child:
          Lottie.asset(
            'assets/file/launch.json',
            controller: _controller,
            onLoaded: (composition){
              _controller
                ..duration = composition.duration
                ..reset()
                ..forward();
            },

          )


          ,
        ),
      ),
    );
  }
}
