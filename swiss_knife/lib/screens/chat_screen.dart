import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiss_knife/constants/colors.dart';
import 'package:swiss_knife/models/message.dart';
import 'package:swiss_knife/providers/message_provider.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  final String linklabel;
  final String featureId;
  final String projectId;
  final String projectName;

  const ChatScreen({super.key, required this.featureId, required this.projectId,required this.linklabel,required this.projectName});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Messagee> messages = [];
  bool isLoading=false;
  bool submitting=false;

  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    setState(() {
      isLoading=true;
    });
    Provider.of<MessageProvider>(context,listen: false).fetchAndSetMessages(widget.featureId, widget.projectId).then((value){
      setState(() {
        messages=Provider.of<MessageProvider>(context,listen: false).messagesList;

      });
    });
    setState(() {
      isLoading=false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: kScaffoldBackgroundColor,
        body: isLoading?Center(child: CircularProgressIndicator(),):Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kYellowColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(child: Text(widget.projectName,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              ),
              Expanded(
                child: messages.length==0?Center(child: Text("No previous data",style: TextStyle(color: Colors.white,fontSize: 25),),):ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) => Align(
                    alignment: messages[index].uid == "82091008-a484-4a89-ae75-a22bf8d6f3ac"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 250),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kDarkBlueColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          messages[index].text,
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: kDarkBlueColor,
                          borderRadius: BorderRadius.circular(8)),
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: TextFormField(
                            controller: textController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Enter the input",
                                hintStyle: TextStyle(color: Colors.white,fontSize: 18),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (textController.text != null) {
                        setState(() {
                          submitting=true;
                        });
                        var url=Uri.parse("http://10.0.2.2:5000//${widget.linklabel.toLowerCase()}?code=${textController.text}");
                        http.post(url).then((value) async {
                          if(value.statusCode==200){
                            var extractedData=json.decode(value.body) as Map<String,dynamic>;
                            String msg=extractedData['output'];
                              final _firestore=FirebaseFirestore.instance;
                              await _firestore.collection('features').doc(widget.featureId).collection('projects').doc(widget.projectId).collection('messages').add({
                                'message':textController.text,
                                'user_id':"82091008-a484-4a89-ae75-a22bf8d6f3ac"
                              }).then((value){
                                _firestore.collection('features').doc(widget.featureId).collection('projects').doc(widget.projectId).collection('messages').add({
                                  'message':msg,
                                  'user_id':"82091008-a484-4a89-ae75-a22bf8d6f3ad"
                                }).then((value){
                                  setState(() {
                                    messages.add(Messagee(text: textController.text, uid: "82091008-a484-4a89-ae75-a22bf8d6f3ac"));
                                    messages.add(Messagee(text: msg, uid: "82091008-a484-4a89-ae75-a22bf8d6f3ad"));
                                    submitting=false;
                                  });
                                  textController.clear();
                                });
                              });
                          }
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: kDarkBlueColor,
                          borderRadius: BorderRadius.circular(8)),
                      height: 60,
                      width: 60,
                      child: submitting?Center(child: CircularProgressIndicator(),):Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
