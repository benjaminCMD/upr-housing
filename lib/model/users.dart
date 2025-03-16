import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  CollectionReference collection = FirebaseFirestore.instance.collection('Users');
  
  Future<UserCredential> createUser(email, password) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> addUser(username, email, phoneNumber, uid) async {
    await collection.doc(uid).set({
      'username': username,
      'email': email,
      'phone': phoneNumber,
      'uid': uid,
      'createdAt': Timestamp.now(),
  });


  }
}