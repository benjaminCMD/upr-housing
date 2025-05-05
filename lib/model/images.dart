import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {

  final firebaseStorage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  

  Future<String> addImage(File image, String aID) async {
    try{
      File file = File(image.path);
      String filePath = "Apartments/$aID/${DateTime.now().microsecondsSinceEpoch}.png";
      SettableMetadata metadata = SettableMetadata(customMetadata: {'aID':aID});
      await firebaseStorage.ref(filePath).putFile(file, metadata);
      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception("Failed to upload image: $e");
    }
  }

  Future<File?> pickImages() async{
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }
  
  Future<List<File>> pickImagesTEST({int maxImg = 5}) async{
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isEmpty) return [];
    if (images.length > maxImg) {
      throw Exception("You can only select up to $maxImg images.");
    }

    return images.take(maxImg).map((x) => File(x.path)).toList();

  }

  Future<List<String>> addImageTEST(List<File> images, String aID) async{
    List<String> urls = [];

    for(var file in images){
      final url = await addImage(file, aID);
      urls.add(url);
    }
    return urls;

  }


}