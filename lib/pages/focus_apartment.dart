import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upr_housing/components/navBar.dart';
import 'package:upr_housing/components/product.dart';
import 'package:upr_housing/model/users.dart';
import 'package:upr_housing/pages/home_page.dart';
import 'package:upr_housing/components/my_button.dart';
import 'package:upr_housing/pages/userChatPage.dart';

class FocusApartment extends StatelessWidget {
  // final Product product;
  final Product product;
  const FocusApartment({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 224, 222, 214),
        appBar: AppBar(
          title: SizedBox(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Navbar()));
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          backgroundColor: const Color(0xFF4CAF50),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Image.network(product.imageUrl),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(),
                child: Text(
                  "Title: " + product.title,
                  style: TextStyle(fontSize: 25),
                ),
                margin: const EdgeInsets.all(25),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Text(
                      "Summary: " + product.summary,
                      style: TextStyle(fontSize: 25),
                    ),
                    margin: const EdgeInsets.all(15),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(),
                child: Text(
                  "Price: " + product.price,
                  style: TextStyle(fontSize: 25),
                ),
                margin: const EdgeInsets.all(2),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(),
                child: Text(
                  "Likes: " + product.likes.toString(),
                  style: TextStyle(fontSize: 25),
                ),
              ),
              product.uID != FirebaseAuth.instance.currentUser!.uid
                  ? MyButton(
                      text: 'Chat with owner',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => userChatPageApp(
                                      receiverUserEmail: "Home owner",
                                      receiverUserID: product.uID,
                                    )));
                      })
                  : SizedBox(
                      height: 15,
                    )
            ],
          )),
        ));
  }
}
