// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Apartment {
  Future<void> addApartment(aTitle, aTown, aPrice, aNeighborhood) async {
    
    DocumentReference<Map<String, dynamic>> docRef = await FirebaseFirestore.instance.collection('Apartments').add({
      'Apartment_title': aTitle,
      'Town': aTown,
      'Price': aPrice,
      'Neighborhood': aNeighborhood,
    });
    
    await docRef.update({'aID': docRef.id});
  }
}
