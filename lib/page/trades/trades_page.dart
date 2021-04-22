import 'package:flutter/material.dart';

class TradesPage extends StatefulWidget {
  @override
  _TradesPageState createState() => _TradesPageState();
}

class _TradesPageState extends State<TradesPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('交易界面'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
