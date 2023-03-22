import 'package:flutter/material.dart';
import 'package:swiss_knife/constants/colors.dart';
import 'package:swiss_knife/widgets/features_tile.dart';
import 'package:sizer/sizer.dart';

class WebLayout extends StatelessWidget {
  const WebLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return Scaffold(
          backgroundColor: kScaffoldBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OptionsContainer(mainLabel: "Features",),
                Container(
                  width: 10,
                ),
                OptionsContainer(mainLabel: "Projects",),
                Container(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      decoration: BoxDecoration(
                        color: kDarkBlueColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container()),
                ),
              ],
            ),
          ),);
    });
  }
}

class OptionsContainer extends StatelessWidget {
  final String mainLabel;

  const OptionsContainer({super.key, required this.mainLabel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
          decoration: BoxDecoration(
            color: kDarkBlueColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kYellowColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                      child: Text(
                    mainLabel,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 6.sp),
                  )),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    FeaturesTile(label: "sample 1",onPressed: (){},),
                    FeaturesTile(label: "sample 2",onPressed: (){},),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
