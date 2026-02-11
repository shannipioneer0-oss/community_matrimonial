

import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/network_utils/model/fetch_matches_match.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InboxRowData extends StatelessWidget {

   UserMatch user;
   int selectedindex;
   SharedPreferences prefs;

  InboxRowData(this.user , this.selectedindex ,this.prefs);


   void _showImageDialog(BuildContext context , String url) {
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           content: Image.network(url , width: MediaQuery.of(context).size.width*0.8, height:MediaQuery.of(context).size.height*0.5 , fit: BoxFit.fitHeight),
           actions: <Widget>[
             TextButton(
               onPressed: () {
                 Navigator.of(context).pop();
               },
               child: Text('Close'),
             ),
           ],
         );
       },
     );
   }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){

      navService.pushNamed("/user_detail"  , args: [user.userId, user.name , user.mobRegToken , user.profileId]);

    }  , child:Container( child:Column(children: [

      Container(height: 200 , margin: EdgeInsets.only(bottom: 10)  , child:Stack(
        children: [
          // Your main content widgets, this is the static content in the background
          Container(
            alignment: Alignment.topCenter,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.92,
                height: 210,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: GestureDetector(
                          onTap: () {
                            _showImageDialog(
                              context,
                              Strings.IMAGE_BASE_URL +
                                  "/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+
                                  user.pic.toString(),
                            );
                          },
                          child: Container(
                            child: Image.network(
                              Strings.IMAGE_BASE_URL +
                                  "/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+
                                  user.pic.toString(),
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset("assets/images/no_image.png");
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: Text(
                                user.fullname,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                  color: ColorsPallete.blue_2,
                                ),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: Text(
                                "Age " +
                                    utils().calculateAge(user.dob).toString() +
                                    " ," +
                                    user.height.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/education.png",
                                  width: 20,
                                  height: 20,
                                  color: ColorsPallete.blue_2,
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    user.education.toString(),
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87,
                                        overflow: TextOverflow.clip),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/occupation.png",
                                  width: 16,
                                  height: 16,
                                  color: ColorsPallete.blue_2,
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    user.occupation.toString(),
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87,
                                        overflow: TextOverflow.clip),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // This is your Position widget with the line
          Positioned(
            top: 150,
            left: MediaQuery.of(context).size.width * 0.35,
            child: Container(
              height: 2,
              width: MediaQuery.of(context).size.width * 0.6,
              color: Colors.pink,
            ),
          ),

          // Chat Button
          Positioned(
            bottom: 55,
            left: MediaQuery.of(context).size.width * 0.37,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 30,
                  child: DottedBorder(
                    color: Colors.pink,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 6,
                          child: Text(
                            user.profileId,
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Accept/Reject Button
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width * 0.55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/images/rounded_white.png",
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 35,
                      color: user.accept == "1"
                          ? ColorsPallete.darkGreenColor
                          : user.reject == "0" && user.accept == "0"
                          ? ColorsPallete.darkGreenColor
                          : ColorsPallete.red,
                    ),
                    Positioned(
                      top: 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            user.accept == "1"
                                ? "assets/images/accept.png"
                                : user.reject == "1" && user.accept == "0"
                                ? "assets/images/reject.png"
                                : "assets/images/accept.png",
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            user.accept == "1"
                                ? "Accepted"
                                : user.accept == "0" && user.reject == "1"
                                ? "Rejected"
                                : "Recieved",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

         /* Positioned(bottom: 10 , left: MediaQuery.of(context).size.width*0.08 , child: Row(mainAxisAlignment: MainAxisAlignment.start ,crossAxisAlignment: CrossAxisAlignment.center  ,children: [ Container(width: MediaQuery.of(context).size.width*0.4 ,padding: EdgeInsets.all(5) , decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), // Set the border radius
            color: ColorsPallete.Pink2, // Set the container's background color
          ),    child: Stack(

              children: [

                GestureDetector( onTap: (){

                  if(selectedindex == 0) {
                    DialogClass().showDialog2(
                        context, "Comments From this user", user.comments
                        .toString()
                        .length == 0 ? "No Comments" : user.comments.toString(),
                        "OK");
                  }else{

                    DialogClass().showDialog2(
                        context, "Comments From You", user.comments
                        .toString()
                        .length == 0 ? "No Comments" : user.comments.toString(),
                        "OK");


                  }


                }   ,child:Positioned(child: Row(crossAxisAlignment: CrossAxisAlignment.center   ,children: [ SizedBox(width: 5,) ,Image.asset("assets/images/chat_icon.png" , width: 20, height: 20, color: Colors.white,),SizedBox(width: 5,),SizedBox(width: 1,) ,Text("View Comments" , textAlign: TextAlign.left , style: TextStyle(color: Colors.white , fontWeight:FontWeight.bold , fontSize: 14),) ],), )),


              ]),)]),



          ),
*/

          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {

                    if(selectedindex == 0) {
                      DialogClass().showDialog2(
                          context, "Comments From this user", user.comments
                          .toString()
                          .length == 0 ? "No Comments" : user.comments.toString(),
                          "OK");
                    }else{

                      DialogClass().showDialog2(
                          context, "Comments From You", user.comments
                          .toString()
                          .length == 0 ? "No Comments" : user.comments.toString(),
                          "OK");


                    }

                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: ColorsPallete.blue_2,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/chat_icon.png",
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "View Comments",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Other Button: Chat Here
          /*Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width * 0.55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {



                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: ColorsPallete.blue_2,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/chat_icon.png",
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Chat here",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),*/
        ],
      )
      ),



    ],)));
  }
}