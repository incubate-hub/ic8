import 'package:flutter/material.dart';
import 'package:swiss_knife/constants/colors.dart';

class InputContainer extends StatefulWidget {
  final Function() onPressed;
  final TextEditingController repoPathController;
  final TextEditingController emailIdController;
  bool submitting;

  InputContainer({super.key, required this.onPressed,required this.repoPathController,required this.emailIdController,required this.submitting});

  @override
  State<InputContainer> createState() => _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color:kDarkBlueColor,
                borderRadius: BorderRadius.circular(8)
            ),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: widget.repoPathController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Enter local repository path",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color:kDarkBlueColor,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: widget.emailIdController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter the email-id",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: widget.onPressed,
                child: Container(
                  decoration: BoxDecoration(
                      color: kDarkBlueColor,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  height: 50,
                  width: 50,
                  child: widget.submitting?Center(child: CircularProgressIndicator(),):Icon(Icons.send,color:Colors.white,),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
