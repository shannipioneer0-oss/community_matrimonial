
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:flutter/material.dart';



class InclinedPhoto extends StatelessWidget {
  final String imagePath;
  final int degree;

  InclinedPhoto({required this.imagePath , required this.degree});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: degree * (3.1415926535 / 180), // Convert degrees to radians
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius
          child: Image.network(
            imagePath,
            width: 130.0, // Adjust the width
            height: 180.0, // Adjust the height
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {

              return RoundedContainer();

            },
          ),
        ),
      ),
    );
  }
}





class InclinedText extends StatelessWidget {
  final String text;
  final int degree;

  InclinedText({required this.text , required this.degree});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: degree * (3.1415926535 / 180), // Convert degrees to radians
      child: Container(
        width: MediaQuery.of(context).size.width*0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius
        ),
        child: Text(text , style: TextStyle(color: Colors.black87 , fontSize: 14 , fontWeight: FontWeight.w400),)
      ),
    );
  }
}




class RoundedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.0,
      height: 180.0,
      decoration: BoxDecoration(
        color: ColorsPallete.blue_2, // Set your desired background color
        borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      child: Center(
        child: Text(
          'No Image',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
