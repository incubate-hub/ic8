import 'package:flutter/material.dart';
import 'package:swiss_knife/models/feature.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeaturesPro extends ChangeNotifier{
  List<Feature> featureList=[];

  Future<void> fetchAndSetFeatures() async{
    featureList=[];
    final _firestore=FirebaseFirestore.instance;
    final features=await _firestore.collection('features').get();
    for(var feature in features.docs){
      featureList.add(Feature(featureName:feature.data()['name'],id: feature.id),);
    }
    notifyListeners();
  }
}