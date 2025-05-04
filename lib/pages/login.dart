
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upr_housing/components/my_textfield.dart';
import 'package:upr_housing/components/my_button.dart';
import 'package:upr_housing/pages/signup.dart';
import 'package:upr_housing/components/navBar.dart';

// import 'package:upr_housing/pages/signup.dart';

class LoginPage extends StatelessWidget{
  LoginPage({super.key});

  

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  
  Future<void> signUserIn(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      switch (e.code) {
        case 'invalid-credential':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid Email'),
              backgroundColor: Colors.red,
            ),
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login Failed'),
              backgroundColor: Colors.red,
            ),
          );
          break;
      }
    }
  }
  void signUp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              'UPR HOUSING',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50),
              ),
            ),

            

            const SizedBox(height: 25),
       
            
            const SizedBox(height: 25),
            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            
            
            const SizedBox(height: 10),
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            




            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ))
              ]),
            ),

            const SizedBox(height: 40),

            MyButton(
              onTap: ()=>signUserIn(context),
              text: 'Sign In'
            ),

            const SizedBox(height: 20),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Do not have an account?',
                  style: TextStyle(color: Colors.grey),
                ), 
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => SignupPage())
                    );
               },
                child:  Text(
                  'Resgister Now',
                  style: TextStyle(
                     color: Colors.blue,
                     fontWeight: FontWeight.bold
                     
                     
                  ),
                ),
                ),
              ],
            ),
            // SignUpButton(
            //   onTap: () {
            //     Navigator.push(
            //       context, 
            //       MaterialPageRoute(builder: (context) => SignupPage()));
            //   },
            //   //onTap: signUp
            // )


          ],
        )
        ),
    )
    );
  }
}