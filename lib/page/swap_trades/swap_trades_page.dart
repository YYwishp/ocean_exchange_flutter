import 'package:flutter/material.dart';

class SwapTradesPage extends StatefulWidget {
  @override
  _SwapTradesPageState createState() => _SwapTradesPageState();
}

class _SwapTradesPageState extends State<SwapTradesPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('合约界面'),
    );
  }

  @override
  bool get wantKeepAlive => true;

}
