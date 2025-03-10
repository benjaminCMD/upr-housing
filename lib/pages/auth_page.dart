import 'package:flutter/material.dart';
import 'package:upr_housing/pages/login.dart';
import 'home_page.dart';
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
            return HomePage();
          }

          else {
            return LoginPage();
          }

          

        }

      )

    );
  }
  
  }