
import 'package:flutter/material.dart';
import 'package:ocean_exchange_flutter/common/routes/routes.dart';
import 'package:ocean_exchange_flutter/common/utils/storage.dart';
import 'package:flutter_web_plugin/flutter_web_plugin.dart';

/**
 * 资产页面
 */
class FundsPages extends StatefulWidget {
  @override
  _FundsPagesState createState() => _FundsPagesState();
}

class _FundsPagesState extends State<FundsPages>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    print('FundsPages initState');
  }

  @override
  Widget build(BuildContext context) {
    print('FundsPages build');

    var str=4;

    return Container(
      child: Column(
        children: <Widget>[

          SizedBox(height: 50,),

          ElevatedButton(
            onPressed: () {
              // getUserInfo();

              login();
            },
            child: Text('登录'),
          ),
          ElevatedButton(
            onPressed: () {
              setUserInfo();
            },
            child: Text('设置数据'),
          ),
          ElevatedButton(
            onPressed: () {
              var a = str;
              print('$a');
              showToast();
            },
            child: Text('测试'),
          ),
        ],
      ),
    );
    ;
  }

  Future getUserInfo() async {
    var preference = await StorageUtil().getPreference("userInfo","");

    print(preference);
  }

  void setUserInfo() async {
    // var bool = await StorageUtil().savePreference('userInfo', "qqqwwee");
    //
    // print('是否存储成功 $bool');


    Navigator.pushNamed(context, Routes.captchaPage,arguments: {'type':'tencent'});


  }

  void login() {


    Navigator.pushNamed(context, Routes.loginPage);


  }

  showToast()async{
    String formNativeMsg = await FlutterWebPlugin.showToast(' 00000 ');
    print('$formNativeMsg');
  }




}
