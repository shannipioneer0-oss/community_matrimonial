import 'dart:async';


import 'package:community_matrimonial/app_utils/Userdata.dart';
import 'package:community_matrimonial/screens/videocalls/buttons.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network_utils/service/api_service.dart';
import 'dart:math' as math;


class Call extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  /*final List list;
  const Call({Key? key, required this.list}) : super(key: key);

  @override
  State<Call> createState() => _CallState();

}

class _CallState extends State<Call> {


  final List<int> _remoteUsers = [];
  int? _localUser;
  final RtcEngine _engine = createAgoraRtcEngine();
  int _remainingTime = 180; // 5 minutes in seconds
  late Timer _timer;

  bool iscallconnetced = false;


  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_remainingTime < 1) {
          timer.cancel();

          _remoteUsers.removeAt(0);
          addVideoData();
          // Perform actions when timer ends
          _handleTimerEnd();
        } else {
          _remainingTime -= 1;
        }
      });
    });
  }


  addVideoData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    double minutes = (180-_remainingTime) / 60;
    int roundedMinutes =  math.max(1 , minutes.ceil());

    if(widget.list[4] != "-1" && iscallconnetced) {
      final _response = await Provider.of<ApiService>(
          context, listen: false).postInsertVideoData({
        "fromId": prefs.getString(SharedPrefs.userId),
        "memberId": widget.list[4],
        "duration": roundedMinutes.toString(),
        "communityId": prefs.getString(SharedPrefs.communityId),
      });
    }

    Future.delayed(Duration(milliseconds: 100), () {
      Userdata().initUserData(context);
    });

  }








  void _handleTimerEnd() {
    // Handle actions when timer ends (e.g., show a dialog)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Countdown Timer'),
          content: Text('Your Video Call Ended'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }



  @override
  void initState() {
    super.initState();
    initAgora();

    _engine.adjustCustomAudioPublishVolume(trackId: 1 , volume: 0);
    _engine.adjustAudioMixingPlayoutVolume(0);
    _engine.adjustLoopbackSignalVolume(0);
    _engine.adjustPlaybackSignalVolume(0);
  }

  @override
  void dispose() {
    super.dispose();
    disposeAgora();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {

    String minutes = (_remainingTime ~/ 60).toString().padLeft(2, '0');
    String seconds = (_remainingTime % 60).toString().padLeft(2, '0');


    return Scaffold(
      body: Stack(
        children: [
          switch (_remoteUsers.length) {
            0 => localVideo(),
            1 => Stack(
                children: [
                  remoteVideo(_remoteUsers[0]),
                  miniLocalVideo(),
                ],
              ),
            2 => Stack(
                children: [
                  Column(
                    children: [
                      Expanded(child: remoteVideo(_remoteUsers[0])),
                      Expanded(child: remoteVideo(_remoteUsers[1])),
                    ],
                  ),
                  miniLocalVideo(),
                ],
              ),
            _ => const Center(
                child: Text("This app supports up to 3 people in a call"),
              ),
          },
          CallButtons(engine: _engine , remainingTime: _remainingTime, otheruserid: widget.list[4], isconnected: iscallconnetced,),
          Align(alignment: Alignment.topCenter ,child:Text(
            '$minutes:$seconds',
            style: TextStyle(fontSize: 48),
          ),)
        ],
      ),
    );
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    await _engine.initialize(const RtcEngineContext(
      appId: "4cc65cfab1864d6daeda7dc86d88e7e3",
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            _localUser = connection.localUid;
          });
        },
        onError: (ErrorCodeType code, String message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $code, $message")),
          );
         // Navigator.pop(context);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _remoteUsers.add(remoteUid);
            _startTimer();
            iscallconnetced = true;

          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          setState(() {
            _remoteUsers.remove(remoteUid);
            _handleTimerEnd();
            addVideoData();

          });
        },
        onTokenPrivilegeWillExpire:
            (RtcConnection connection, String token) async {
          String token = widget.list[1];
          _engine.renewToken(token);
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();

    print(widget.list[1]);

    await _engine.joinChannel(
      token: widget.list[1],
      channelId: widget.list[0],
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> disposeAgora() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  Widget miniLocalVideo() {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(0),
          margin: const EdgeInsets.only(bottom: 80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.pinkAccent, // Set the border color
              width: 5.0, // Set the border width
            ),
          ),
          clipBehavior: Clip.antiAlias,
          width: 120,
          height: 150,
          child: localVideo(),
        ),
      ),
    );
  }

  Widget localVideo() {
    return _localUser != null
        ? AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: _engine,
              canvas: const VideoCanvas(uid: 0),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }

  Widget remoteVideo(int remoteUid) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: _engine,
        canvas: VideoCanvas(
          uid: remoteUid,
        ),
        connection: RtcConnection(channelId: widget.list[0]),
      ),
    );
  }*/


}
