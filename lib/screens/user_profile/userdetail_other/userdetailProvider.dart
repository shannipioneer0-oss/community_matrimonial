


import 'package:community_matrimonial/network_utils/model/AllowedUser.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../network_utils/service/api_service.dart';
import '../../../utils/SharedPrefs.dart';

class UserDetailProvider extends ChangeNotifier {

  AllowedUser _allowed_user  = AllowedUser();
  AllowedUser get allowed_user => _allowed_user;

  String _ispremium = "" , _allowed_contatcs = "" , _num_contacts = "";
  String get ispremium => _ispremium;
  String get allowed_contatcs => _allowed_contatcs;
  String get num_contacts => _num_contacts;

  Future<void> ViewOtherProfile(BuildContext context , String toid) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await Provider.of<ApiService>(context, listen: false).
    postViewotherProfile({
      "from_id": prefs.getString(SharedPrefs.userId).toString(),
      "memberId":toid,
      "communityId": prefs.getString(SharedPrefs.communityId)
    });

  }



  Future<void> allowedUserPhone(BuildContext context , String to_Id) async {



    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context, listen: false).
    postFetchAllowedFromUser({
      "from_id":prefs.getString(SharedPrefs.userId),
      "to_id": to_Id,
      "type":"phone",
      "communityId":prefs.getString(SharedPrefs.communityId)
    });

    print({
      "from_id":prefs.getString(SharedPrefs.userId),
      "to_id": to_Id,
      "type":"phone",
      "communityId":prefs.getString(SharedPrefs.communityId)
    });
    print(_response.body.toString()+"=========()()");


    _allowed_user = AllowedUser.fromJson(_response.body);

    _ispremium = prefs.getString(SharedPrefs.validityDays) ?? "";

    if(_ispremium != ""){
      _allowed_contatcs = prefs.getString(SharedPrefs.numberContacts) ?? "";
      _num_contacts  = prefs.getString(SharedPrefs.numContact) ?? "";
    }

    notifyListeners();
  }


  Future<void> ViewOtherContacts(BuildContext context , String toid) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await Provider.of<ApiService>(context, listen: false).
    postViewotherContact({
      "fromId": prefs.getString(SharedPrefs.userId),
      "memberId":toid,
      "communityId": prefs.getString(SharedPrefs.communityId)
    });

  }



  AllowedUser _allowed_user_horoscope  = AllowedUser();
  AllowedUser get allowed_user_horoscope => _allowed_user_horoscope;

  String _ispremium_horoscope = "" , _allowed_horoscope = "" , _num_horoscope = "";
  String get ispremium_horoscope => _ispremium_horoscope;
  String get allowed_horoscope => _allowed_horoscope;
  String get num_horoscope => _num_horoscope;



  Future<void> allowedUserHoroscope(BuildContext context , String to_Id) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context, listen: false).
    postFetchAllowedFromUser({
      "from_id":prefs.getString(SharedPrefs.userId),
      "to_id": to_Id,
      "type":"horoscope",
      "communityId":prefs.getString(SharedPrefs.communityId)
    });

    _allowed_user_horoscope = AllowedUser.fromJson(_response.body);

    _ispremium_horoscope = prefs.getString(SharedPrefs.validityDays) ?? "";

    if(_ispremium_horoscope != ""){
      _allowed_horoscope = prefs.getString(SharedPrefs.numberHoroscope) ?? "";
      _num_horoscope  = prefs.getString(SharedPrefs.numHoroscope) ?? "";
    }

    notifyListeners();
  }



  Future<void> ViewOtherHoroscope(BuildContext context , String toid) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await Provider.of<ApiService>(context, listen: false).
    postViewOtherHoroscope({
      "fromId": prefs.getString(SharedPrefs.userId),
      "memberId":toid,
      "communityId": prefs.getString(SharedPrefs.communityId)
    });

  }





}