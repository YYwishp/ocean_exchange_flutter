import 'dart:ui';

import 'package:flutter/material.dart';

class SimpleAnimation extends StatefulWidget {
  const SimpleAnimation({Key? key}) : super(key: key);

  @override
  _SimpleAnimationState createState() => _SimpleAnimationState();
}

class _SimpleAnimationState extends State<SimpleAnimation> {
  double _height = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('简单动画'),
      ),
      body: Center(
        child: AnimatedContainer(
          width: 300,
          height: _height,
          // color: Colors.blue,
          duration: Duration(seconds: 1),
          child: Center(
            child: Text(
              'Hi',
              style: TextStyle(fontSize: 72),
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //渐变颜色的位置 橘色在底部
              begin: Alignment.bottomCenter,
              // 蓝色在顶部
              end: Alignment.topCenter,
              //渐变颜色的区间 要和colors数量一致
              stops: [0.1,0.2,0.4],
              // 颜色类型
              colors: [Colors.deepOrange, Colors.amber,Colors.blue],
            ),
            // 外边框阴影
            boxShadow: [BoxShadow(spreadRadius: 15),BoxShadow(blurRadius: 80)],
            borderRadius: BorderRadius.circular(20),


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
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
