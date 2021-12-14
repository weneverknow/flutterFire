import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class MyLoginWithPhone extends StatefulWidget {
  const MyLoginWithPhone({Key? key}) : super(key: key);

  @override
  _MyLoginWithPhoneState createState() => _MyLoginWithPhoneState();
}

class _MyLoginWithPhoneState extends State<MyLoginWithPhone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD0D4E3),
      body: SafeArea(child: PhoneInputScreen()),
    );
  }
}
