import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upr_housing/components/my_button.dart';
import 'package:upr_housing/components/my_dropdown.dart';
import 'package:upr_housing/components/my_largetextfield.dart';
import 'package:upr_housing/components/my_textfield.dart';
import 'package:upr_housing/components/navBar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upr_housing/model/apartments.dart';
import 'package:upr_housing/pages/home_page.dart';
import 'package:upr_housing/model/images.dart';


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

  ImageService imageService = ImageService();
  
// IMAGES
  File? selectedImages;
  String downloadUrls = '';

  Apartment apt = Apartment(); //Create class Apartment



  @override
  Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () {
      FocusScope.of(context).unfocus(); // Unfocus text fields when tapping outside
    },
    behavior: HitTestBehavior.opaque, // Ensures taps on empty space are detected
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          "New Apartment",
          style: TextStyle(
            color: Colors.black, 
            fontSize: 20, 
            fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageApp()) );
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => Navbar()) );
          } , 
          icon: Icon(Icons.arrow_back_outlined),  color: Colors.black ,),
        centerTitle: true, // Centers the title
        backgroundColor: Color(0xFF4CAF50),
        // toolbarHeight: 35,
      ),
      body:
      SafeArea(
        child: Center(
          child: ListView(
            children: [
              const SizedBox(height: 25),
              MyTextField(
                controller: aTitleController,
                hintText: 'Title',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: aTownController,
                hintText: 'Town',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: aPriceController,
                hintText: 'Price',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: aNeighborhoodController,
                hintText: 'Neighborhood',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              MyDropdown(
                text: 'Type',
                items: types,
                selectedValue: (value) =>
                    selectedDropdownValue('aType', value),
              ),
              const SizedBox(height: 25),
              MyDropdown(
                text: 'Gender',
                items: genders,
                selectedValue: (value) =>
                    selectedDropdownValue('aGender', value),
              ),
              const SizedBox(height: 25),
              MyLargetextfield(
                controller: aSummary,
                hintText: 'Enter a brief description about your apartment',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              MyButton(onTap: () async {
                File? selectedImage = await imageService.pickImages();
                setState(() {
                  selectedImages = selectedImage;
                });
              }, 
              text: "pick image"),
              if (selectedImages != null)
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Image.file(
      selectedImages!,
      height: 150,
      fit: BoxFit.cover,
    ),
  ),

              const SizedBox(height: 25),
              MyButton(
                onTap: () async {
                  if (aTitleController.text.trim().isEmpty ||
                      aTownController.text.trim().isEmpty ||
                      aPriceController.text.trim().isEmpty ||
                      aNeighborhoodController.text.trim().isEmpty ||
                      dropDownInitialValues.containsValue(null) ||
                      aSummary.text.trim().isEmpty ||
                      selectedImages == null)  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill all the fields!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    String aID = await apt.addApartment(
                      aTitleController.text,
                      aTownController.text,
                      aPriceController.text,
                      aNeighborhoodController.text,
                      dropDownInitialValues['aType'],
                      dropDownInitialValues['aGender'],
                      aSummary.text,
                      FirebaseAuth.instance.currentUser!.uid,
                    );
                    downloadUrls = await imageService.addImage(selectedImages!, aID);
                    await FirebaseFirestore.instance.collection('Apartments').doc(aID).update({'ImageUrl':downloadUrls});
                   
                  }
                },
                text: "Submit",
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ),
  );
}
}
