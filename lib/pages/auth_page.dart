import 'package:flutter/material.dart';
import 'package:upr_housing/pages/login.dart';
import 'dummy_home.dart';
import 'package:upr_housing/pages/posting_apt.dart';
import 'package:upr_housing/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            return HomePageApp(); // if you are working on different page, change it here
          }

          else {
            return LoginPage();
          }

        }

      )

    );
  }
  
}