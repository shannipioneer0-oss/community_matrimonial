



import 'package:community_matrimonial/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

class RichTextWithIndividualOnTap extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          createTextSpan('Dont have an account? ', ColorsPallete.greyColor),
          createTextSpan(' Register Now!', Colors.blueAccent , onTap: () {

            navService.pushNamed("/signup");

          }),
          // Add more TextSpan widgets as needed
        ],
      ),
    );
  }

  TextSpan createTextSpan(String text, Color color, {Function()? onTap}) {
    return TextSpan(
      text: text,
      style: TextStyle(color: color , fontSize:15),
      recognizer: onTap != null ? (TapGestureRecognizer()..onTap = onTap) : null,
    );
  }
}