import 'package:flutter/material.dart';

class ManualAnimation1 extends StatefulWidget {
  const ManualAnimation1({Key? key}) : super(key: key);

  @override
  _ManualAnimation1State createState() => _ManualAnimation1State();
}

class _ManualAnimation1State extends State<ManualAnimation1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;


  bool _loading = true;

  @override
  void initState() {
    _controller = AnimationController(
      // 垂直同步
      vsync: this,
      duration: Duration(seconds: 1),
    );

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
        /// 旋转动画
        child: RotationTransition(
          turns: _controller,
          child: Icon(
            Icons.refresh,
            size: 100,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _controller.forward();// 开始

          // _controller.repeat(); //重复

          // _controller.reset();  // 重置

          // _controller.stop(); // 原地停止


          if (_loading) {
            _controller.stop();
          }else {
            _controller.repeat();
          }

          _loading = !_loading;


        },
        child: Icon(Icons.add),
      ),
    );
  }
}
