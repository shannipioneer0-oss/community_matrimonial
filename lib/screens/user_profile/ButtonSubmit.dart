



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonSubmit extends StatelessWidget{

  final String text;
  final VoidCallback onButtonPressed;

  ButtonSubmit({required this.text , required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      onPressed: () {

        onButtonPressed();

      },
      style: ElevatedButton.styleFrom(

        padding: EdgeInsets.only( top: 10 , bottom: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.pink,
      ),
      child: Container(width: MediaQuery.of(context).size.width  ,child:Text(
        text, textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18.0 , color: Colors.white),
      ),

    ));

  }

}