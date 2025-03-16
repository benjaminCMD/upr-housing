// import 'package:flutter/material.dart';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Apartment {
  Future<void> addApartment(aTitle, aTown, aPrice, aNeighborhood, aType, aGender,aSummary, uID) async {
    DocumentReference<Map<String, dynamic>> docRef = await FirebaseFirestore.instance.collection('Apartments').add({
      'Apartment title': aTitle,
      'Town': aTown,
      'Price': aPrice,
      'Neighborhood': aNeighborhood,
      'Type': aType,
      'Gender':aGender,
      'Summary':aSummary,
      'Likes': 0,
      'uID' : uID,
    });
    
    await docRef.update({'aID': docRef.id});
  }
}
