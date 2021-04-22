import 'dart:async';

import 'package:flutter/material.dart';

import 'common/routes/routes.dart';


void main() {


  
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      //去掉 debug 的图标
      debugShowCheckedModeBanner: false,

      // initialRoute: Routes.splash, //初始化加载的路由
      initialRoute: Routes.navigationBarPageView, //初始化加载的路由
      //抽离route
      onGenerateRoute: onGenerateRoute,

    );


  }
}


