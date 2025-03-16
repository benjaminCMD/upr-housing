import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upr_housing/components/my_button.dart';
import 'package:upr_housing/components/my_largetextfield.dart';
import 'package:upr_housing/components/my_textfield.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upr_housing/model/apartments.dart';
import 'package:upr_housing/pages/home_page.dart';

class PostingAptApp extends StatefulWidget {
  const PostingAptApp({super.key});

  @override
  State<PostingAptApp> createState() => PostingAptAppState();
}

class PostingAptAppState extends State<PostingAptApp> {
  //Creating Controller for each one of the boxes, in order to save the information
  TextEditingController aTitleController = TextEditingController();
  TextEditingController aTownController = TextEditingController();
  TextEditingController aNeighborhoodController = TextEditingController();
  TextEditingController aPriceController = TextEditingController();
  TextEditingController aType = TextEditingController();
  TextEditingController aGenre = TextEditingController();
  TextEditingController aSummary = TextEditingController();

  Apartment apt = Apartment(); //Create class Apartment

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // When transitions are implemented the back arrow icon should appear
        backgroundColor: Color(0xFF4CAF50),
      ),
        body: SafeArea(
            child: Center(
                child: ListView(
      children: [
        const SizedBox(height: 25),
        MyTextField(
            controller: aTitleController,
            hintText: 'Apartment Title',
            obscureText: false),
        const SizedBox(height: 25),
        MyTextField(
            controller: aTownController, hintText: 'Town', obscureText: false),
        const SizedBox(height: 25),
        MyTextField(
            controller: aPriceController,
            hintText: 'Price',
            obscureText: false),
        const SizedBox(height: 25),
        MyTextField(
            controller: aNeighborhoodController,
            hintText: 'Neighborhood',
            obscureText: false),
        const SizedBox(height: 25),
        MyTextField(
            controller: aType,
            hintText: 'Type',
            obscureText: false),
        const SizedBox(height: 25),
        MyTextField(
            controller: aGenre,
            hintText: 'Genre',
            obscureText: false),
        const SizedBox(height: 25),
        MyLargetextfield(
            controller: aSummary,
            hintText: 'Summary',
            obscureText: false),
        const SizedBox(height: 25),
        //The button add a new Apartments to the database
        MyButton(
            onTap: () {
              if (aTitleController.text.trim().isEmpty ||
                  aTownController.text.trim().isEmpty ||
                  aPriceController.text.trim().isEmpty ||
                  aNeighborhoodController.text.trim().isEmpty||
                  aType.text.trim().isEmpty||
                  aGenre.text.trim().isEmpty||
                  aSummary.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please field all the blanks!'),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                apt.addApartment(
                  aTitleController.text,
                  aTownController.text,
                  aPriceController.text,
                  aNeighborhoodController.text,
                  aType.text,
                  aGenre.text,
                  aSummary.text,
                  FirebaseAuth.instance.currentUser!.uid
                );
                // Does the transition between postingApt page to 
                // Do not erase this plz
                // Navigator.push(
                //    context, 
                //    MaterialPageRoute(builder: (context) => const HomePageApp())
                // );
              }
            },
            text: "Post Apartment"),
            const SizedBox(height: 20),
      ],
    ))));
  }
}
