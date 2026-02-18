
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network_utils/service/api_service.dart';
import '../utils/SharedPrefs.dart';

class Userdata{


  initUserData(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _responseFreemembership = await ApiService.create().select_free_membership({
      "communityId": prefs.getString(SharedPrefs.communityId)
    });

    print(_responseFreemembership);
    
    if(_responseFreemembership.body["data"].toString() !=  "[]"){
      
      prefs.setString(SharedPrefs.free_membership_date, _responseFreemembership.body["data"][0]["free_date"]);
      prefs.setString(SharedPrefs.free_membership_duration, _responseFreemembership.body["data"][0]["duration"]);
      
    }

    final _response = await Provider.of<ApiService>(context , listen: false).
    postPremiumUserData({
      "userId":prefs.getString(SharedPrefs.userId).toString(),
      "communityId" : prefs.getString(SharedPrefs.communityId).toString()
    });

    print({
      "userId":prefs.getString(SharedPrefs.userId).toString(),
      "communityId" : prefs.getString(SharedPrefs.communityId).toString()
    });

    print(_response.body.toString()+"---======");



    if(_response.body.toString() != "null") {

      if (_response.body["data"][0].toString() != "[]") {
        await prefs.setString(SharedPrefs.validityDays,
            _response.body["data"][0][0]["validity_days"]);
        await prefs.setString(
            SharedPrefs.isExpired, _response.body["data"][0][0]["isexpired"]);
        await prefs.setString(
            SharedPrefs.planId,
            _response.body["data"][0][0]["planId"].toString());
        await prefs.setString(SharedPrefs.numExpressInterests,
            _response.body["data"][0][0]["num_express_interests"]);
        await prefs.setString(
            SharedPrefs.numPdf, _response.body["data"][0][0]["num_pdf"]);
        await prefs.setString(SharedPrefs.numberContacts,
            _response.body["data"][0][0]["number_contacts"]);
        await prefs.setString(SharedPrefs.numberHoroscope,
            _response.body["data"][0][0]["number_horoscope"]);
        await prefs.setString(SharedPrefs.numberVideo,
            _response.body["data"][0][0]["number_video"] ?? "0");
      } else {
        await prefs.setString(SharedPrefs.validityDays, "");
        await prefs.setString(SharedPrefs.isExpired, "");
        await prefs.setString(SharedPrefs.planId, "");
        await prefs.setString(SharedPrefs.numExpressInterests, "");
        await prefs.setString(SharedPrefs.numPdf, "");
        await prefs.setString(SharedPrefs.numberContacts, "");
        await prefs.setString(SharedPrefs.numberHoroscope, "");
        await prefs.setString(SharedPrefs.numberVideo, "");
      }

      if (_response.body["data"][1].toString() != "[]") {
        await prefs.setString(SharedPrefs.numContact,
            _response.body["data"][1][0]["num_contact"].toString());
        await prefs.setString(SharedPrefs.numHoroscope,
            _response.body["data"][1][0]["num_horoscope"].toString());
        await prefs.setString(SharedPrefs.numLikes,
            _response.body["data"][1][0]["num_likes"].toString());
        await prefs.setString(SharedPrefs.numVideo,
            _response.body["data"][1][0]["num_video"].toString());
        await prefs.setString(SharedPrefs.joined_days ,
            _response.body["data"][1][0]["joined_days"].toString());
      }

      if (_response.body["data"][2].toString() != "[]") {

        await prefs.setString(SharedPrefs.remainingDays,
            _response.body["data"][2][0]["remaining_days"].toString());

      }

      if (_response.body["data"][3].toString() != "[]") {
        await prefs.setString(SharedPrefs.reason_date,
            _response.body["data"][3][0]["start_date"].toString());
        await prefs.setString(SharedPrefs.reason,
            _response.body["data"][3][0]["reason"].toString());
      }

     /* if (_response.body["data"][4].toString() != "[]") {
        await prefs.setString(SharedPrefs.version,
            _response.body["data"][4][0]["apk_name"].toString());
      }
   */


    }

  }


}