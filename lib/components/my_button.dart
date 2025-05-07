import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({
    super.key,
    required this.onTap,
    required this.text
  }
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        decoration: BoxDecoration(
          // color: const Color(0xFF062D3E),
          color:  Color(0xFF4CAF50),
          borderRadius: BorderRadius.circular(8),
          ),
        child: Center(
        child:Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold
            ),
        
      
        ),
        )
      ),
    );
  }
}





class SignUpButton extends StatelessWidget {
  final Function()? onTap;
  const SignUpButton({
    super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(fontSize: 16),
          ),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Register now",
                      style: TextStyle(
                        // color: Colors.blue,
                        color:  Color(0xFF4CAF50),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
          );
  

  }

}

