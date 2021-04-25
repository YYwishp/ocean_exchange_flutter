import 'package:flutter/material.dart';
import 'package:ocean_exchange_flutter/common/utils/storage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{



  @override
  void initState() {
    super.initState();

    print('_HomePageState initState');
  }



  @override
  Widget build(BuildContext context) {
    print('_HomePageState build');

    return Container(
      child: Text('首页'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
