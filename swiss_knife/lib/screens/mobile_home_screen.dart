import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiss_knife/constants/colors.dart';
import 'package:swiss_knife/providers/features_provider.dart';
import 'package:swiss_knife/screens/image_chat_screen.dart';
import 'package:swiss_knife/screens/projects_screen.dart';
import 'package:swiss_knife/widgets/features_tile.dart';

class MobileHomeScreen extends StatefulWidget {
  MobileHomeScreen({Key? key}) : super(key: key);

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  @override
  void initState() {
    Provider.of<FeaturesPro>(context,listen: false).fetchAndSetFeatures();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kScaffoldBackgroundColor,
        body: Provider.of<FeaturesPro>(context).featureList.length==0?Center(child: CircularProgressIndicator()):Column(
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
                child: Center(child: Text("Features",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
              ),
            ),
            FeaturesTile(label: "Function_call_flowchart", onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageChatScreen(label: "Function_call_flowchart")));
            }),
            Expanded(
              child: ListView.builder(
                itemCount: Provider.of<FeaturesPro>(context).featureList.length,
                itemBuilder: (context,index){
                return FeaturesTile(label: Provider.of<FeaturesPro>(context).featureList[index].featureName,onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProjectsScreen(featureName: Provider.of<FeaturesPro>(context).featureList[index].featureName,featureId: Provider.of<FeaturesPro>(context).featureList[index].id)));
                },);
              },)
              ),
          ],
        ),
      ),
    );
  }
}
