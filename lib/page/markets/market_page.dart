import 'package:flutter/material.dart';

class MarketsPage extends StatefulWidget {
  @override
  _MarketsPageState createState() => _MarketsPageState();
}

class _MarketsPageState extends State<MarketsPage>with AutomaticKeepAliveClientMixin  {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('行情页面'),
    );
  }




  @override
  bool get wantKeepAlive => true;
}
