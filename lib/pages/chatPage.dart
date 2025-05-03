//import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upr_housing/pages/userChatPage.dart';

class chatPageApp extends StatefulWidget {
  const chatPageApp({super.key});

  @override
  State<StatefulWidget> createState() => _ChatPageState();

}
class _ChatPageState extends State<chatPageApp>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),

      body: _buildUserList(),
    );
  }


  Widget _buildUserList(){


    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),//where('messages.senderID', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots() ,
      builder: (context, snapshot){
        if(snapshot.hasError){
         
          return const Text('error');
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading...');
        }

        var userList = snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList();
        return ListView(
          children: userList,
        );
      },
    );

  }

  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;


    if(_auth.currentUser!.email != data['email']){
      return ListTile(
        title: Text(data['email']),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => userChatPageApp(
            receiverUserEmail: data['email'],
            receiverUserID: data['uid'],
          )));
        }
      );

    } else{
      return Container();
    }
  }
}

