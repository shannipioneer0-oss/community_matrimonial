import 'dart:convert';
import 'dart:io';


import 'package:community_matrimonial/screens/videocalls/call.dart';
import 'package:http/http.dart' as http;


class VideoCalls{

     String getToken(String channelNameTOMatch) {

        final appId = '4cc65cfab1864d6daeda7dc86d88e7e3';
        final appCertificate = 'be5a217853bd42149218ee5d4aa93da1';
        final channelName = channelNameTOMatch;
        final uid = 0;
        //final role = RtcRole.publisher;

        final expirationInSeconds = 600;
        final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        final expireTimestamp = currentTimestamp + expirationInSeconds;

        String token  = "";
       /* final token = RtcTokenBuilder.build(
          appId: appId,
          appCertificate: appCertificate,
          channelName: channelName,
          uid: uid.toString(),
          role: role,
          expireTimestamp: expireTimestamp,
        );*/

        return token ?? "";
      }



/*
     Future<void> displayIncomingCall(String uuid , String caller  ,String avatara ,String channelid , String mobile , String token) async {

       final config = CallKeepIncomingConfig(
         uuid: uuid,
         callerName: caller,
         appName: 'Community Matrimonial',
         avatar: avatara,
         handle: mobile,
         hasVideo: false,
         duration: 30000,
         acceptText: 'Accept',
         declineText: 'Decline',
         missedCallText: 'Missed Video call',
         callBackText: 'Call back',
         extra: <String, dynamic>{'channel': channelid ,'token':token},
         headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},

         androidConfig: CallKeepAndroidConfig(
           logo: "ic_logo",
           showCallBackAction: true,
           showMissedCallNotification: true,
           ringtoneFileName: 'system_ringtone_default',
           accentColor: '#0955fa',
           backgroundUrl: 'assets/test.png',
           incomingCallNotificationChannelName: 'Incoming Calls',
           missedCallNotificationChannelName: 'Missed Calls'

         ),
         iosConfig: CallKeepIosConfig(
           iconName: 'CallKitLogo',
           handleType: CallKitHandleType.generic,
           isVideoSupported: true,
           maximumCallGroups: 2,
           maximumCallsPerCallGroup: 1,
           audioSessionActive: true,
           audioSessionPreferredSampleRate: 44100.0,
           audioSessionPreferredIOBufferDuration: 0.005,
           supportsDTMF: true,
           supportsHolding: true,
           supportsGrouping: false,
           supportsUngrouping: false,
           ringtoneFileName: 'system_ringtone_default',
         ),
       );

       await CallKeep.instance.displayIncomingCall(config);

     }
*/






     Future<bool> sendVideoPushMessage(List<String> userToken , String uuid ,String caller ,String avatar ,String mobile ,String channelName , String token) async {

       String postUrl = "https://fcm.googleapis.com/fcm/send";
       final data = {
         "registration_ids" : userToken,
         "collapse_key" : "type_a",
         "content_available": true,
         "priority": "high",
         "notification" : {
           "title": caller,
           "body" : avatar,
           "mobile": mobile
         },
         "data":{
           "uuid":uuid,
           "caller":caller,
           "avatar":avatar,
           "channel":channelName,
           "mobile":mobile,
           "type":"video",
           "token":token
         }
       };

       final headers = {
         'content-type': 'application/json',
         'Authorization':  'key=AAAA9BOl3WQ:APA91bEPoXS96I4g4W8tEY9ehWEZRnBhPbFxz9mldotvrcFgzOAa8C2QdFTHn1T6H3N3ekCYeF_yid2aFMZKG1gufsUiMdz5YMIGdMT3FKdvAYr5AdUW4I6qiYC-MSu782C3z73sA43-'
       };

       final response = await http.post(Uri.parse(postUrl),
           body: json.encode(data),
           encoding: Encoding.getByName('utf-8'),
           headers: headers);

       print(response.body);

       if (response.statusCode == 200) {
         // on success do sth
         print('test ok push CFM');
         return true;
       } else {
         print(' CFM error');
         // on failure do sth
         return false;
       }
     }

     Future<bool> returnMissedorDeclinevideocalls(List<String> userToken  ,String mobile ,String channelName , String type) async {

       String postUrl = "https://fcm.googleapis.com/fcm/send";
       final data = {
         "registration_ids" : userToken,
         "collapse_key" : "type_a",
         "notification" : {
           "mobile": mobile
         },
         "data":{
           "channel":channelName,
           "mobile":mobile,
           "type":type
         }
       };

       final headers = {
         'content-type': 'application/json',
         'Authorization':  'key=AAAA9BOl3WQ:APA91bEPoXS96I4g4W8tEY9ehWEZRnBhPbFxz9mldotvrcFgzOAa8C2QdFTHn1T6H3N3ekCYeF_yid2aFMZKG1gufsUiMdz5YMIGdMT3FKdvAYr5AdUW4I6qiYC-MSu782C3z73sA43-'
       };

       final response = await http.post(Uri.parse(postUrl),
           body: json.encode(data),
           encoding: Encoding.getByName('utf-8'),
           headers: headers);

       print(response.body);

       if (response.statusCode == 200) {
         // on success do sth
         print('test ok push CFM');
         return true;
       } else {
         print(' CFM error');
         // on failure do sth
         return false;
       }
     }




     Future<void> sendVideoPushNotification(String userId, String message) async {
       final String onesignalAppId = 'your-onesignal-app-id'; // Replace with your OneSignal App ID
       final String onesignalRestApiKey = 'your-onesignal-rest-api-key'; // Replace with your OneSignal API key

       final url = Uri.parse('https://onesignal.com/api/v1/notifications');

       final headers = {
         'Content-Type': 'application/json',
         'Authorization': 'Basic $onesignalRestApiKey',
       };

       final body = json.encode({
         "app_id": onesignalAppId,
         "include_player_ids": [userId], // User's OneSignal Player ID
         "headings": {"en": "Hello"},
         "contents": {"en": message},
       });

       final response = await http.post(url, headers: headers, body: body);

       if (response.statusCode == 200) {
         print("Push notification sent successfully");
       } else {
         print("Failed to send notification: ${response.body}");
       }
     }


}