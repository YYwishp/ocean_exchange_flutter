import 'package:flutter/material.dart';

class SwapTradesPage extends StatefulWidget {
  @override
  _SwapTradesPageState createState() => _SwapTradesPageState();
}

class _SwapTradesPageState extends State<SwapTradesPage>
    with AutomaticKeepAliveClientMixin {


  @override
  void initState() {
    super.initState();

    print('_SwapTradesPageState initState');
  }



  @override
  Widget build(BuildContext context) {


    print('_SwapTradesPageState build');


    return Container(
      child: Text('合约界面'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
