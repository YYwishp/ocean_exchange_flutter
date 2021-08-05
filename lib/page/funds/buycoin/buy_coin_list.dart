import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyCoinListPage extends StatefulWidget {
  const BuyCoinListPage({Key? key}) : super(key: key);

  @override
  _BuyCoinListPageState createState() => _BuyCoinListPageState();
}

class _BuyCoinListPageState extends State<BuyCoinListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择购买渠道'),
      ),
      body: ListView.separated(
        itemCount: 2,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: () {

              switch(index){
                case 0:


                  break;

                case 1:

                  break;



              }




            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 50.0.h,
              child: Row(
                children: <Widget>[
                  index == 0
                      ? Image.asset('assets/images/icon_banxa.png')
                      : Image.asset('assets/images/icon_simplex.png'),
                  Expanded(
                    child: index == 0
                        ? Container(
                            child: Text("BANXA"),
                            margin: EdgeInsets.only(left: 20.w),
                          )
                        : Container(
                            child: Text("Simplex"),
                            margin: EdgeInsets.only(left: 20.w),
                          ),
                  ),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
