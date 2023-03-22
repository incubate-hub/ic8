import 'package:flutter/material.dart';
import 'package:swiss_knife/constants/sizes.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;

  const ResponsiveLayout({super.key, required this.mobileScreenLayout, required this.webScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      if(constraints.maxWidth>webScreenSize){
        return webScreenLayout;
      }
      else{
        return mobileScreenLayout;
      }
    });
  }
}
