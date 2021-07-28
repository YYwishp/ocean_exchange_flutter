import 'dart:ui';

import 'package:flutter/material.dart';

class SimpleAnimation4 extends StatefulWidget {
  const SimpleAnimation4({Key? key}) : super(key: key);

  @override
  _SimpleAnimation4State createState() => _SimpleAnimation4State();
}

class _SimpleAnimation4State extends State<SimpleAnimation4> {
  double _height = 200;

  bool _isBig = false;

  late Widget _widget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('简单动画4'),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 50, end: _isBig?150:50), //between 0~1
          duration: Duration(seconds: 1),
          builder: (BuildContext context, Object? value, Widget? child) {
            return Container(
              width: 300,
              height: 300,
              color: Colors.amber,
              child: Center(
                child: Text(
                  'Hi',
                  style: TextStyle(fontSize: value as double ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isBig = !_isBig;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
