import 'package:flutter/material.dart';
import 'package:ocean_exchange_flutter/generated/l10n.dart';
import 'package:ocean_exchange_flutter/provider/locale_provider.dart';
import 'package:ocean_exchange_flutter/res/constant.dart';
import 'package:sp_util/sp_util.dart';
import 'package:provider/provider.dart';

class LocalePage extends StatefulWidget {

  const LocalePage({Key? key}) : super(key: key);

  @override
  _LocalePageState createState() => _LocalePageState();
}

class _LocalePageState extends State<LocalePage> {

  final List<String> _list = <String>['跟随系统', '中文', 'English'];

  @override
  Widget build(BuildContext context) {
    final String? locale = SpUtil.getString(Constant.locale);
    String localeMode;
    switch(locale) {
      case 'zh':
        localeMode = _list[1];
        break;
      case 'en':
        localeMode = _list[2];
        break;
      default:
        localeMode = _list[0];
        break;
    }
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   color: ThemeUtils.getIconColor(context),
        //   icon: Icon(Icons.close),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        title: Text(S.of(context).changeLanguage),
      ),
      body: ListView.separated(
        itemCount: _list.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: () {
              final String locale = index == 0 ? '' : (index == 1 ? 'zh' : 'en');
              context.read<LocaleProvider>().setLocale(locale);
              setState(() {});
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_list[index]),
                  ),
                  Opacity(
                    opacity: localeMode == _list[index] ? 1 : 0,
                    child: const Icon(Icons.done, color: Colors.blue),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
