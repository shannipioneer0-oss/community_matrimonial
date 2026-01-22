


import 'package:flutter/material.dart';

class CircleWithNumber extends StatelessWidget {

  final String number;
  CircleWithNumber({required this.number});

  @override
  Widget build(BuildContext context) {

    return  Stack(
      alignment: Alignment.center,
      children: [

        Image.asset("assets/images/ellipse_white.png" , width: 50, height: 50,),

        Positioned(child: Text( number , style: TextStyle(fontSize: 16 ,  color: Colors.black87),))

      ],
    );

  }
}