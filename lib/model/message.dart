import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverId,
    required this.timestamp,
    required this.message
  });


  Map<String,dynamic> toMap(){
    return{
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverId,
      'message': message,
      'timestamp': timestamp
    };
  }
}