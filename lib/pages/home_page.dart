import 'package:firebase_auth/firebase_auth.dart';
import 'package:upr_housing/components/my_searchbar.dart';
import 'package:flutter/material.dart';

class HomePageApp extends StatefulWidget {
  const HomePageApp({super.key});

  @override
  State<HomePageApp> createState() => HomePageAppState();
}

class HomePageAppState extends State<HomePageApp> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            MySearchBar(),

            // White Background Section (Main Content)
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: const Text(
                    "Main Content Goes Here",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
