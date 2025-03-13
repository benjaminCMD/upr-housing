import 'package:flutter/material.dart';
import 'package:upr_housing/components/my_button.dart';
import 'package:upr_housing/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upr_housing/model/Apartments_Crud.dart';

class PostingAptApp extends StatefulWidget {
  const PostingAptApp({super.key});

  @override
  State<PostingAptApp> createState() => PostingAptAppState();
}

class PostingAptAppState extends State<PostingAptApp> {
  TextEditingController aTitleController = TextEditingController();
  TextEditingController aTownController = TextEditingController();
  TextEditingController aNeighborhoodController = TextEditingController();
  TextEditingController aPriceController = TextEditingController();
  Apartment apt = Apartment();


  Future<void> addApartment(
    aTitle,
    aTown,
    aPrice,
    aNeighborhood,
  ) async {
    await FirebaseFirestore.instance.collection('Apartments').add({
      'Apartment_title': aTitle,
      'Town': aTown,
      'Price': aPrice,
      'Neighborhood': aNeighborhood,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Column(
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
        MyButton(
            onTap: () => addApartment(
                  aTitleController.text,
                  aTownController.text,
                  aPriceController.text,
                  aNeighborhoodController.text,
                ),
            text: "Posting Apartment"),
      ],
    ))));
  }
}
