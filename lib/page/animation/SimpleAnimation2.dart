import 'dart:ui';

import 'package:flutter/material.dart';

class SimpleAnimation2 extends StatefulWidget {
  const SimpleAnimation2({Key? key}) : super(key: key);

  @override
  _SimpleAnimation2State createState() => _SimpleAnimation2State();
}

class _SimpleAnimation2State extends State<SimpleAnimation2> {
  double _height = 200;

  late Widget _widget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('简单动画2'),
      ),
      body: Center(
        child: AnimatedContainer(
          width: 300,
          height: _height,
          color: Colors.amber,
          duration: Duration(seconds: 1),
          /*child: Center(
            child: CircularProgressIndicator(),
          ),*/

          child: AnimatedSwitcher(
              duration: Duration(seconds: 2),
              child: _widget //Image.network('https://www.itying.com/images/flutter/3.png'),

              ),
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
