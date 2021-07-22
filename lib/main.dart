import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_exchange_flutter/generated/l10n.dart';
import 'package:ocean_exchange_flutter/provider/locale_provider.dart';
import 'package:ocean_exchange_flutter/provider/theme_provider.dart';
import 'package:ocean_exchange_flutter/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/utils/device_utils.dart';
import 'global/Global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<Null> main() async {
  //WidgetsFlutterBinding是框架和flutter引擎之间的胶水
  WidgetsFlutterBinding.ensureInitialized();
  //初始化
  await Global.init();
  await Device.initDeviceInfo();

  /// sp 库 初始化
  await SpUtil.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData? theme;

  MyApp({Key? key, this.theme}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    /*return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder:
            (_, ThemeProvider provider, LocaleProvider localeProvider, __) {
          return MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],

            supportedLocales: [
              const Locale('en', ''),
              ...S.delegate.supportedLocales
            ],
            //国际化地区
            locale: localeProvider.locale,

            //去掉 debug 的图标
            debugShowCheckedModeBanner: false,
            //初始化加载的路由
            initialRoute: Routes.splash,

            //抽离route
            onGenerateRoute: onGenerateRoute,
            builder: EasyLoading.init(
              builder: (context, child) {
                /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!,
                );
              },
            ),

            theme: theme ?? provider.getTheme(),
            darkTheme: provider.getTheme(isDarkMode: true),
            themeMode: provider.getThemeMode(),
          );
        },
      ),
    );*/

    return RefreshConfiguration(
      footerTriggerDistance: 50,
      // load 触发距离
      dragSpeedRatio: 0.9,
      // 拖动速度比
      headerBuilder: () => MaterialClassicHeader(),
      footerBuilder: () => ClassicFooter(),

      maxOverScrollExtent: 100,
      //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
      maxUnderScrollExtent: 100,
      // 底部最大可以拖动的范围

      enableLoadingWhenNoData: true,
      enableRefreshVibrate: true,
      //刷新 震动
      enableLoadMoreVibrate: true,
      //load 震动
      shouldFooterFollowWhenNotFull: (state) {
        // If you want load more with noMoreData state ,may be you should return false
        return false;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ],
        child: Consumer2<ThemeProvider, LocaleProvider>(
          builder:
              (_, ThemeProvider provider, LocaleProvider localeProvider, __) {
            return MaterialApp(
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],

              supportedLocales: [
                const Locale('en', ''),
                ...S.delegate.supportedLocales
              ],
              //国际化地区
              locale: localeProvider.locale,

              //去掉 debug 的图标
              debugShowCheckedModeBanner: false,
              //初始化加载的路由
              initialRoute: Routes.splash,

              //抽离route
              onGenerateRoute: onGenerateRoute,
              builder: EasyLoading.init(
                builder: (context, child) {
                  /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: child!,
                  );
                },
              ),

              theme: theme ?? provider.getTheme(),
              darkTheme: provider.getTheme(isDarkMode: true),
              themeMode: provider.getThemeMode(),
            );
          },
        ),
      ),
    );

    // return MaterialApp(
    //
    //   //去掉 debug 的图标
    //   debugShowCheckedModeBanner: false,
    //
    //   initialRoute: Routes.splash, //初始化加载的路由
    //   // initialRoute: Routes.navigationBarPageView, //初始化加载的路由
    //   //抽离route
    //   onGenerateRoute: onGenerateRoute,
    //   builder: EasyLoading.init(),
    //
    //   theme: ThemeData(
    //   ),
    // );
  }
}
