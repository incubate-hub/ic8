import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:swiss_knife/models/message.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MessageProvider extends ChangeNotifier{
  List<Messagee> messagesList=[];
  
  Future<void> fetchAndSetMessages(String featureId,String projectId) async{
    messagesList=[];
    final _firestore=FirebaseFirestore.instance;
    final messages=await _firestore.collection('features').doc(featureId).collection('projects').doc(projectId).collection('messages').get();
    for(var message in messages.docs){
      print(message.data());
        messagesList.add(Messagee(text: message.data()['message'], uid: message.data()['user_id']));
    }
    notifyListeners();
  }
}