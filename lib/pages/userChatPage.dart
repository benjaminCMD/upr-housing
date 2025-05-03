import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upr_housing/components/my_textfield.dart';
import 'package:upr_housing/model/chat.dart';

class userChatPageApp extends StatefulWidget{
  final String receiverUserEmail;
  final String receiverUserID;
  const userChatPageApp({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID
  });
  
  @override
  State<StatefulWidget> createState()  => _UserChatPageState();
}

class _UserChatPageState extends State<userChatPageApp>{
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(
        widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverUserEmail)),
      body: Column(
        children: [
          Expanded(
            child: _buildMessagesList(),
            ),

            _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessagesList(){
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverUserID, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Text('Error${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting){
            return const Text('Loading...');
          }
          return ListView(
           children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(), 
          );

    });
  }

  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String,dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderID'] == _firebaseAuth.currentUser!.uid) ? Alignment.centerRight:Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Text(data['senderEmail']),
          Text(data['message']),
        ],
      ),
    );
  }


  Widget _buildMessageInput(){
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            controller: _messageController, 
            hintText: 'Enter Message', 
            obscureText: false
            ),
          ),

        IconButton(
          onPressed: sendMessage, 
          icon: const Icon(
            Icons.arrow_upward,
            size: 40,
          ))
      ],
    );
  }

}