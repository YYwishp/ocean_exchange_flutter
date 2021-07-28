import 'package:flutter/material.dart';

class ManualAnimation3 extends StatefulWidget {
  const ManualAnimation3({Key? key}) : super(key: key);

  @override
  _ManualAnimation3State createState() => _ManualAnimation3State();
}

class _ManualAnimation3State extends State<ManualAnimation3> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _loading = false;

  @override
  void initState() {
    _controller = AnimationController(
      // 垂直同步
      vsync: this,
      duration: Duration(seconds: 1),
      // upperBound: 5.0, // 上限
      // lowerBound: 3.0, // 下限
    );
    _controller.addListener(() {
      print('${_controller.value}');
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手动 动画'),
      ),
      body: Center(
        child: SlideTransition(
          // turns: _controller,
          // scale: _controller,
          ///写法1
          // position: _controller.drive(
          //   Tween(begin: Offset(0, 0), end: Offset(0, 0.6)).chain(CurveTween(curve: Curves.bounceOut),),
          // ),
          ///写法2
          position: Tween(begin: Offset(0, 0), end: Offset(0, 0.6))
              .chain(CurveTween(curve: Curves.bounceOut))
              .animate(_controller),

          child: Container(
            width: 300,
            height: 300,
            color: Colors.blue,
            child: Icon(
              Icons.refresh,
              size: 100,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _controller.forward();// 开始 一次

          // _controller.repeat(); //重复

          // _controller.reset();  // 重置

          // _controller.stop(); // 原地停止

          // _controller.repeat(reverse: true); // 翻转参数

          if (_loading) {
            _controller.stop();
          } else {
            _controller.repeat(reverse: true);
          }

          _loading = !_loading;
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
