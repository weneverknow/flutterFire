import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class MyForgotPassword extends StatefulWidget {
  const MyForgotPassword({Key? key}) : super(key: key);

  @override
  _MyForgotPasswordState createState() => _MyForgotPasswordState();
}

class _MyForgotPasswordState extends State<MyForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffD0D4E3),
      body: SafeArea(child: ForgotPasswordScreen()),
    );
  }
}
