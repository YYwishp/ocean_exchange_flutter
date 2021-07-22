import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_exchange_flutter/res/colors.dart';
import 'package:ocean_exchange_flutter/res/constant.dart';
import 'package:ocean_exchange_flutter/res/styles.dart';
import 'package:ocean_exchange_flutter/routes/web_page_transitions.dart';

extension ThemeModeExtension on ThemeMode {
  String get value {
    return <String>['System', 'Light', 'Dark'][index];
  }
}

class ThemeProvider extends ChangeNotifier {
  void syncTheme() {
    final String theme = SpUtil.getString(Constant.theme) ?? '';
    if (theme.isNotEmpty && theme != ThemeMode.system.value) {
      notifyListeners();
    }
  }

  void setTheme(ThemeMode themeMode) {
    SpUtil.putString(Constant.theme, themeMode.value);
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    final String theme = SpUtil.getString(Constant.theme) ?? '';
    switch (theme) {
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  ThemeData getTheme({bool isDarkMode = false}) {
    return ThemeData(
      errorColor: isDarkMode ? Colours.dark_red : Colours.red,
      //深色还是浅色
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      // 主色，决定导航栏颜色
      primaryColor: isDarkMode ? Colours.dark_bg_color : Colors.white,
      // 次级色，决定大多数Widget的颜色，如进度条、开关等
      accentColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      // Tab指示器颜色
      indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? Colours.dark_bg_color : Colors.white,
      // 主要用于Material背景色
      canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,

      // 文字选择色（输入框选择文字等）
      // textSelectionColor: Colours.app_main.withAlpha(70),
      // textSelectionHandleColor: Colours.app_main,
      // 稳定版：1.23 变更(https://flutter.dev/docs/release/breaking-changes/text-selection-theme)
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colours.app_main.withAlpha(70),
        selectionHandleColor: Colours.app_main,
        cursorColor: Colours.app_main,
      ),

      textTheme: TextTheme(
        // TextField输入文字颜色
        subtitle1: isDarkMode ? TextStyles.textDark : TextStyles.text,
        // Text文字样式
        bodyText2: isDarkMode ? TextStyles.textDark : TextStyles.text,

        subtitle2: isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
      ),
      appBarTheme: AppBarTheme(
        //阴影程度
        elevation: 1.0,
        color: isDarkMode ? Colours.dark_bg_color : Colors.white,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),

      checkboxTheme: CheckboxThemeData(
        // 打钩的颜色
        checkColor: isDarkMode ? MaterialStateProperty.all(Colors.black) : MaterialStateProperty.all(Colors.white),
        fillColor: isDarkMode ? MaterialStateProperty.all(Colors.white30) : MaterialStateProperty.all(Colors.black45),

        side: BorderSide(style: BorderStyle.solid, color: isDarkMode ? Colors.white30 : Colors.black45, width: 2),
      ),

      dividerTheme: DividerThemeData(color: isDarkMode ? Colours.dark_line : Colours.line, space: 0.6, thickness: 0.6),
      // ios主题
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      //对于Web应用程序，为了提高性能，可以禁用页面过渡动画。
      pageTransitionsTheme: NoTransitionsOnWeb(),
      visualDensity: VisualDensity.standard, // https://github.com/flutter/flutter/issues/77142
    );
  }
}
