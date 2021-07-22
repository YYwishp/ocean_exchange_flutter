import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_exchange_flutter/common/utils/theme_utils.dart';

class MyCheckbox extends StatefulWidget {
  final ValueChanged<bool?> onValue;

  const MyCheckbox(
    this.onValue,
    Key key,
  ) : super(key: key);

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      ///CHECKBOX
      onTap: () {
        setState(() {
          this.value = !this.value;

          widget.onValue(value);

          // print('------ value $value');
        });
      },
      child: Container(
        // decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.white),
        // child: value
        //     ? Container(
        //         padding: EdgeInsets.all(5.0),
        //         decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
        //         child: Icon(
        //           Icons.check,
        //           size: 20.0,
        //           color: Colors.white,
        //         ))
        //     : Container(
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: Colors.black,
        //         ),
        //         padding: EdgeInsets.all(0.0),
        //         child: Icon(
        //           Icons.circle,
        //           size: 30.0,
        //           color: Colors.white,
        //         ),
        //       ),

        child: value
            ? SizedBox(
                //svg 直接使用android svg图
                child: AvdPicture.asset(context.isDark
                    ? 'assets/images/night/icon_percent_hide.xml'
                    : 'assets/images/day/icon_percent_hide.xml'),
                height: 18.h,
                width: 18.w,
              )
            : SizedBox(
                //svg 直接使用android svg图
                child: AvdPicture.asset(context.isDark
                    ? 'assets/images/night/icon_percent_show.xml'
                    : 'assets/images/day/icon_percent_show.xml'),
                height: 18.h,
                width: 18.w,
              ),
      ),
    );
  }
}
