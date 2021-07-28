import 'package:flutter/material.dart';

class ManualAnimation2 extends StatefulWidget {
  const ManualAnimation2({Key? key}) : super(key: key);

  @override
  _ManualAnimation2State createState() => _ManualAnimation2State();
}

class _ManualAnimation2State extends State<ManualAnimation2> with SingleTickerProviderStateMixin {
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
        /// 缩放动画
        child: ScaleTransition(
          // turns: _controller,
          scale: _controller,
          child: Icon(
            Icons.refresh,
            size: 100,
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
          }else {
            _controller.repeat(reverse: true);
          }

          _loading = !_loading;


        },
        child: Icon(Icons.add),
      ),
    );
  }
}
