
import 'package:flutter/material.dart';
import 'package:upr_housing/components/my_textfield.dart';
import 'package:upr_housing/components/my_button.dart';

class LoginPage extends StatelessWidget{
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}
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
              controller: usernameController,
              hintText: 'Username',
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
              onTap: signUserIn
            ),

            const SizedBox(height: 20),
            
            SignUpButton(
              onTap: signUp
            )


          ],
        )
        ),
    )
    );
  }
}