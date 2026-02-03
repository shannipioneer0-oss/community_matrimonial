import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/SendNotification.dart';
import 'package:community_matrimonial/network_utils/model/fetch_matches_match.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/dashboard/dashboard.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DashboardList extends StatefulWidget {
  final UserMatch user;
  final int index;
  final Function(int) onUpdate;
  final SharedPreferences prefs;

  DashboardList(
      {Key? key,
      required this.user,
      required this.index,
      required this.onUpdate, required this.prefs});

  @override
  DashboardListStateful createState() => DashboardListStateful();
}

class DashboardListStateful extends State<DashboardList> {
  final GlobalKey<DashboardScreen> counterKey = GlobalKey<DashboardScreen>();

  bool iscontain() {
    return widget.user.shortlist.split(",").contains(widget.user.userId);
  }

  bool iscontainLikes() {
    return widget.user.likes.split(",").contains(widget.user.userId);
  }



  @override
  void initState() {
    super.initState();

    print(Strings.IMAGE_BASE_URL +
        "/uploads/" +utils().imagePath(widget.prefs.getString(SharedPrefs.communityId).toString())+
        widget.user.pic.toString()+"+++++=====");

    print(widget.user.pic);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.user.isshortlist == iscontain()
        ? Colors.pinkAccent
        : Colors.grey;
    final iconColor =
        widget.user.isshortlist == iscontain() ? Colors.white : Colors.pink;

    return GestureDetector(
        onTap: () async {
        final result =  await navService.pushNamed("/user_detail",
              args: [widget.user.userId, widget.user.name , widget.user.mobRegToken , widget.user.profileId]);



           if(result != null){
             widget.onUpdate(0);

           }

        },
        child: Stack(
          children: [


            Positioned(
                child: Container(
                    key: Key(widget.index.toString()),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.5)),
            Stack(
              children: [

                Positioned(
                    child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.9, // Set the width of the container
                  height: MediaQuery.of(context).size.height *
                      0.45, // Set the height of the container
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    // Set the border radius for rounded corners
                    // Set the background color
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.2), // Set the shadow color
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2), // Adjust the shadow offset
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      widget.user.pic != null && ( widget.user.verifypic1 == "1" ||  widget.user.verifypic1 == "0")
                          ? Strings.IMAGE_BASE_URL +
                              "/uploads/" +utils().imagePath(widget.prefs.getString(SharedPrefs.communityId).toString())+
                              widget.user.pic.toString()
                          : Strings.IMAGE_BASE_URL +
                          "/uploads/"+utils().imagePath(widget.prefs.getString(SharedPrefs.communityId).toString())+widget.user.oldpic1.toString(),
                      // Replace with your image URL
                      width: MediaQuery.of(context).size.width *
                          0.9, // Set the width of the container
                      height: MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit
                          .fitHeight,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset("assets/images/no_image.png" , fit: BoxFit.fitHeight,);
                      },
                    ),
                  ),
                )),
                Positioned(
                    bottom: 0,
                    child: Image.asset(
                        "assets/images/bottom_dashboard_list.png",
                        height: MediaQuery.of(context).size.height * 0.21,
                        fit: BoxFit.contain,
                        color: ColorsPallete.blue_2)),
                Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.04,
                    left: 25,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      widget.user.fullname,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    )),
                                SizedBox(
                                  width: 0,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            "assets/images/education.png",
                                            width: 20,
                                            height: 20,
                                            color: Colors.white),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.33,
                                            child: Text(
                                              widget.user.education.toString(),
                                              maxLines: 4,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ))
                                      ],
                                    ))
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 7),
                              child: Text(
                                  "Age " +
                                      utils()
                                          .calculateAge(utils().convertMarathiDateToEnglish(widget.user.dob))
                                          .toString() +
                                      " ," +
                                      widget.user.height.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300)),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 7),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/work.png",
                                    width: 15,
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(widget.user.occupation.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300))
                                ],
                              ),
                            ),
                          ],
                        ))),

              ],
            ),

            Positioned(
                bottom: 10,
                left: 20,
                child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ColorsPallete.blue_2)),
                                onPressed: () async {

                                  SharedPreferences prefs = await SharedPreferences.getInstance();

                                  print(prefs.getString(SharedPrefs.validityDays));

                                  if (prefs.getString(SharedPrefs.validityDays) !=
                                      null && !prefs.getString(SharedPrefs.validityDays)!.isEmpty) {
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
                                            "to_id": widget.user.userId,
                                            "is_sent": "1",
                                            "communityId": prefs.getString(
                                                SharedPrefs.communityId)
                                          });

                                          if (_response.body["data"]
                                                  ["affectedRows"] ==
                                              1) {
                                            setState(() {
                                              widget.user.likes =
                                                  widget.user.likes +
                                                      "," +
                                                      widget.user.userId;
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
                                              "sender_id": prefs.getString(
                                                  SharedPrefs.userId),
                                              "reciever_id": widget.user.userId,
                                              "communityId": prefs.getString(
                                                  SharedPrefs.communityId)
                                            });

                                            print(widget.user.mobRegToken);
                                            SendNotification().sendWhatsapp(
                                              widget.user.whatsapp,
                                              "Like Request From " +
                                                  prefs
                                                      .getString(SharedPrefs
                                                      .fullname)
                                                      .toString()+"\n"+
                                                  "The Request is from Community Matrimonial regarding like request from " +
                                                  prefs
                                                      .getString(SharedPrefs
                                                      .fullname)
                                                      .toString() +
                                                  " Please kindly accept or reject request from Notification section from app or website",
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
                                          "Please upgrade to Membership Plans to Exprress More Interests",
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
                                            "to_id": widget.user.userId,
                                            "is_sent": "1",
                                            "communityId": prefs.getString(
                                                SharedPrefs.communityId)
                                          });

                                          if (_response.body["data"]
                                                  ["affectedRows"] ==
                                              1) {
                                            setState(() {
                                              widget.user.likes =
                                                  widget.user.likes +
                                                      "," +
                                                      widget.user.userId;
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
                                              "sender_id": prefs.getString(
                                                  SharedPrefs.userId),
                                              "reciever_id": widget.user.userId,
                                              "communityId": prefs.getString(
                                                  SharedPrefs.communityId)
                                            });

                                            print(widget.user.mobRegToken);
                                            SendNotification().sendWhatsapp(
                                                widget.user.whatsapp,
                                                "Like Request From " +
                                                    prefs
                                                        .getString(SharedPrefs
                                                            .fullname)
                                                        .toString()+"\n"+
                                                "The Request is from Community Matrimonial regarding like request from " +
                                                    prefs
                                                        .getString(SharedPrefs
                                                            .fullname)
                                                        .toString() +
                                                    " Please kindly accept or reject request from Notification section from app or website",
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
                                icon: Image.asset(
                                  "assets/images/send_icon.png",
                                  width: 15,
                                  height: 15,
                                ),
                                label: Text(
                                  iscontainLikes()
                                      ? "Interest Sent"
                                      : "Send Interest",
                                  style: TextStyle(fontSize: 14 ,color: Colors.white),
                                ))),
                        SizedBox(
                          width: 10,
                        ),

                      ],
                    ))),
            Positioned(
              left: 0,
              top: 0,
              child: GestureDetector(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  if (iscontain() == false) {
                    final result = await DialogClass().showDialogBeforesubmit(
                        context,
                        "Shortlist alert!",
                        "Are you sure you want to shortlist this person?",
                        "Shortlist",
                        "shortlist");

                    if (result == "shortlist") {
                      final _response =
                          await Provider.of<ApiService>(context, listen: false)
                              .postshortlistInsert({
                        "fromId": prefs.getString(SharedPrefs.userId),
                        "memberId": widget.user.userId,
                        "is_shortlist": "1",
                        "communityId": prefs.getString(SharedPrefs.communityId)
                      });

                      print(_response.body.toString());

                      if (_response.body["success"] == 1) {
                        setState(() {
                          //   widget.user.isshortlist = true;
                          widget.user.shortlist =
                              widget.user.shortlist + "," + widget.user.userId;
                        });

                        print(widget.user.shortlist +
                            " " +
                            iscontain().toString());
                      }
                    }
                  } else {
                    final result = await DialogClass().showDialogBeforesubmit(
                        context,
                        "Shortlist alert!",
                        "Are you sure you want to remove shortlist",
                        "Remove",
                        "shortlist");

                    if (result == "shortlist") {
                      final _response =
                          await Provider.of<ApiService>(context, listen: false)
                              .postshortlistInsert({
                        "fromId": prefs.getString(SharedPrefs.userId),
                        "memberId": widget.user.userId,
                        "is_shortlist": "0",
                        "communityId": prefs.getString(SharedPrefs.communityId)
                      });

                      print(_response.body.toString());

                      if (_response.body["success"] == 1) {
                        setState(() {
                          //  widget.user.isshortlist = false;
                          widget.user.shortlist = widget.user.shortlist
                              .replaceAll("," + widget.user.userId, "");
                        });

                        print(widget.user.shortlist +
                            " " +
                            iscontain().toString());
                      }
                    }
                  }
                },
                child: Container(
                    key: Key(widget.index.toString()),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                        ),
                        color:
                            backgroundColor // Set the background color as needed
                        ),
                    child: Image.asset("assets/images/shortlist.png",
                        width: 30, height: 25, color: iconColor)),
              ),
            ),
            Positioned(
              right: 25,
              top: 10 ,
              child:Container(
                  width: 160,
                  height: 25,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(20), // Adjust the value for desired roundness
                  ), child: Text(
    (widget.index+1).toString()+") "+widget.user.profileId.toString(),textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              )),),

          ],
        ));
  }
}