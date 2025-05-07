import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  CollectionReference collection = FirebaseFirestore.instance.collection('users');
  
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

  // Future<String?> getUsername(String uid) async {
  //   final doc = await collection.doc(uid).get();

  //   if (doc.exists) {
  //     return doc.data()?['username'];
  //   } else {
  //     print('User not found');
  //     return null;
  //   }
  // }
  

  Future<String?> getUsername(uid) async {
    DocumentSnapshot doc = await collection.doc(uid).get();
    final data = doc.data() as Map<String, dynamic>;
    return data['username'];
 
  }

  Future<String?> getEmail(uid) async {
    DocumentSnapshot doc = await collection.doc(uid).get();
    final data = doc.data() as Map<String, dynamic>;
    return data['email'];
  }
}