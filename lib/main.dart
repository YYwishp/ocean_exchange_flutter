import 'dart:async';

import 'package:flutter/material.dart';

import 'common/routes/routes.dart';
import 'global.dart';

Future<Null> main() async {

    //WidgetsFlutterBinding是框架和flutter引擎之间的胶水
    WidgetsFlutterBinding.ensureInitialized();

    await Global.init();

    runApp(MyApp());





}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //去掉 debug 的图标
      debugShowCheckedModeBanner: false,

      initialRoute: Routes.splash, //初始化加载的路由
      // initialRoute: Routes.navigationBarPageView, //初始化加载的路由
      //抽离route
      onGenerateRoute: onGenerateRoute,
    );
  }
}
