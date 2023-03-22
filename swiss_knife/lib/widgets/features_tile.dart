import 'package:flutter/material.dart';
import 'package:swiss_knife/constants/colors.dart';

class FeaturesTile extends StatelessWidget {
  final String label;
  final Function() onPressed;
  const FeaturesTile({super.key, required this.label,required this.onPressed});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: kLightYellowColor,
            borderRadius: BorderRadius.circular(6),
          ),
          height: 50,
          width: double.infinity,
          child:Center(child: Text(label,style: TextStyle(fontSize: 17,color: kDarkBlueColor,fontWeight: FontWeight.w600),)),
        ),
      ),
    );
  }
}
