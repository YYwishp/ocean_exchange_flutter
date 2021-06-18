import 'package:flutter/material.dart';
import 'package:ocean_exchange_flutter/page/login/captcha/captcha_page.dart';
import 'package:ocean_exchange_flutter/page/login/login_page.dart';
import 'package:ocean_exchange_flutter/page/navigation/NavigationBarPageView.dart';
import 'package:ocean_exchange_flutter/page/splash/splash_page.dart';



class Routes{
  static const splash = '/';
  static const navigationBarPage = '/navigationBarPage';
  static const loginPage = '/loginPage';
  static const captchaPage = '/captchaPage';

}

//配置路由
final _routes = {
  //key 名字：value
  //初始化记载的路由 ,不需要传值，就不配置 arguments
  Routes.splash: (context) => SplashPage(),
  Routes.navigationBarPage: (context) => NavigationBarPageView(),
  Routes.loginPage: (context) => LoginPage(),
  Routes.captchaPage: (context,{arguments}) => CaptchaPage(arguments: arguments,),




  /*'/form': (context, {arguments}) => FormPage(title: '我是数据'),
  '/search': (context, {arguments}) => SearchPage(arguments: arguments),
  '/product': (context, {arguments}) => ProductPage(arguments: arguments),
  '/productinfo': (context, {arguments}) =>
      ProductInfoPage(arguments: arguments),
  '/login': (context) => LoginPage(),
  '/registerFirst': (context) => RegisterFirst(),
  '/registerSecond': (context) => RegisterSecond(),
  '/registerThird': (context) => RegisterThird(),
  '/appBarDemo': (context) => AppBarDemoPage(),
  '/tabBarControllerPage': (context) => TabBarControllerPage(),
  '/user': (context) => UserPage(),
  '/buttonDemoPage': (context) => ButtonDemoPage(),
  '/textFieldDemoPage': (context) => TextFieldDemoPage(),
  '/checkBoxDemoState': (context) => CheckBoxDemoState(),
  '/radioDemoState': (context) => RadioDemoState(),
  '/formDemoPage': (context) => FormDemoPage(),
  '/datePickerDemo': (context) => DatePickerDemo(),
  '/datePickerDemo2': (context) => DatePickerDemo2(),
  '/swiperPage': (context) => SwiperPage(),
  '/testNavigationPage': (context) => TestNavigationPage(),
  '/bottomNavigationBarExample': (context) => BottomNavigationBarExample(),
  '/navigationBarPageView': (context) => NavigationBarPageView(),
  '/netWorkDemo': (context) => NetWorkDemo(),
  '/netDataShow': (context) => NetDataShow(),*/
};

//固定写法
// ignore: top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings) {
  //  统一处理
  final String name = settings.name!;
  // 就是对应的 key
  print(name);

  final Function pageContentBuilder = _routes[name]!;
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context, arguments: settings.arguments),
        settings: settings,
      );
      return route;
    } else {
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context),
        settings: settings,
      );
      return route;
    }
  }
  return null;
};
