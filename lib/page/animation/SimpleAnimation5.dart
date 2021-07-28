import 'package:flutter/material.dart';

class SimpleAnimation5 extends StatefulWidget {
  const SimpleAnimation5({Key? key}) : super(key: key);

  @override
  _SimpleAnimation5State createState() => _SimpleAnimation5State();
}

class _SimpleAnimation5State extends State<SimpleAnimation5> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('简单动画5'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 120,
          color: Colors.amber,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 1, end: 10),
            duration: Duration(seconds: 3),
            builder: (BuildContext context, Object? value, Widget? child) {
              print(value);
              // 整数部分
              final whole = (value as double) ~/ 1; // 除完取整 3 / 2 = 1.5 ; 3 ~/ 2 = 1
              // 小数部分
              final decimal = value - whole;

              return Stack(
                children: [
                  Positioned(
                    top: -100 * decimal, // 0 -> -100
                    child: Opacity(
                      opacity: 1 -decimal,   // 1 -> 0.0
                      child: Text(
                        '$whole',
                        style: TextStyle(fontSize: 100),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100 - decimal * 100, // 100 -> 0

                    child: Opacity(
                      opacity: decimal,  // 0 ->1

                      child: Text(
                        '${whole+1}',
                        style: TextStyle(fontSize: 100),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
