// import 'package:flutter/material.dart';
// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Apartment {
  CollectionReference collection = FirebaseFirestore.instance.collection('Apartments');
  Future<String> addApartment(aTitle, aTown, aPrice, aNeighborhood, aType, aGender,aSummary, uID) async {
    
    DocumentReference docRef = await collection.add({
      'Title': aTitle,
      'Town': aTown,
      'Price': aPrice,
      'Neighborhood': aNeighborhood,
      'Type': aType,
      'Gender':aGender,
      'Summary':aSummary,
      'ImageUrl':'TBD',
      'Likes': 0,
      'uID' : uID,
      
    });
    
    await docRef.update({'aID': docRef.id});
    return docRef.id;
  }
}
