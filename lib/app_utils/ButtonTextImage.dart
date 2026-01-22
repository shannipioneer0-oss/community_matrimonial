

import 'package:flutter/material.dart';

class ButtonTextImage extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData icons;

  ButtonTextImage({required this.onTap , required this.text , required this.icons});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 20,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.pink
        ),
        child: Row(
          children: [
            Icon(icons), // Replace with your desired icon
            SizedBox(width: 16.0),
            Text(text , style: TextStyle(color: Colors.white),), // Replace with your desired text
          ],
        ),
      ),
    );
  }
}








class CustomAppBarAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  CustomAppBarAction({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 30, // Set your desired height
      color: color, // Set your desired background color
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(icon, color: Colors.white), // Customize the icon color
        ),
      ),
    );
  }
}