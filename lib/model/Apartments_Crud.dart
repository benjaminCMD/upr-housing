import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Apartment{}
  Future<void> addAID(aID) async {
    await FirebaseFirestore.instance.collection('Apartments').doc(aID).set({
      'aID': aID,
    });
  }
  

  Future<void> addApartment(
    aTitle,
    aTown,
    aPrice,
    aNeighborhood,
  ) async {
    await FirebaseFirestore.instance.collection('Apartments').add({
      'aID':'',
      'Apartment_title': aTitle,
      'Town': aTown,
      'Price': aPrice,
      'Neighborhood': aNeighborhood,
    });
  }