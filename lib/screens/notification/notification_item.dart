import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/network_utils/model/notification_model.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class NotificationStatefulItem extends StatefulWidget {

  final NotificationItem item;
  final void Function(String) callbackFunction;

  NotificationStatefulItem({required this.item, required this.callbackFunction});

  @override
  NotificationListItem createState() => NotificationListItem();

}



class NotificationListItem extends State<NotificationStatefulItem> {


  String datetimelabel = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    DateFormat inputFormat = DateFormat("dd/MM/yyyy hh:mma");

    try {
      DateTime dateTime = inputFormat.parse(widget.item.datetime);

      datetimelabel = DateFormat('dd MMMM yyyy, hh:mm a').format(dateTime);

      // Output: 2026-03-09T12:59:00.000
    } catch (e) {
      print("Error parsing date: $e");
    }

  }

  @override
  Widget build(BuildContext context) {


    return

      Container(
        width: MediaQuery.of(context).size.width*0.85,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 15 , right: 15 , top: 15 ,bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.pinkAccent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item.notificationType == "interest" ? "Interest Notification" :
              widget.item.notificationType == "list" ? "Notification From Admin" :
              widget.item.notificationType == "profile" ?  "Profile Verification" : "Verification Message",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorsPallete.Pink2,
              ),
            ),
            SizedBox(height: 10),
            Divider(color: ColorsPallete.Pink),
            SizedBox(height: 10),
            Text(
             widget.item.message ,
              style: TextStyle(
                fontSize: 16,
                color: ColorsPallete.Pink,
              ),
            ),
            SizedBox(height: 10),
            Text("Recieved at : "+datetimelabel , style: TextStyle(
              fontSize: 16,
              color: ColorsPallete.purple,
            ),)

          ],
        ),
      );

  }


}