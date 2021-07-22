import 'package:flutter/material.dart';
import 'package:ocean_exchange_flutter/generated/l10n.dart';
import 'package:ocean_exchange_flutter/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    print('_HomePageState initState');
  }

  @override
  Widget build(BuildContext context) {
    print('_HomePageState build');

    var str = 4;
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              // getUserInfo();

              login();
            },
            /*child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('登录'),
              ),
            ),*/

            child: Text(
              '登录',
              style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.normal,),

            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                setUserInfo();
              },
              child: Text(
                '设置数据',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              var a = str;
              print('$a');
              // showToast();

              // Navigator.pushNamed(context, Routes.verifyCodePage,
              //     arguments: {'email':'yywishp@gmail.com'});

              Navigator.pushNamed(context, Routes.MoneyPage);
            },
            child: Text('测试'),
          ),
          ElevatedButton(
            child: Text(S.of(context).changeDarkMode),
            onPressed: () {
              Navigator.pushNamed(context, Routes.themePage);
            },
          ),
          ElevatedButton(
            child: Text('切换语言'),
            onPressed: () {
              setState(() {
                Navigator.pushNamed(context, Routes.localePage);
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void login() {
    Navigator.pushNamed(context, Routes.loginPage);
  }

  void setUserInfo() async {
    // var bool = await StorageUtil().savePreference('userInfo', "qqqwwee");
    //
    // print('是否存储成功 $bool');

    Navigator.pushNamed(context, Routes.captchaPage, arguments: {'type': 'tencent'});
  }
}
