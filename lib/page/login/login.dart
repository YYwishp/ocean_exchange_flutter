import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(

        color: Colors.blue[50],
        child: Align(
          heightFactor: 2,
          widthFactor: 2,
          alignment: FractionalOffset(0.2, 0.6),
          child: FlutterLogo(
            size: 60,
          ),
        ),
      ),
    );
  }
}
