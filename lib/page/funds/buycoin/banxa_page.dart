import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyCoinBanxaPage extends StatefulWidget {
  const BuyCoinBanxaPage({Key? key}) : super(key: key);

  @override
  _BuyCoinBanxaPageState createState() => _BuyCoinBanxaPageState();
}

class _BuyCoinBanxaPageState extends State<BuyCoinBanxaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banxa'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            Text('充值账户:'),
            Text('yywishp@gmail.com'),


          ],
        ),
      ),
    );
  }
}
