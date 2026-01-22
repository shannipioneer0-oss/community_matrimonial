

import 'package:flutter/material.dart';

class Designs{


  static OutlineInputBorder myinputborder(){ //return type is OutlineInputBorder
    return OutlineInputBorder( //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(
          color:Colors.black54,
          width: 1,
        )
    );
  }

  static OutlineInputBorder myfocusborder(){
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(
          color:Colors.pink,
          width: 1.5,
        )
    );
  }

}