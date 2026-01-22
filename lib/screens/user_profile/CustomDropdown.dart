


import 'package:community_matrimonial/utils/Designs.dart';
import 'package:flutter/material.dart';

import '../../utils/Strings.dart';

class CustomDropdown extends StatelessWidget{

  final TextEditingController controller;
  final String labelText;
  final IconData icondata;
  final VoidCallback onButtonPressed;

  CustomDropdown({required this.icondata  , required this.controller , required this.labelText , required this.onButtonPressed});


  final FocusNode _focusNode = FocusNode();


  @override
  Widget build(BuildContext context) {

    return AbsorbPointer(
        absorbing: false ,child:TextField(
        readOnly: true,
        controller: controller,
        showCursor: false,
        onTap: onButtonPressed,
        decoration: InputDecoration(
          prefixIcon: Icon(icondata , color: Colors.black54,),
          suffixIcon:  Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.close, color: Colors.black45),
                onPressed: () {
                  controller.clear(); // Clear the text in the TextField
                },
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.black45),
            ],
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black54),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
          enabledBorder: Designs.myinputborder(),
          focusedBorder: Designs.myfocusborder(),
        ),
    ));

  }


}