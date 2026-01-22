import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class SendNotification{



  Future<bool> sendPushMessage(List<String> userToken , String title , String body , String from ,String to) async {

    String postUrl = "https://fcm.googleapis.com/fcm/send";
    final data = {
      "registration_ids" : userToken,
      "collapse_key" : "type_a",
      "notification" : {
        "title": title,
        "body" : body,
      },
      "data":{
        "from_id":from,
        "to_id":to,
        "type":"interest"
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


  Future<void> sendWhatsapp(String number ,String detail) async {

    await launchUrl(Uri.parse("https://wa.me/${number}?text="+detail));

  }


  String constructFCMPayload(String? token , String title , String body , String from , String to_id) {

    return jsonEncode({
      'token': token,
      'data': {
      'via':from,
      'count':to_id
      },
      'notification': {
        'title': title,
        'body': body,
      },
    });
  }




}