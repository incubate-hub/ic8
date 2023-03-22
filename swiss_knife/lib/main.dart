import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiss_knife/firebase_options.dart';
import 'package:swiss_knife/providers/features_provider.dart';
import 'package:swiss_knife/providers/message_provider.dart';
import 'package:swiss_knife/providers/projects_provider.dart';
import 'package:swiss_knife/responsive/mobile_layout.dart';
import 'package:swiss_knife/responsive/responsive_layout.dart';
import 'package:swiss_knife/responsive/web_layout.dart';
import 'package:swiss_knife/screens/chat_screen.dart';
import 'package:swiss_knife/screens/image_chat_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>FeaturesPro()),
        ChangeNotifierProvider(create: (_)=>ProjectProvider()),
        ChangeNotifierProvider(create: (_)=>MessageProvider()),
      ],
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ResponsiveLayout(
          webScreenLayout: WebLayout(),
          mobileScreenLayout: MobileLayout(),
        ),
      ),
    );
  }
}
