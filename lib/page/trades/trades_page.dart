import 'package:flutter/material.dart';

class TradesPage extends StatefulWidget {
  @override
  _TradesPageState createState() => _TradesPageState();
}

class _TradesPageState extends State<TradesPage> with AutomaticKeepAliveClientMixin{


  @override
  void initState() {
    super.initState();

    print('_TradesPageState initState');
  }


  @override
  Widget build(BuildContext context) {

    print('_TradesPageState build');


    return Container(
      child: Text('交易界面'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
