import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ocean_exchange_flutter/common/routes/routes.dart';

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
        
        Navigator.pushNamed(context, Routes.navigationBarPageView);
        
        
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
