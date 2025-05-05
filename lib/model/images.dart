import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {

  final firebaseStorage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();

  Future<String> addImage(File image, String aID) async {

      File file = File(image.path);
      String filePath = "Apartments/$aID/${DateTime.now().microsecondsSinceEpoch}.png";
      SettableMetadata metadata = SettableMetadata(customMetadata: {'aID':aID});
      await firebaseStorage.ref(filePath).putFile(file, metadata);
      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
      return downloadUrl;

  }

  Future<File?> pickImages() async{
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }


}