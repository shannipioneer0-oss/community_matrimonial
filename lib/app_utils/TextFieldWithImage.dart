



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWithImage extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType textInputtype;
  final TextEditingController controller;

  TextFieldWithImage({required this.hintText, required this.icon , required this.textInputtype , required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(width: MediaQuery.of(context).size.width*0.9,
      padding: EdgeInsets.only(left: 25 , top: 5 , right: 5 ,bottom: 5),
      margin: EdgeInsets.only(right: 10 ,left: 10 , bottom: 15),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Input.png'), // Replace with your image asset path
          fit: BoxFit.cover,
        ),
      )
      ,child:TextField(
        keyboardType: textInputtype,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: Icon(icon , color: Colors.pink),
            border: InputBorder.none

        ),
      ),
    );
  }
}












class RoundedContainer extends StatelessWidget {

  final String text;
  final Color color;

  RoundedContainer({required this.text , required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}





class RoundedContainerWithImage extends StatelessWidget {

  final Color color;
  final String text;
  final String image;
  final String textimage;

  RoundedContainerWithImage({required this.color , required this.text , required this.image , required this.textimage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color, // Container background color
        borderRadius: BorderRadius.circular(40.0), // Rounded corners
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side content (if any)
          Text(
             text,
            style: TextStyle(color: Colors.white),
          ),

          // Right side image

      Stack(
        alignment: Alignment.center,
        children: [
          // Image
          Image.asset(
            image, // Replace with your image asset path
            width: 25.0,
            height: 25.0,
            fit: BoxFit.contain,
          ),

          // Text overlapped on the image
          Positioned(
            child: Text(
              textimage,
              style: TextStyle(
                color: Colors.pink,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),

          ),


        ]


      )],
      ),
    );
  }
}
