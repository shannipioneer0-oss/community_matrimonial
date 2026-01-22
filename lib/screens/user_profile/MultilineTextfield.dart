



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/Designs.dart';

class MultilineTextfield extends StatelessWidget{


  final TextEditingController controller;
  final String labelText;
  final bool enabled;
  final IconData icondata;
  final int minlines;
  final int maxlines;

  MultilineTextfield({required this.icondata  ,required this.controller , required this.labelText , required this.enabled , required this.minlines ,  required this.maxlines});


  @override
  Widget build(BuildContext context) {

    return AbsorbPointer(
        absorbing: enabled , child:TextField(
        controller: controller,
        minLines: minlines,
        maxLines: maxlines,
        decoration: InputDecoration(
          prefixIcon: Icon(icondata , color: Colors.black54,),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black54),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
          enabledBorder: Designs.myinputborder(),
          focusedBorder: Designs.myfocusborder(),
        )
    ));

  }


}