import 'package:flutter/material.dart';

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

    return Container(
      child: Text('资产页面'),
    );
    ;
  }
}
