


import 'package:community_matrimonial/utils/Colors.dart';
import 'package:flutter/material.dart';


class MyCard extends StatelessWidget {

  final String text;
  final bool isSelected;
  final String counts;

   MyCard({required this.text , required this.isSelected , required this.counts});

  @override
  Widget build(BuildContext context) {
    return Container(

        child:Card(
      elevation: 4.0,
       semanticContainer: false,
      color: isSelected  ?  ColorsPallete.blue_2 :  Colors.white ,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45.0),

      ),
      child: Container(
        padding: EdgeInsets.only(left: 15 , right: 10),
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: isSelected  ? Colors.white : ColorsPallete.blue_2),
            ),
            SizedBox(width: 15.0),
            Container(alignment: Alignment.topRight , margin: EdgeInsets.only(top:0)  , child: TextOnImage(imageUrl: 'assets/images/heart_awesome.png', text: counts,), )

          ],
        ),
      ),
    ));
  }
}







class TextOnImage extends StatelessWidget {
  final String imageUrl;
  final String text;

  const TextOnImage({
    Key? key,
    required this.imageUrl,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Container(

            padding: EdgeInsets.all(text.length <=1 ? 8 : 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink, // Set the circle's background color
            ),

            child: Text(
               text,textAlign: TextAlign.right,
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            )),
      ],
    );

  }
}
