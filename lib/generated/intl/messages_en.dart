// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(count) => "you have ${count} messages";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "automatic": MessageLookupByLibrary.simpleMessage("Auto"),
        "changeDarkMode":
            MessageLookupByLibrary.simpleMessage("Light/Dark Mode"),
        "changeLanguage":
            MessageLookupByLibrary.simpleMessage("Change Language"),
        "contract": MessageLookupByLibrary.simpleMessage("Contract"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "funds": MessageLookupByLibrary.simpleMessage("Funds"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "lightMode": MessageLookupByLibrary.simpleMessage("Light Mode"),
        "login_successfully":
            MessageLookupByLibrary.simpleMessage("Log in successfully."),
        "markets": MessageLookupByLibrary.simpleMessage("Markets"),
        "test": MessageLookupByLibrary.simpleMessage("This is a language test"),
        "test2": m0,
        "trades": MessageLookupByLibrary.simpleMessage("Trades")
      };
}
