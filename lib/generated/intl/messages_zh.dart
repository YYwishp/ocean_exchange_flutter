// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static String m0(count) => "你有 ${count} 条消息";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "automatic": MessageLookupByLibrary.simpleMessage("跟随系统"),
        "changeDarkMode": MessageLookupByLibrary.simpleMessage("切换深/浅色模式"),
        "changeLanguage": MessageLookupByLibrary.simpleMessage("切换语言"),
        "contract": MessageLookupByLibrary.simpleMessage("合约"),
        "darkMode": MessageLookupByLibrary.simpleMessage("深色模式"),
        "funds": MessageLookupByLibrary.simpleMessage("资产"),
        "home": MessageLookupByLibrary.simpleMessage("首页"),
        "lightMode": MessageLookupByLibrary.simpleMessage("浅色模式"),
        "login_successfully": MessageLookupByLibrary.simpleMessage("登录成功"),
        "markets": MessageLookupByLibrary.simpleMessage("行情"),
        "test": MessageLookupByLibrary.simpleMessage("语言测试"),
        "test2": m0,
        "trades": MessageLookupByLibrary.simpleMessage("交易")
      };
}
