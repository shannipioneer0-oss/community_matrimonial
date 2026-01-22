import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/network_utils/model/notification_model.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
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



  @override
  Widget build(BuildContext context) {

    print(widget.item.notificationType);

    return

      Container(
        width: MediaQuery.of(context).size.width*0.85,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(left: 15 , right: 15 , top: 15),
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
              widget.item.notificationType,
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
             widget.item.message,
              style: TextStyle(
                fontSize: 16,
                color: ColorsPallete.Pink,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(

              onPressed: () async {


                SharedPreferences prefs = await SharedPreferences.getInstance();

                if(widget.item.notificationType == "interest") {
                final resposne = await DialogClass().showDialogBeforeAcceptReject(context, "Interest Accept/Reject Request" , "Accept or Reject like request of this person" , "Accept" , "Reject" , "Details");

                if(resposne == "Details"){
                  navService.pushNamed("/user_detail" , args: [widget.item.senderId , widget.item.message.split(" ")[0] , ""]);
                }else if(resposne == "Accept"){

                  final _response = await Provider.of<ApiService>(context, listen: false).
                  postInterestAcceptReject({  "from_id":widget.item.receiverId,
                    "to_id": widget.item.senderId ,
                    "comments": DialogClass.comments.text.toString(),
                    "accept":"1",
                    "reject":"0"
                  });

                final notifi_count = await Provider.of<ApiService>(context, listen: false).
                  postInsertNotificationCount(
                      {
                        "notification_id":widget.item.id,
                        "user_id": widget.item.receiverId,
                        "isread":"1"
                      }
                  );

                if(notifi_count.body["data"]["affectedRows"] == 1){

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));

                }



                }else if(resposne == "Reject"){


                  final _response = await Provider.of<ApiService>(context, listen: false).
                  postInterestAcceptReject({  "from_id":widget.item.receiverId,
                    "to_id": widget.item.senderId ,
                    "comments": DialogClass.comments.text.toString(),
                    "accept":"0",
                    "reject":"1"
                  });

                  final notifi_count = await Provider.of<ApiService>(context, listen: false).
                  postInsertNotificationCount(
                      {
                        "notification_id":widget.item.id,
                        "user_id": widget.item.receiverId,
                        "isread":"1"
                      }
                  );

                  if(notifi_count.body["data"]["affectedRows"] == 1){

                    widget.callbackFunction("");

                  }

                }

                }else if(widget.item.notificationType == "request_call"){

                  final resposne = await DialogClass().showDialogBeforeAcceptReject(context, "Interest Accept/Reject Call Request" , "Accept or Reject Call request of this person" , "Accept" , "Close" , "Details");

                  if(resposne == "Details"){
                    navService.pushNamed("/user_detail" , args: [widget.item.senderId , widget.item.message.split(" ")[0]]);

                  }else if(resposne == "Accept"){

                    final _response = await Provider.of<ApiService>(context, listen: false).
                    postUpdateAllowedFromUser({
                      "from_id":widget.item.senderId,
                      "to_id": widget.item.receiverId,
                      "type":"phone",
                      "communityId": prefs.getString(SharedPrefs.communityId)
                    });

                    print({
                      "from_id":widget.item.senderId,
                      "to_id": widget.item.receiverId,
                      "type":"phone",
                      "communityId": prefs.getString(SharedPrefs.communityId)
                    });

                    final notifi_count = await Provider.of<ApiService>(context, listen: false).
                    postInsertNotificationCount(
                        {
                          "notification_id":widget.item.id,
                          "user_id": widget.item.receiverId,
                          "isread":"1"
                        }
                    );

                    if(notifi_count.body["data"]["affectedRows"] == 1){

                      widget.callbackFunction("");

                    }



                  }

                }else if(widget.item.notificationType == "request_horoscope"){
                  final resposne = await DialogClass().showDialogBeforeAcceptReject(context, "Interest Accept/Reject Horoscope View Request" , "Accept or Reject Horoscope View request of this person" , "Accept" , "Close" , "Details");

                  if(resposne == "Details"){
                    navService.pushNamed("/user_detail" , args: [widget.item.senderId , widget.item.message.split(" ")[0]]);
                  }else if(resposne == "Accept"){

                    final _response = await Provider.of<ApiService>(context, listen: false).
                    postUpdateAllowedFromUser({
                      "from_id":widget.item.senderId,
                      "to_id": widget.item.receiverId,
                      "type":"horoscope",
                      "communityId": prefs.getString(SharedPrefs.communityId)
                    });

                    final notifi_count = await Provider.of<ApiService>(context, listen: false).
                    postInsertNotificationCount(
                        {
                          "notification_id":widget.item.id,
                          "user_id": widget.item.receiverId,
                          "isread":"1"
                        }
                    );

                    if(notifi_count.body["data"]["affectedRows"] == 1){

                         widget.callbackFunction("");

                    }



                  }

                }
                
              },
              icon: Icon(
                Icons.star,
                color: Colors.white,
              ),
              label: Text(
               widget.item.notificationType == "interest" ? "Accept/Reject Request" : 'Grant/Reject Permission',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      );

  }


}