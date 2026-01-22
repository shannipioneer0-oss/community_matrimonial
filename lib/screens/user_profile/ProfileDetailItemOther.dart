

import 'package:community_matrimonial/utils/Colors.dart';
import 'package:flutter/material.dart';



class ProfileDetailItemOther extends StatelessWidget {
  final String label;
  final String value;

  ProfileDetailItemOther({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.4,
            child: Text(
              '$label',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: ColorsPallete.blue_2,
              ),
            ),
          ),
          SizedBox(width: 2 , child: Text(":"),),
          Expanded(
            child:Container(margin: EdgeInsets.only(left: 15) ,child: Text(
              value == "null" ? "" : value,
              style: TextStyle(
                fontSize: 15.0,
                color: ColorsPallete.purple,

              ),
            ),
          ),),
        ],
      ),
    );
  }
}




class ProfileDetailItemOtherContainer extends StatelessWidget {
  final String label;
  final Widget value;

  ProfileDetailItemOtherContainer({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.4,
            child: Text(
              '$label',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: ColorsPallete.blue_2,
              ),
            ),
          ),
          SizedBox(width: 2 , child: Text(":"),),
          Expanded(
            child:Container(margin: EdgeInsets.only(left: 15) ,child: value),)
        ],
      ),
    );
  }
}