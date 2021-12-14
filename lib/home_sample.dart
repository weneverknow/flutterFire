import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSample extends StatefulWidget {
  const HomeSample({Key? key}) : super(key: key);

  @override
  _HomeSampleState createState() => _HomeSampleState();
}

class _HomeSampleState extends State<HomeSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD0D4E3),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Get.back();
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Sign out"),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.power_settings_new_rounded)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32), color: Colors.black45),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.home_filled,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.message_rounded, color: Colors.white)),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.person_rounded, color: Colors.white)),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings_rounded, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
