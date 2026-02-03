


import 'package:community_matrimonial/network_utils/model/profile_details_model.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

class ExpandingPanel extends StatefulWidget {

  final PhotoInfo photinfo;
  final String fullname;
  ExpandingPanel(this.photinfo , this.fullname);

  @override
  _ExpandingPanelState createState() => _ExpandingPanelState();
}

class _ExpandingPanelState extends State<ExpandingPanel> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });


           print(widget.photinfo.pic1.toString()+"---------------------");

           if(widget.photinfo.pic1 != "null" && widget.photinfo.pic1 != "" && widget.photinfo.pic1 != null) {
             navService.pushNamed("/img_gallery_other",
                 args: [widget.photinfo, widget.fullname]);
           }



        },
        child: AnimatedContainer(height: 30 , margin: EdgeInsets.only(top: 10) ,decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
          ),
          color: ColorsPallete.Pink2.withOpacity(0.7),
        ),
          padding: EdgeInsets.all(5),
          duration: Duration(milliseconds: 200),
          width:  70.0, // Adjust the expanded width

          child: Container( child:   Text("Gallery",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold
              ),

          )
        ),
      ),
    ));
  }
}