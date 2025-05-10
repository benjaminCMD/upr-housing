//import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upr_housing/model/users.dart';
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
        centerTitle: true,
        backgroundColor: const Color(0xFF4CAF50),
        title: const Text('Chat',
        style:TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
            ),
        toolbarHeight: 25
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
        leading: CircleAvatar(child: Text(data['username'][0]),),
        trailing: Icon(Icons.chevron_right),
        title: Text(data['username']),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => userChatPageApp(
            receiverUsername: data['username'],
            receiverUserID: data['uid'],
          )));
        }
      );

    } else{
      return Container();
    }
  }
}