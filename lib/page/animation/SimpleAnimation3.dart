import 'dart:ui';

import 'package:flutter/material.dart';

class SimpleAnimation3 extends StatefulWidget {
  const SimpleAnimation3({Key? key}) : super(key: key);

  @override
  _SimpleAnimation3State createState() => _SimpleAnimation3State();
}

class _SimpleAnimation3State extends State<SimpleAnimation3> {
  double _height = 200;

  late Widget _widget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('简单动画3'),
      ),
      body: AnimatedPadding(
        padding: const EdgeInsets.all(00.0),
        duration: Duration(seconds: 2),
        curve: Curves.bounceOut,
        child: Container(

          width: 300,
          height: 300,
          color: Colors.amber,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _height += 100;
            if (_height == 500) {
              _height = 200;
            }

            // 切换不同的控件
            if (_widget.runtimeType == Image) {
              _widget = Center(
                child: CircularProgressIndicator(),
              );
            } else {
              _widget = Image.network('https://www.itying.com/images/flutter/3.png');
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
