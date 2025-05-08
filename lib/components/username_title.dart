import 'package:flutter/material.dart';
import 'package:upr_housing/model/users.dart';

class UsernameTitle extends StatelessWidget {
  final String uid;
  final Users user;

  const UsernameTitle({
    super.key,
    required this.uid,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: user.getUsername(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text('No Username');
        } else {
          return Text(snapshot.data!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          );
        }
      },
    );
  }
}