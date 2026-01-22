
import 'package:flutter/material.dart';

class AcceptReject extends StatefulWidget {

  final ValueChanged<int> onChanged;

  AcceptReject(this.onChanged);

  @override
  AcceptRejectState createState() => AcceptRejectState();

}


class AcceptRejectState extends State<AcceptReject> {

  String accept = "0" ,reject = "0";
  int accept_num = 0 , reject_num = 0;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Accept Button
        GestureDetector(
          onTap: (){

            if(accept == "0" && reject == "0") {

              setState(() {
                accept = "1";
                reject = "0";
              });

              widget.onChanged(1);

            }else if(accept == "0" && reject == "1"){

              setState(() {
                accept = "1";
                reject = "0";
              });

              widget.onChanged(1);

            }else if(accept == "1" && reject == "0"){

              setState(() {
                accept = "0";
                reject = "0";
              });

              widget.onChanged(0);

            }



          },
          child: Container(
          decoration: BoxDecoration(
          shape: BoxShape.circle,
    border: Border.all(
    color: Colors.black87, // Border color
    width: 3, // Border width
    ),
    ), child:CircleAvatar(
            radius: 12,

            backgroundColor: accept == "1" ?  Colors.green : Colors.white,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),),
        SizedBox(width:5), // Space between buttons
        // Reject Button
        GestureDetector(
          onTap: (){


            if(accept == "0" && reject == "0") {

              setState(() {
                accept = "0";
                reject = "1";
              });

              widget.onChanged(2);

            }else if(accept == "1" && reject == "0"){

              setState(() {
                accept = "0";
                reject = "1";
              });

              widget.onChanged(2);

            }else if(accept == "0" && reject == "1"){

              setState(() {
                accept = "0";
                reject = "0";
              });

              widget.onChanged(0);

            }

          },
          child: Container(
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
    color: Colors.black87, // Border color
    width: 3, // Border width
    ),
    ), child: CircleAvatar(
            radius: 12,
            backgroundColor: reject == "1" ?  Colors.red : Colors.white,
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),),
      ],
    );


  }





}