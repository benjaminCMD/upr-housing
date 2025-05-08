import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upr_housing/components/username_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upr_housing/model/users.dart';
import 'package:flutter/rendering.dart';
import 'package:upr_housing/components/my_textfield.dart';
import 'package:upr_housing/model/chat.dart';
import 'package:upr_housing/model/message.dart';

class userChatPageApp extends StatefulWidget{
  final String receiverUsername;
  final String receiverUserID;
  const userChatPageApp({
    super.key,
    required this.receiverUsername,
    required this.receiverUserID
  });
  
  @override
  State<StatefulWidget> createState()  => _UserChatPageState();
}

class _UserChatPageState extends State<userChatPageApp>{
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Users user = Users();

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
      
      appBar: AppBar(
        title: UsernameTitle(uid: widget.receiverUserID , user: Users()),
      ),
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
    var color = (data['senderID'] == _firebaseAuth.currentUser!.uid) ? Colors.green : Colors.grey;
    var messageWidth = data['message'].toString().length.toDouble();
    double messageWidthD = messageWidth;
    if(messageWidth*12-(messageWidth) < 275){
    return Align(
      alignment: alignment,
      //widthFactor: 0.01, // 1% of parent width
      //child: ConstrainedBox(
        //constraints: BoxConstraints(maxWidth: messageWidthD),
        child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        //color: color,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: color
        ),
        child: Column(
        children: [
          //Text(data['senderEmail']),
          Text(data['message']),
      ],
        ),
        
  ),
);}else{
  return Align(
      alignment: alignment,
      //widthFactor: 0.01, // 1% of parent width
      //child: ConstrainedBox(
        //constraints: BoxConstraints(maxWidth: messageWidthD),
        child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        width:  300 ,
        //color: color,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: color
        ),
        child: Column(
        children: [
          //Text(data['senderEmail']),
          Text(data['message']),
      ],
        ),
        
  ),
);
};
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