// import 'package:flutter/material.dart';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Apartment {
  Future<void> addApartment(aTitle, aTown, aPrice, aNeighborhood,aGenre,aSummary, uID) async {
    DocumentReference<Map<String, dynamic>> docRef = await FirebaseFirestore.instance.collection('Apartments').add({
      'Apartment_title': aTitle,
      'Town': aTown,
      'Price': aPrice,
      'Neighborhood': aNeighborhood,
      'Genre':aGenre,
      'Summary':aSummary,
      'uID' : uID,
    });
    
    await docRef.update({'aID': docRef.id});
  }
}
