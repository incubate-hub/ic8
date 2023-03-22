import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiss_knife/constants/colors.dart';
import 'package:swiss_knife/providers/projects_provider.dart';
import 'package:swiss_knife/screens/chat_screen.dart';
import 'package:swiss_knife/widgets/features_tile.dart';
import 'package:http/http.dart' as http;

class ProjectsScreen extends StatefulWidget {
  final String featureName;
  final String featureId;
  const ProjectsScreen(
      {super.key, required this.featureName, required this.featureId});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  void initState() {
    Provider.of<ProjectProvider>(context, listen: false)
        .fetchAndSetProjects(widget.featureId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kScaffoldBackgroundColor,
        body: Provider.of<ProjectProvider>(context).projectsList.length==0?Center(child: CircularProgressIndicator(),):Column(
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
                child: Center(child: Text(widget.featureName,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount:
                      Provider.of<ProjectProvider>(context).projectsList.length,
                  itemBuilder: (context, index) {
                    return FeaturesTile(
                        label: Provider.of<ProjectProvider>(context)
                            .projectsList[index]
                            .projectName,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                    projectName: Provider.of<ProjectProvider>(context)
                                        .projectsList[index]
                                        .projectName,
                                    linklabel: widget.featureName,
                                      featureId: widget.featureId,
                                      projectId:
                                          Provider.of<ProjectProvider>(context)
                                              .projectsList[index]
                                              .projectId),),);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(linklabel: widget.featureName.toLowerCase(),)));
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
