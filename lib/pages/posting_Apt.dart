import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upr_housing/components/my_button.dart';
import 'package:upr_housing/components/my_dropdown.dart';
import 'package:upr_housing/components/my_largetextfield.dart';
import 'package:upr_housing/components/my_textfield.dart';
import 'package:upr_housing/components/navBar.dart';
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
  // File? selectedImages;
  List<File> selectedImages = [];
  // String downloadUrls = '';
  List<String> downloadUrls = [];

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
              //////////////////////////
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyButton(
                    onTap: () async {
                      try {
                        List<File> pickedImages = await imageService.pickImagesTEST();
                        setState(() {
                          selectedImages = pickedImages;
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },
                    text: 'Add Images',
                  ),
                  const SizedBox(height: 10),
                  if (selectedImages.isNotEmpty)
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedImages.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: FileImage(selectedImages[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedImages.removeAt(index);
                                    });
                                  },
                                  child: const CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.black54,
                                    child: Icon(Icons.close, size: 14, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                ],
              ),








              // MyButton(onTap: () async {
              //   // File? selectedImage = await imageService.pickImages();
              //   try {
              //     List<File> pickedImages = await imageService.pickImagesTEST();
              //     setState(() {
              //       selectedImages = pickedImages;
              //     });
              //   } catch (e) {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       SnackBar(content: Text(e.toString())),
              //     );
              //   }
              //   // List<File> selectedImage = await imageService.pickImagesTEST();
              //   // setState(() {
              //   //   selectedImages = selectedImage;
              //   // });
              // }, 
              // text: "pick image"),
              // if (selectedImages != null)
  // Padding(
  //   padding: const EdgeInsets.all(8.0),
  //   child: Image.file(
  //     selectedImages!,
  //     height: 150,
  //     fit: BoxFit.cover,
  //   ),
  // ),

              const SizedBox(height: 25),
              MyButton(
                onTap: () async {
                  if (aTitleController.text.trim().isEmpty ||
                      aTownController.text.trim().isEmpty ||
                      aPriceController.text.trim().isEmpty ||
                      aNeighborhoodController.text.trim().isEmpty ||
                      dropDownInitialValues.containsValue(null) ||
                      aSummary.text.trim().isEmpty ||
                      selectedImages.isEmpty)  {
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
                    // downloadUrls = await imageService.addImage(selectedImages!, aID);
                    try{
                      downloadUrls = await imageService.addImageTEST(selectedImages, aID);
                      await FirebaseFirestore.instance.collection('Apartments').doc(aID).update({'ImageUrl':downloadUrls});
                    } catch (e){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error uploading images: $e"))
                      );
                    }
                    
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Navbar()) );
                   
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
