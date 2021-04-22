import 'package:flutter/material.dart';

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
    return Container(
      child: Text('首页'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
