import 'package:community_matrimonial/utils/Designs.dart';
import 'package:flutter/material.dart';
import '../../utils/Strings.dart';



class NumericTextField extends StatelessWidget{

  final TextEditingController controller;
  final String labelText;
  final bool enabled;
  final IconData icondata;
  String? type;

  NumericTextField({required this.icondata  ,required this.controller , required this.labelText , required this.enabled , this.type});


  @override
  Widget build(BuildContext context) {

    return AbsorbPointer(
        absorbing: enabled , child:TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: type == "mobile" ? 10 : 50,
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