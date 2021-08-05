import 'package:flutter/material.dart';
import 'package:ocean_exchange_flutter/page/animation/SimpleAnimation.dart';
import 'package:ocean_exchange_flutter/page/animation/SimpleAnimation2.dart';
import 'package:ocean_exchange_flutter/page/animation/SimpleAnimation3.dart';
import 'package:ocean_exchange_flutter/page/animation/SimpleAnimation4.dart';
import 'package:ocean_exchange_flutter/page/animation/SimpleAnimation5.dart';
import 'package:ocean_exchange_flutter/page/animation/manual_animation1.dart';
import 'package:ocean_exchange_flutter/page/animation/manual_animation2.dart';
import 'package:ocean_exchange_flutter/page/animation/manual_animation3.dart';
import 'package:ocean_exchange_flutter/page/funds/buycoin/buy_coin_list.dart';
import 'package:ocean_exchange_flutter/page/login/captcha/captcha_page.dart';
import 'package:ocean_exchange_flutter/page/login/captcha/verify_code_page.dart';
import 'package:ocean_exchange_flutter/page/login/login_page.dart';
import 'package:ocean_exchange_flutter/page/moneypage.dart';
import 'package:ocean_exchange_flutter/page/navigation/NavigationBarPageView.dart';
import 'package:ocean_exchange_flutter/page/setting/locale_page.dart';
import 'package:ocean_exchange_flutter/page/setting/theme_page.dart';
import 'package:ocean_exchange_flutter/page/splash/splash_page.dart';



class Routes{
  static const splash = '/';
  static const navigationBarPage = '/navigationBarPage';
  static const loginPage = '/loginPage';
  static const captchaPage = '/captchaPage';
  static const verifyCodePage = '/VerifyCodePage';
  static const themePage = '/ThemePage';
  static const localePage = '/LocalePage';
  static const MoneyPage = '/MoneyPage';
  static const SimpleAnimation = '/SimpleAnimation';
  static const SimpleAnimation2 = '/SimpleAnimation2';
  static const SimpleAnimation3 = '/SimpleAnimation3';
  static const SimpleAnimation4 = '/SimpleAnimation4';
  static const SimpleAnimation5 = '/SimpleAnimation5';
  static const ManualAnimation1 = '/ManualAnimation1';
  static const ManualAnimation2 = '/ManualAnimation2';
  static const ManualAnimation3 = '/ManualAnimation3';
  static const BuyCoinListPage = '/BuyCoinListPage';

}

//配置路由 map 集合
final _routes = {
  //key 名字：value
  //初始化记载的路由 ,不需要传值，就不配置 arguments
  Routes.splash: (context) => SplashPage(),
  Routes.navigationBarPage: (context) => NavigationBarPageView(),
  Routes.loginPage: (context) => LoginPage(),
  Routes.captchaPage: (context,{arguments}) => CaptchaPage(arguments: arguments,),
  Routes.verifyCodePage: (context,{arguments}) => VerifyCodePage(arguments: arguments,),
  Routes.themePage: (context,{arguments}) => ThemePage(),
  Routes.localePage: (context,{arguments}) => LocalePage(),
  Routes.MoneyPage: (context,{arguments}) => MoneyPage('MoneyPage'),
  Routes.SimpleAnimation: (context,{arguments}) => SimpleAnimation(),
  Routes.SimpleAnimation2: (context,{arguments}) => SimpleAnimation2(),
  Routes.SimpleAnimation3: (context,{arguments}) => SimpleAnimation3(),
  Routes.SimpleAnimation4: (context,{arguments}) => SimpleAnimation4(),
  Routes.SimpleAnimation5: (context,{arguments}) => SimpleAnimation5(),
  Routes.ManualAnimation1: (context,{arguments}) => ManualAnimation1(),
  Routes.ManualAnimation2: (context,{arguments}) => ManualAnimation2(),
  Routes.ManualAnimation3: (context,{arguments}) => ManualAnimation3(),
  Routes.BuyCoinListPage: (context,{arguments}) => BuyCoinListPage(),




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
