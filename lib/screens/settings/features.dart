



import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/Userdata.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Features extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FeaturesScreen(),
      ),
    );
  }

}

class FeaturesScreen extends StatefulWidget{

  @override
  FeaturesState createState() => FeaturesState();

}


class FeaturesState extends State<FeaturesScreen> {


  final Connectivity _connectivity = Connectivity();
  late Stream<ConnectivityResult> _connectionStream;

  @override
  void initState() {
    super.initState();

    _connectionStream = _connectivity.onConnectivityChanged as Stream<ConnectivityResult>;
    _connectionStream.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");
      }
    });

    Future.delayed(Duration(milliseconds: 100), () {
      initUserData(context);
    });

  }

  String validity_days = "0" ,num_interest = "0" , number_contacts = "0" , number_horoscope = "0" ,number_video = "0" , isexpired = "0" ;
  String num_interest_used = "0" , num_contacts_used = "0" ,num_horoscope_used = "0" , number_video_used = "0"  ,joined_days = "0" , remaining_days = "0";

  initUserData(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context , listen: false).
    postPremiumUserData({
      "userId":prefs.getString(SharedPrefs.userId),
      "communityId" : prefs.getString(SharedPrefs.communityId)
    });

    print(_response.body);


    setState(() {

      if(_response.body["data"][0].toString() != "[]") {

        validity_days = _response.body["data"][0][0]["validity_days"];
        isexpired =  _response.body["data"][0][0]["isexpired"];
        num_interest =  _response.body["data"][0][0]["num_express_interests"];
        number_contacts = _response.body["data"][0][0]["number_contacts"];
        number_horoscope = _response.body["data"][0][0]["number_horoscope"];
        number_video =  _response.body["data"][0][0]["number_video"];

      }else{

        validity_days = "0";
        isexpired =  "0";
        num_interest =  "0";
        number_contacts = "0";
        number_horoscope = "0";

      }

      if(_response.body["data"][1].toString() != "[]") {

        num_contacts_used= _response.body["data"][1][0]["num_contact"].toString();
        num_horoscope_used =   _response.body["data"][1][0]["num_horoscope"].toString();
        num_interest_used =  _response.body["data"][1][0]["num_likes"].toString();
        number_video_used = _response.body["data"][1][0]["num_video"].toString();
        joined_days    = _response.body["data"][1][0]["joined_days"].toString();

      }else{

        num_contacts_used= "0";
        num_horoscope_used =  "0";
        num_interest_used =  "0";
        number_video_used = "0";
        joined_days    = "0";

      }

      if(_response.body["data"][2].toString() != "[]") {
        remaining_days =  _response.body["data"][2][0]["remaining_days"].toString();
      }else{
        remaining_days = "0";
      }

    });




  }





  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
          title: Text('Features of your Membership' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
          toolbarOpacity: 1,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
            onPressed: () {

              navService.goBack();

            },
          )),
      body: number_contacts != "0" ? ListView(
        children: [
          _buildListItem("Validity Days", validity_days),
          _buildListItem("Remaining Days", remaining_days),
          _buildListItem(  "Contacts Allowed : "+number_contacts ,  "Contacts Used : "+num_contacts_used),
          _buildListItem("Interest Expressing Allowed : "+num_interest, "Interest Accessed : "+num_interest_used),
          _buildListItem("Horoscope Access Allowed : "+number_horoscope, "Horoscope Accessed : "+num_horoscope_used),

        ],
      ) :  Center(child: Text("Still Premium Plan not Subscribed"),),
    );

  }


  Widget _buildListItem(String title, String subtitle) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.pink,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }




}
