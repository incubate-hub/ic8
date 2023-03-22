import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiss_knife/models/projects.dart';

class ProjectProvider extends ChangeNotifier{
  List<Project> projectsList=[];

  fetchAndSetProjects(String id) async {
    projectsList=[];
    final _firestore=FirebaseFirestore.instance;
    final projects=await _firestore.collection('features').doc(id).collection('projects').get();
    for(var project in projects.docs){
      projectsList.add(Project(projectName: project.data()['pro_name'], projectId: project.id));
    }
    print(projectsList);
    notifyListeners();
  }
}