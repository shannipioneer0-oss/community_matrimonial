
import 'package:community_matrimonial/app_utils/Userdata.dart';
import 'package:community_matrimonial/screens/videocalls/call.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

import '../../network_utils/service/api_service.dart';


class CallButtons extends StatefulWidget {
  // final RtcEngine engine;
  /*final int remainingTime;
  final String otheruserid;
  final bool isconnected;*/
 // const CallButtons({super.key, required this.engine, required this.remainingTime, required this.otheruserid, required this.isconnected});

  @override
  State<CallButtons> createState() => _CallButtonsState();
}

class _CallButtonsState extends State<CallButtons> {
  bool muted = false;


  addVideoData() async {

   /* SharedPreferences prefs = await SharedPreferences.getInstance();

    double minutes = (180-widget.remainingTime) / 60;
    int roundedMinutes =  math.max(1 , minutes.ceil());

    if(widget.otheruserid != "-1" && widget.isconnected) {
      final _response = await Provider.of<ApiService>(
          context, listen: false).postInsertVideoData({
        "fromId": prefs.getString(SharedPrefs.userId),
        "memberId": widget.otheruserid,
        "duration": roundedMinutes.toString(),
        "communityId": prefs.getString(SharedPrefs.communityId),
      });
    }
*/


  }







  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RawMaterialButton(
              onPressed: () async {
                setState(() {
                  muted = !muted;
                });
               // await widget.engine.muteLocalAudioStream(muted);
              },
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor: muted ? Colors.blueAccent : Colors.white,
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                muted ? Icons.mic_off : Icons.mic,
                color: muted ? Colors.white : Colors.blueAccent,
                size: 20.0,
              ),
            ),
            RawMaterialButton(
              onPressed: () async {
                Navigator.pop(context);

                addVideoData();
                Future.delayed(Duration(milliseconds: 100), () {
                    Userdata().initUserData(context);
                });

              },
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.redAccent,
              padding: const EdgeInsets.all(15.0),
              child: const Icon(
                Icons.call_end,
                color: Colors.white,
                size: 35.0,
              ),
            ),
            RawMaterialButton(
              onPressed: () async {
               // await widget.engine.switchCamera();
              },
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.white,
              padding: const EdgeInsets.all(12.0),
              child: const Icon(
                Icons.switch_camera,
                color: Colors.blueAccent,
                size: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
