import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upr_housing/components/my_button.dart';
import 'package:upr_housing/components/my_dropdown.dart';
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

  // Available dropdowns with their initial values, new dropdowns should be added here with respective key.
  Map<String, String?> dropDownInitialValues = {
    'aType': null,
    'aGender': null,
  };
  // List of items for the dropdowns
  List<String> types = ['Apartment', 'Studio', 'Dorm'];
  List<String> genders = ['Male', 'Female', 'Any'];

  // Function to update the value of the dictionary above
  void selectedDropdownValue(String key, String? newValue){
    setState(() {
      dropDownInitialValues[key] = newValue;
    });
  }
  
  //Creating Controller for each one of the boxes, in order to save the information
  TextEditingController aTitleController = TextEditingController();
  TextEditingController aTownController = TextEditingController();
  TextEditingController aNeighborhoodController = TextEditingController();
  TextEditingController aPriceController = TextEditingController();
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
        MyDropdown(
          text: 'Type', 
          items: types,
          selectedValue: (value) => selectedDropdownValue('aType', value), // Passes value of dropdown to update dictionary
          ),
        const SizedBox(height: 25),
        MyDropdown(
          text: 'Gender', 
          items: genders,
          selectedValue: (value) => selectedDropdownValue('aGender', value),
          ),
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
                  dropDownInitialValues.containsValue(null)|| // if any of the dropdown initial values are still null
                  aSummary.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please fill all the fields!'),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                apt.addApartment(
                  aTitleController.text,
                  aTownController.text,
                  aPriceController.text,
                  aNeighborhoodController.text,
                  dropDownInitialValues['aType'],
                  dropDownInitialValues['aGender'],
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
