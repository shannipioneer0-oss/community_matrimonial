import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/network_utils/model/fetch_matches.dart';
import 'package:community_matrimonial/network_utils/model/fetch_matches_match.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_utils/SendNotification.dart';
import '../../network_utils/service/api_service.dart';

class SearchResultList extends StatefulWidget {
  final User fetchmatches;
  final int index;
  final SharedPreferences prefs;

  SearchResultList({required this.fetchmatches , required this.index, required this.prefs});

  @override
  SearchResultListStateful createState() => SearchResultListStateful();
}

class SearchResultListStateful extends State<SearchResultList> {
  bool iscontain() {
    return widget.fetchmatches.shortlist
        .split(",")
        .contains(widget.fetchmatches.userId);
  }

  bool iscontainLikes() {
    return widget.fetchmatches.likes
        .split(",")
        .contains(widget.fetchmatches.userId);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.fetchmatches.dob+"+++++=====");

     initprefs();

  }

  String role= "";
  initprefs() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      role = prefs.getString(SharedPrefs.role_type).toString();
    });


    print(role);

  }



  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.fetchmatches.isshortlist == iscontain()
        ? Colors.pinkAccent
        : Colors.grey;
    final iconColor = widget.fetchmatches.isshortlist == iscontain()
        ? Colors.white
        : Colors.pink;

    print(widget.fetchmatches.pic+"()()====");

    return Column(children: [
      GestureDetector(
          onTap: () {
            navService.pushNamed("/user_detail",
                args: [widget.fetchmatches.userId, widget.fetchmatches.name , widget.fetchmatches.mobRegToken , widget.fetchmatches.profileId]);
          },
          child: Container(
              height: 205,
              child: Stack(
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 4.0,
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.92,
                            height: 195,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.network(
                                        widget.fetchmatches.pic != "" && (widget.fetchmatches.verifypic1 == "1" || widget.fetchmatches.verifypic1 == "0")
                                            ? Strings.IMAGE_BASE_URL +
                                                "/uploads/"+utils().imagePath(widget.prefs.getString(SharedPrefs.communityId).toString())+
                                                widget.fetchmatches.pic
                                            : Strings.IMAGE_BASE_URL +
                                            "/uploads/"+utils().imagePath(widget.prefs.getString(SharedPrefs.communityId).toString()) +widget.fetchmatches.oldpic1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        height: 195,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(child: Image.asset("assets/images/user_image.png"),);
                                        },
                                      ),
                                    )),
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, top: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            child: Text(
                                              widget.fetchmatches.fullname
                                                  .toString(),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.60,
                                            child: Text(
                                              'Age ' +
                                                  utils()
                                                      .calculateAge(widget
                                                          .fetchmatches.dob)
                                                      .toString() +
                                                  ", " +
                                                  widget.fetchmatches.height
                                                      .toString(),
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
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Text(
                                                  widget.fetchmatches.education,
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black87,
                                                      overflow:
                                                          TextOverflow.clip),
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
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Text(
                                                  widget
                                                      .fetchmatches.occupation,
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black87,
                                                      overflow:
                                                          TextOverflow.clip),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.0),
                                          Row(children: [

                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.5,
                                              child: Text(
                                                widget
                                                    .fetchmatches.handicap_detail,
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 13.0,
                                                    fontWeight:
                                                    FontWeight.w800,
                                                    color: Colors.red,
                                                    overflow:
                                                    TextOverflow.clip),
                                              ),
                                            ),

                                          ],)
                                        ],
                                      ),
                                    ))
                              ],
                            )),
                      )),
                  Positioned(
                    left: 15,
                    top: 4,
                    child: GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        if (iscontain() == false) {
                          final result = await DialogClass()
                              .showDialogBeforesubmit(
                                  context,
                                  "Shortlist alert!",
                                  "Are you sure you want to shortlist this person",
                                  "Shortlist",
                                  "shortlist");

                          if (result == "shortlist") {
                            final _response = await Provider.of<ApiService>(
                                    context,
                                    listen: false)
                                .postshortlistInsert({
                              "fromId": prefs.getString(SharedPrefs.userId),
                              "memberId": widget.fetchmatches.userId,
                              "is_shortlist": "1",
                              "communityId":
                                  prefs.getString(SharedPrefs.communityId)
                            });

                            print(_response.body.toString());

                            if (_response.body["success"] == 1) {
                              setState(() {
                                //   widget.user.isshortlist = true;
                                widget.fetchmatches.shortlist =
                                    widget.fetchmatches.shortlist +
                                        "," +
                                        widget.fetchmatches.userId;
                              });

                              print(widget.fetchmatches.shortlist +
                                  " " +
                                  iscontain().toString());
                            }
                          }
                        } else {
                          final result = await DialogClass().showDialogBeforesubmit(
                              context,
                              "Shortlist alert!",
                              "Are you sure you want to remove shortlist this person?",
                              "Remove",
                              "shortlist");

                          if (result == "shortlist") {
                            final _response = await Provider.of<ApiService>(
                                    context,
                                    listen: false)
                                .postshortlistInsert({
                              "fromId": prefs.getString(SharedPrefs.userId),
                              "memberId": widget.fetchmatches.userId,
                              "is_shortlist": "0",
                              "communityId":
                                  prefs.getString(SharedPrefs.communityId)
                            });

                            print(_response.body.toString());

                            if (_response.body["success"] == 1) {
                              setState(() {
                                //  widget.user.isshortlist = false;
                                widget.fetchmatches.shortlist =
                                    widget.fetchmatches.shortlist.replaceAll(
                                        "," + widget.fetchmatches.userId, "");
                              });

                              print(widget.fetchmatches.shortlist +
                                  " " +
                                  iscontain().toString());
                            }
                          }
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                            ),
                            color:
                                backgroundColor, // Set the background color as needed
                          ),
                          child: Image.asset(
                            "assets/images/shortlist.png",
                            width: 17,
                            height: 17,
                            color: iconColor,
                          )),
                    ),
                  ),
                  Positioned(
                    right: 15,
                    top: 4,

                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16.0),
                            ),
                            color:
                            backgroundColor, // Set the background color as needed
                          ),
                          child: Text((widget.index+1).toString() , textAlign: TextAlign.right, style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  Positioned(
                      bottom: 6,
                      left: MediaQuery.of(context).size.width * 0.37,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                if (prefs.getString(
                                        SharedPrefs.validityDays ?? "") !=
                                    "") {
                                  if (int.parse(prefs
                                          .getString(SharedPrefs.numLikes)
                                          .toString()) <=
                                      int.parse(prefs
                                          .getString(
                                              SharedPrefs.numExpressInterests)
                                          .toString())) {
                                    if (iscontainLikes() == false) {
                                      final result = await DialogClass()
                                          .showDialogBeforesubmit(
                                              context,
                                              "Express Interest!",
                                              "Are you sure you want to Send like to this person?",
                                              "Send Like",
                                              "like");

                                      if (result == "like") {
                                        final _response =
                                            await Provider.of<ApiService>(
                                                    context,
                                                    listen: false)
                                                .postExpressInterestInsert({
                                          "from_id": prefs
                                              .getString(SharedPrefs.userId),
                                          "to_id": widget.fetchmatches.userId,
                                          "is_sent": "1",
                                          "communityId": prefs.getString(
                                              SharedPrefs.communityId)
                                        });

                                        if (_response.body["data"]
                                                ["affectedRows"] ==
                                            1) {
                                          setState(() {
                                            widget.fetchmatches.likes =
                                                widget.fetchmatches.likes +
                                                    "," +
                                                    widget.fetchmatches.userId;
                                          });

                                          final _response =
                                              await Provider.of<ApiService>(
                                                      context,
                                                      listen: false)
                                                  .postInsertNotification({
                                            "notifi_type": "interest",
                                            "message": "Like Request from " +
                                                prefs
                                                    .getString(
                                                        SharedPrefs.fullname)
                                                    .toString(),
                                            "sender_type": "user",
                                            "sender_id": prefs
                                                .getString(SharedPrefs.userId),
                                            "reciever_id":
                                                widget.fetchmatches.userId,
                                            "communityId": prefs.getString(
                                                SharedPrefs.communityId)
                                          });

                                          SendNotification().sendWhatsapp(
                                            widget.fetchmatches.whatsapp,
                                            "Like Request From " +
                                            "Like Request From " +
                                                prefs
                                                    .getString(
                                                    SharedPrefs.fullname)
                                                    .toString()+"\n"+
                                                "The Request is from Community Matrimonial regarding like request from " +
                                                prefs
                                                    .getString(
                                                    SharedPrefs.fullname)
                                                    .toString() +
                                                " Please kindly accept or reject request by opening notification section of app or website",
                                          );
                                        }
                                      } else {}
                                    } else {
                                      DialogClass().showDialog2(
                                          context,
                                          "Express Interest alert!",
                                          "Already Expressed Interest",
                                          "Ok");
                                    }
                                  } else {
                                    DialogClass().showDialog2(
                                        context,
                                        "Express Interest alert!",
                                        "Please upgrade to Membership Plans to Express More Interests",
                                        "Ok");
                                  }
                                } else {
                                  if (int.parse(prefs
                                          .getString(SharedPrefs.numLikes)
                                          .toString()) <=
                                      2) {
                                    if (iscontainLikes() == false) {
                                      final result = await DialogClass()
                                          .showDialogBeforesubmit(
                                              context,
                                              "Express Interest!",
                                              "Are you sure you want to Send like to this person?",
                                              "Send Like",
                                              "like");

                                      if (result == "like") {
                                        final _response =
                                            await Provider.of<ApiService>(
                                                    context,
                                                    listen: false)
                                                .postExpressInterestInsert({
                                          "from_id": prefs
                                              .getString(SharedPrefs.userId),
                                          "to_id": widget.fetchmatches.userId,
                                          "is_sent": "1",
                                          "communityId": prefs.getString(
                                              SharedPrefs.communityId)
                                        });

                                        if (_response.body["data"]
                                                ["affectedRows"] ==
                                            1) {
                                          setState(() {
                                            widget.fetchmatches.likes =
                                                widget.fetchmatches.likes +
                                                    "," +
                                                    widget.fetchmatches.userId;
                                          });

                                          final _response =
                                              await Provider.of<ApiService>(
                                                      context,
                                                      listen: false)
                                                  .postInsertNotification({
                                            "notifi_type": "interest",
                                            "message": "Like Request from " +
                                                prefs
                                                    .getString(
                                                        SharedPrefs.fullname)
                                                    .toString(),
                                            "sender_type": "user",
                                            "sender_id": prefs
                                                .getString(SharedPrefs.userId),
                                            "reciever_id":
                                                widget.fetchmatches.userId,
                                            "communityId": prefs.getString(
                                                SharedPrefs.communityId)
                                          });

                                          SendNotification().sendWhatsapp(
                                              widget.fetchmatches.whatsapp,
                                              "Like Request From " +
                                                  prefs
                                                      .getString(
                                                          SharedPrefs.fullname)
                                                      .toString()+"\n"+
                                              "The Request is from Community Matrimonial regarding like request from " +
                                                  prefs
                                                      .getString(
                                                          SharedPrefs.fullname)
                                                      .toString() +
                                                  " Please kindly accept or reject request by opening notification section of app or website",
                                              );
                                        }
                                      } else {}
                                    } else {
                                      DialogClass().showDialog2(
                                          context,
                                          "Express Interest alert!",
                                          "Already Expressed Interest",
                                          "Ok");
                                    }
                                  } else {
                                    DialogClass().showDialog2(
                                        context,
                                        "Express Interest alert!",
                                        "Please upgrade to Membership Plans",
                                        "Ok");
                                  }
                                }
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/ellipse_white.png",
                                    width: 40,
                                    height: 40,
                                    color: iscontainLikes() == false
                                        ? ColorsPallete.blue_2
                                        : ColorsPallete.Pink2,
                                  ),
                                  Positioned(
                                      top: 10,
                                      child: Image.asset(
                                        "assets/images/send_icon.png",
                                        width: 15,
                                        height: 15,
                                      ))
                                ],
                              )),
                          SizedBox(
                            width: 2,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                "assets/images/ellipse_white.png",
                                width: 40,
                                height: 40,
                                color: ColorsPallete.Pink,
                              ),
                              Positioned(
                                  top: 10,
                                  child: Image.asset(
                                    "assets/images/chat_icon.png",
                                    width: 15,
                                    height: 15,
                                  ))
                            ],
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Stack(alignment: Alignment.center, children: [
                            Image.asset(
                              "assets/images/rounded_white.png",
                              width: 140,
                              height: 35,
                              color: ColorsPallete.Pink,
                            ),
                            Positioned(
                                top: 10,
                                child: Text(
                                  widget.fetchmatches.profileId.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ))
                          ])
                        ],
                      )),
                  role == "admin" ? Positioned( bottom: 6 ,left: 14 ,child: GestureDetector(onTap: (){

                     navService.pushNamed("/user_detail_other", args: widget.fetchmatches.userId);


                  }  ,child:Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.0),
                      ),
                      color:
                      backgroundColor, // Set the background color as needed
                    ),
                    child: Image.asset("assets/images/edit.png" ,color: Colors.white, width: 20, height: 20,),),
                  )) : Container()
                ],
              ))),
      SizedBox(
        height: 10,
      )
    ]);
  }
}

class SearchResultListOther extends StatefulWidget {
  final UserMatch fetchmatches;
  final SharedPreferences prefs;

  SearchResultListOther({required this.fetchmatches, required this.prefs});

  @override
  SearchResultListOtherStateful createState() =>
      SearchResultListOtherStateful();
}

class SearchResultListOtherStateful extends State<SearchResultListOther> {
  bool iscontain() {
    return widget.fetchmatches.shortlist
        .split(",")
        .contains(widget.fetchmatches.userId);
  }

  bool iscontainLikes() {
    return widget.fetchmatches.likes
        .split(",")
        .contains(widget.fetchmatches.userId);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.fetchmatches.isshortlist == iscontain()
        ? Colors.pinkAccent
        : Colors.grey;
    final iconColor = widget.fetchmatches.isshortlist == iscontain()
        ? Colors.white
        : Colors.pink;

    return Column(children: [
      GestureDetector(
          onTap: () {
            navService.pushNamed("/user_detail",
                args: [widget.fetchmatches.userId, widget.fetchmatches.name , widget.fetchmatches.mobRegToken , widget.fetchmatches.profileId]);
          },
          child: Container(
              height: 160,
              child: Stack(
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 4.0,
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.92,
                            height: 150,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.network(
                                          widget.fetchmatches.pic != null && widget.fetchmatches.verifypic1 == "1"
                                              ? Strings.IMAGE_BASE_URL +
                                              "/uploads/" +utils().imagePath(widget.prefs.getString(SharedPrefs.communityId).toString())+
                                              widget.fetchmatches.pic.toString()
                                              : Strings.IMAGE_BASE_URL +
                                              "/uploads/"+utils().imagePath(widget.prefs.getString(SharedPrefs.communityId).toString())+widget.fetchmatches.oldpic1.toString(),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        height: 150,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset("assets/images/no_image.png" , fit: BoxFit.fitHeight,);
                                        },
                                      ),
                                    )),
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, top: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.60,
                                            child: Text(
                                              widget.fetchmatches.fullname
                                                  .toString(),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.60,
                                            child: Text(
                                              'Age ' +
                                                  utils()
                                                      .calculateAge(utils().convertMarathiDateToEnglish(widget
                                                          .fetchmatches.dob))
                                                      .toString() +
                                                  ", " +
                                                  widget.fetchmatches.height
                                                      .toString(),
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
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Text(
                                                  widget.fetchmatches.education.toString(),
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black87,
                                                      overflow:
                                                          TextOverflow.clip),
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
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Text(
                                                  widget
                                                      .fetchmatches.occupation.toString(),
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black87,
                                                      overflow:
                                                          TextOverflow.clip),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            )),
                      )),
                  Positioned(
                    left: 13,
                    top: 4,
                    child: GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        if (iscontain() == false) {
                          final result = await DialogClass()
                              .showDialogBeforesubmit(
                                  context,
                                  "Shortlist alert!",
                                  "Are you sure you want to shortlist this person",
                                  "Shortlist",
                                  "shortlist");

                          if (result == "shortlist") {
                            final _response = await Provider.of<ApiService>(
                                    context,
                                    listen: false)
                                .postshortlistInsert({
                              "fromId": prefs.getString(SharedPrefs.userId),
                              "memberId": widget.fetchmatches.userId,
                              "is_shortlist": "1",
                              "communityId":
                                  prefs.getString(SharedPrefs.communityId)
                            });

                            print(_response.body.toString());

                            if (_response.body["success"] == 1) {
                              setState(() {
                                //   widget.user.isshortlist = true;
                                widget.fetchmatches.shortlist =
                                    widget.fetchmatches.shortlist +
                                        "," +
                                        widget.fetchmatches.userId;
                              });

                              print(widget.fetchmatches.shortlist +
                                  " " +
                                  iscontain().toString());
                            }
                          }
                        } else {
                          final result = await DialogClass().showDialogBeforesubmit(
                              context,
                              "Shortlist alert!",
                              "Are you sure you want to remove shortlist this person?",
                              "Remove",
                              "shortlist");

                          if (result == "shortlist") {
                            final _response = await Provider.of<ApiService>(
                                    context,
                                    listen: false)
                                .postshortlistInsert({
                              "fromId": prefs.getString(SharedPrefs.userId),
                              "memberId": widget.fetchmatches.userId,
                              "is_shortlist": "0",
                              "communityId":
                                  prefs.getString(SharedPrefs.communityId)
                            });

                            print(_response.body.toString());

                            if (_response.body["success"] == 1) {
                              setState(() {
                                //  widget.user.isshortlist = false;
                                widget.fetchmatches.shortlist =
                                    widget.fetchmatches.shortlist.replaceAll(
                                        "," + widget.fetchmatches.userId, "");
                              });

                              print(widget.fetchmatches.shortlist +
                                  " " +
                                  iscontain().toString());
                            }
                          }
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                            ),
                            color:
                                backgroundColor, // Set the background color as needed
                          ),
                          child: Image.asset(
                            "assets/images/shortlist.png",
                            width: 17,
                            height: 17,
                            color: iconColor,
                          )),
                    ),
                  ),
                  Positioned(
                      bottom: 6,
                      left: MediaQuery.of(context).size.width * 0.37,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                if (prefs.getString(
                                        SharedPrefs.validityDays ?? "") !=
                                    "") {
                                  if (int.parse(prefs
                                          .getString(SharedPrefs.numLikes)
                                          .toString()) <=
                                      int.parse(prefs
                                          .getString(
                                              SharedPrefs.numExpressInterests)
                                          .toString())) {
                                    if (iscontainLikes() == false) {
                                      final result = await DialogClass()
                                          .showDialogBeforesubmit(
                                              context,
                                              "Express Interest!",
                                              "Are you sure you want to Send like to this person?",
                                              "Send Like",
                                              "like");

                                      if (result == "like") {
                                        final _response =
                                            await Provider.of<ApiService>(
                                                    context,
                                                    listen: false)
                                                .postExpressInterestInsert({
                                          "from_id": prefs
                                              .getString(SharedPrefs.userId),
                                          "to_id": widget.fetchmatches.userId,
                                          "is_sent": "1",
                                          "communityId": prefs.getString(
                                              SharedPrefs.communityId)
                                        });

                                        if (_response.body["data"]
                                                ["affectedRows"] ==
                                            1) {
                                          setState(() {
                                            widget.fetchmatches.likes =
                                                widget.fetchmatches.likes +
                                                    "," +
                                                    widget.fetchmatches.userId;
                                          });

                                          final _response =
                                              await Provider.of<ApiService>(
                                                      context,
                                                      listen: false)
                                                  .postInsertNotification({
                                            "notifi_type": "interest",
                                            "message": "Like Request from " +
                                                prefs
                                                    .getString(
                                                        SharedPrefs.fullname)
                                                    .toString(),
                                            "sender_type": "user",
                                            "sender_id": prefs
                                                .getString(SharedPrefs.userId),
                                            "reciever_id":
                                                widget.fetchmatches.userId,
                                            "communityId": prefs.getString(
                                                SharedPrefs.communityId)
                                          });

                                          SendNotification().sendPushMessage(
                                              [widget.fetchmatches.mobRegToken],
                                              "Like Request From " +
                                                  prefs
                                                      .getString(
                                                          SharedPrefs.fullname)
                                                      .toString(),
                                              "The Request is from Community Matrimonial regarding like request from " +
                                                  prefs
                                                      .getString(
                                                          SharedPrefs.fullname)
                                                      .toString() +
                                                  " Please kindly accept or reject request ",
                                              prefs
                                                  .getString(SharedPrefs.userId)
                                                  .toString(),
                                              widget.fetchmatches.userId);
                                        }
                                      } else {}
                                    } else {
                                      DialogClass().showDialog2(
                                          context,
                                          "Express Interest alert!",
                                          "Already Expressed Interest",
                                          "Ok");
                                    }
                                  } else {
                                    DialogClass().showDialog2(
                                        context,
                                        "Express Interest alert!",
                                        "Please upgrade to Membership Plans to Express More Interests",
                                        "Ok");
                                  }
                                } else {
                                  if (int.parse(prefs
                                          .getString(SharedPrefs.numLikes)
                                          .toString()) <=
                                      2) {
                                    if (iscontainLikes() == false) {
                                      final result = await DialogClass()
                                          .showDialogBeforesubmit(
                                              context,
                                              "Express Interest!",
                                              "Are you sure you want to Send like to this person?",
                                              "Send Like",
                                              "like");

                                      if (result == "like") {
                                        final _response =
                                            await Provider.of<ApiService>(
                                                    context,
                                                    listen: false)
                                                .postExpressInterestInsert({
                                          "from_id": prefs
                                              .getString(SharedPrefs.userId),
                                          "to_id": widget.fetchmatches.userId,
                                          "is_sent": "1",
                                          "communityId": prefs.getString(
                                              SharedPrefs.communityId)
                                        });

                                        if (_response.body["data"]
                                                ["affectedRows"] ==
                                            1) {
                                          setState(() {
                                            widget.fetchmatches.likes =
                                                widget.fetchmatches.likes +
                                                    "," +
                                                    widget.fetchmatches.userId;
                                          });

                                          final _response =
                                              await Provider.of<ApiService>(
                                                      context,
                                                      listen: false)
                                                  .postInsertNotification({
                                            "notifi_type": "interest",
                                            "message": "Like Request from " +
                                                prefs
                                                    .getString(
                                                        SharedPrefs.fullname)
                                                    .toString(),
                                            "sender_type": "user",
                                            "sender_id": prefs
                                                .getString(SharedPrefs.userId),
                                            "reciever_id":
                                                widget.fetchmatches.userId,
                                            "communityId": prefs.getString(
                                                SharedPrefs.communityId)
                                          });

                                          SendNotification().sendPushMessage(
                                              [widget.fetchmatches.mobRegToken],
                                              "Like Request From " +
                                                  prefs
                                                      .getString(
                                                          SharedPrefs.fullname)
                                                      .toString(),
                                              "The Request is from Community Matrimonial regarding like request from " +
                                                  prefs
                                                      .getString(
                                                          SharedPrefs.fullname)
                                                      .toString() +
                                                  " Please kindly accept or reject request ",
                                              prefs
                                                  .getString(SharedPrefs.userId)
                                                  .toString(),
                                              widget.fetchmatches.userId);
                                        }
                                      } else {}
                                    } else {
                                      DialogClass().showDialog2(
                                          context,
                                          "Express Interest alert!",
                                          "Already Expressed Interest",
                                          "Ok");
                                    }
                                  } else {
                                    DialogClass().showDialog2(
                                        context,
                                        "Express Interest alert!",
                                        "Please upgrade to Membership Plans",
                                        "Ok");
                                  }
                                }
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/ellipse_white.png",
                                    width: 40,
                                    height: 40,
                                    color: iscontainLikes() == false
                                        ? ColorsPallete.blue_2
                                        : ColorsPallete.Pink2,
                                  ),
                                  Positioned(
                                      top: 10,
                                      child: Image.asset(
                                        "assets/images/send_icon.png",
                                        width: 15,
                                        height: 15,
                                      ))
                                ],
                              )),
                          SizedBox(
                            width: 2,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                "assets/images/ellipse_white.png",
                                width: 40,
                                height: 40,
                                color: ColorsPallete.Pink,
                              ),
                              Positioned(
                                  top: 10,
                                  child: Image.asset(
                                    "assets/images/chat_icon.png",
                                    width: 15,
                                    height: 15,
                                  ))
                            ],
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Stack(alignment: Alignment.center, children: [
                            Image.asset(
                              "assets/images/rounded_white.png",
                              width: 140,
                              height: 35,
                              color: ColorsPallete.Pink,
                            ),
                            Positioned(
                                top: 10,
                                child: Text(
                                  widget.fetchmatches.profileId.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ))
                          ])
                        ],
                      ))
                ],
              ))),
      SizedBox(
        height: 10,
      )
    ]);
  }
}

class SearchResultListPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {

        },
        child: Container(
            height: 150,
            child: Stack(
              children: [
                Container(
                    alignment: Alignment.topCenter,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 4.0,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.92,
                          height: 150,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.network(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkr-FKNrPt-Eaee0ypEtgHbL7dWYQcE-BvVg&usqp=CAU",
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            "assets/images/user_image.png");
                                      },
                                    ),
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10, top: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.60,
                                          child: Text(
                                            '',
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.60,
                                          child: Text(
                                            '',
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
                                              "assets/images/location_icon.png",
                                              width: 15,
                                              height: 15,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                              color: Colors.grey,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          )),
                    )),
                Positioned(
                    bottom: 6,
                    left: MediaQuery.of(context).size.width * 0.37,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "assets/images/ellipse_white.png",
                              width: 40,
                              height: 40,
                              color: ColorsPallete.blue_2,
                            ),
                            Positioned(
                                top: 10,
                                child: Image.asset(
                                  "assets/images/send_icon.png",
                                  width: 15,
                                  height: 15,
                                ))
                          ],
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "assets/images/ellipse_white.png",
                              width: 40,
                              height: 40,
                              color: ColorsPallete.Pink,
                            ),
                            Positioned(
                                top: 10,
                                child: Image.asset(
                                  "assets/images/chat_icon.png",
                                  width: 15,
                                  height: 15,
                                ))
                          ],
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Stack(alignment: Alignment.center, children: [
                          Image.asset(
                            "assets/images/rounded_white.png",
                            width: 140,
                            height: 35,
                            color: ColorsPallete.Pink,
                          ),
                          Positioned(
                              top: 10,
                              child: Text(
                                "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ))
                        ])
                      ],
                    ))
              ],
            )));
  }
}
