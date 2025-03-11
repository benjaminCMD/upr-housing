// import 'dart:ffi';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:upr_housing/components/my_textfield.dart';
import 'package:upr_housing/components/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upr_housing/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class SignupPage extends StatelessWidget{
  SignupPage({super.key});

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // final _auth = FirebaseAuth.instance;

  Future<UserCredential> createUser() async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text,
    );
  }

  Future<void> addUserInfoToFireStore(uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': usernameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'uid': uid,
          'createdAt': Timestamp.now(),
    });
  }

  void signUserUp(context) async {
    try {
      // Store user details in Firestore
      if(passwordController.text == confirmPasswordController.text){
 

        UserCredential userCredential = await createUser();

        String uid = userCredential.user!.uid;

        addUserInfoToFireStore(uid);
        Navigator.pop(context);

      }else{
        //Password doesnt match
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Container(
            padding: EdgeInsets.all(4),
            height: 30,
            child: Text("Passwords do not match"),
          ),
          behavior: SnackBarBehavior.floating,
          )
        );
      }
      
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Container(
            padding: EdgeInsets.all(16),
            height: 90,
            child: Text("There has been an error"),
          ),
          behavior: SnackBarBehavior.floating,
          )
        );

    }




  }

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
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),

            const SizedBox(height: 10),
            MyTextField(
              controller: emailController,
              hintText: 'email',
              obscureText: false,
            ),

            const SizedBox(height: 10),
            MyTextField(
              controller: phoneController,
              hintText: 'phone',
              obscureText: false,
            ),
            
            const SizedBox(height: 10),
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            const SizedBox(height: 10),
            MyTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
              obscureText: true,
            ),

            const SizedBox(height: 40),
            MyButton(
              onTap: () => signUserUp(context),
              text: 'Sign up'
              ),






          ],
        )
        ),
    )
    );
  }


}
