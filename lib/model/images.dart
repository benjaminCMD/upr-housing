import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {

  final firebaseStorage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  // CollectionReference collection = FirebaseFirestore.instance.collection('Apartments');

  // List<String> _imageUrls = [];

  // bool _isLoading = false;
  // bool _isUploading = false;

  // List<String> get imageUrls => _imageUrls;
  // bool get isLoading => _isLoading;
  // bool get isUploading => _isUploading;



  // Future<void> fetchImages() async {
  //   _isLoading = true;

  //   //final ListResult result = await firebaseStorage.ref('')
  // }

  Future<String> addImage(File image, String aID) async {
    //_isUploading = true;

    //notifyListeners();

    
    //final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    //if (image == null) return;

    

    // try {
      File file = File(image.path);
      String filePath = "Apartments/$aID/${DateTime.now().microsecondsSinceEpoch}.png";
      SettableMetadata metadata = SettableMetadata(customMetadata: {'aID':aID});
      await firebaseStorage.ref(filePath).putFile(file, metadata);
      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
      return downloadUrl;
      // return await firebaseStorage.ref(filePath).getDownloadURL();
    // }

    // catch (e) {
    //   print("Upload failed: $e");
    //   return null;
    // }
  }

  Future<File?> pickImages() async{
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }


}