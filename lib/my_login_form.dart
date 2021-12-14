import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:flutter_fire/home_sample.dart';
import 'package:flutter_fire/my_forgot_password.dart';
import 'package:flutter_fire/my_login_with_phone.dart';
import 'package:flutter_fire/my_register_form.dart';

class MyLoginForm extends StatefulWidget {
  const MyLoginForm({Key? key}) : super(key: key);

  @override
  _MyLoginFormState createState() => _MyLoginFormState();
}

class _MyLoginFormState extends State<MyLoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscureText = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return AuthFlowBuilder<EmailFlowController>(
      listener: (oldState, state, controller) {
        print("[MyLoginForm] AuthFlowBuilder listener ${state.toString()}");
        if (state is SignedIn) {
          Get.to(() => const HomeSample());
        } else if (state is AuthFailed) {
          setState(() {
            emailController.clear();
            passwordController.clear();
          });
          Get.showSnackbar(const GetSnackBar(
            title: "Failed Authentication",
            message: "Username or Password are wrong",
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 2),
          ));
        }
      },
      builder: (context, state, controller, _) {
        print("[MyLoginForm] AuthFlowBuilder builder ${state.toString()}");

        if (state is AuthFailed) {}

        if (state is AwaitingEmailAndPassword || state is SigningIn) {}

        return buildScreen(controller);
      },
    );
  }

  Future<bool> validate() async {
    if (emailController.text.isEmpty || emailController.text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        title: "Failed Authentication",
        message: "Username or Password must be filled",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      ));
      return false;
    }
    return true;
  }

  void signInProcess(EmailFlowController controller) async {
    final isValid = await validate();
    if (!isValid) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    controller.setEmailAndPassword(
        emailController.text, passwordController.text);
    setState(() {
      isLoading = false;
    });
  }

  Widget buildScreen(EmailFlowController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "don\' have an account?",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
            ),
            TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                  color: Colors.green,
                  fontSize: 11,
                )),
                onPressed: () {
                  Get.to(() => const MyRegisterForm());
                },
                child: const Text("Create an account"))
          ],
        ),
        buildTextField(emailController, Icons.email_rounded,
            hintText: "Enter email address"),
        const SizedBox(
          height: 20,
        ),
        buildTextField(passwordController, Icons.email_rounded,
            hintText: "Password", isPassword: true, onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        }, obscureText: obscureText),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  style: TextButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    Get.to(() => const MyLoginWithPhone());
                  },
                  child: const Text("login with phone")),
              TextButton(
                  onPressed: () {
                    Get.to(() => const MyForgotPassword());
                  },
                  child: const Text("forgot password?")),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : buildButton("Sign in", onTap: () async {
                controller.setEmailAndPassword(
                    emailController.text, passwordController.text);
                signInProcess(controller);
              },
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.green)),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Text("or continue with"),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            GoogleSignInIconButton(
              clientId: "Asdf1234",
              size: 60,
            ),
            TwitterSignInIconButton(
              apiKey: "T1234",
              apiSecretKey: "Tw33t",
              redirectUri:
                  "https://fir-app-afcbe.firebaseapp.com/__/auth/handler",
              size: 60,
            ),
            FacebookSignInIconButton(
              clientId: "F1234",
              size: 60,
              redirectUri:
                  "https://fir-app-afcbe.firebaseapp.com/__/auth/handler",
            )
          ],
        ),
      ],
    );
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

  Container buildTextField(TextEditingController controller, IconData icon,
      {String hintText = "",
      bool isPassword = false,
      bool obscureText = false,
      Function()? onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hintText,
            suffixIcon: isPassword
                ? GestureDetector(
                    onTap: onTap,
                    child: const Icon(Icons.remove_red_eye_rounded))
                : null,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    const BorderSide(color: Colors.black45, width: 0.8)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.blue, width: 0.8)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    BorderSide(color: Colors.red.shade300, width: 0.8))),
      ),
    );
  }
}
