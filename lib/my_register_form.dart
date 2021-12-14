import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';

class MyRegisterForm extends StatefulWidget {
  const MyRegisterForm({Key? key}) : super(key: key);

  @override
  _MyRegisterFormState createState() => _MyRegisterFormState();
}

class _MyRegisterFormState extends State<MyRegisterForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  bool _isLoading = false;
  Future<bool> validate() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _passwordConfirmController.text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        title: "Warning",
        message: "All field must be filled",
        duration: Duration(seconds: 1),
        snackPosition: SnackPosition.TOP,
      ));
      return false;
    }
    if (_passwordController.text != _passwordConfirmController.text) {
      Get.showSnackbar(const GetSnackBar(
        title: "Warning",
        message: "Password must be same",
        duration: Duration(seconds: 1),
        snackPosition: SnackPosition.TOP,
      ));
      return false;
    }
    return true;
  }

  register() async {
    final isValid = await validate();
    if (!isValid) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      _isLoading = false;
    });

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
    FirebaseAuth.instance.authStateChanges();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffD0D4E3),
        body: SafeArea(child: AuthFlowBuilder<EmailFlowController>(
            builder: (context, state, controller, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _emailController,
                  decoration:
                      const InputDecoration(hintText: "Enter email address"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(hintText: "Enter password"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _passwordConfirmController,
                  obscureText: true,
                  decoration:
                      const InputDecoration(hintText: "Enter confirm password"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    )
                  : buildButton("Register", onTap: () async {
                      register();
                      //}
                    },
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.green))
            ],
          );
        })));
  }

  GestureDetector buildButton(String text,
      {Function()? onTap, Decoration? decoration}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: decoration,
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
