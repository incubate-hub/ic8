import 'package:flutter/material.dart';
import 'package:swiss_knife/constants/colors.dart';
import 'package:swiss_knife/widgets/input_container.dart';
import 'package:http/http.dart' as http;

class ImageChatScreen extends StatefulWidget {
  final String label;

  ImageChatScreen({super.key, required this.label});

  @override
  State<ImageChatScreen> createState() => _ImageChatScreenState();
}

class _ImageChatScreenState extends State<ImageChatScreen> {
  bool isLoading=false;

  TextEditingController repoPathController=TextEditingController();

  TextEditingController emailIdController=TextEditingController();

  List<Map<String,dynamic>> messages=[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kScaffoldBackgroundColor,
        body: Column(
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
                child: Center(child: Text("Function Call Flowchart",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold))),
              ),
            ),
            Expanded(child: Container()),
            InputContainer(
              submitting: isLoading,
              onPressed: ()async{
                if(repoPathController.text!=null && emailIdController.text!=null){
                  setState(() {
                    isLoading=true;
                  });
                  var url = Uri.parse("http://10.0.2.2:5000//${widget.label.toLowerCase()}?code=${repoPathController.text}&receiver_mail=${emailIdController.text}");
                  await http.post(url).then((value){
                    setState(() {
                      isLoading=false;
                      repoPathController.clear();
                      emailIdController.clear();
                    });
                  });
                  //print(respponse.body);
                }
            },repoPathController: repoPathController,emailIdController: emailIdController,)
          ],
        ),
      ),
    );
  }
}
