






import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_utils/Dialogs.dart';

class PrivacyPolicy extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PrivacyPolicyScreen(),
      ),
    );
  }

}







class PrivacyPolicyScreen extends StatefulWidget {

  @override
  PrivacyPolicyState createState() => PrivacyPolicyState();

}





class PrivacyPolicyState extends State<PrivacyPolicyScreen> {


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

    initAboutusApi();

  }

  String details = "";
  initAboutusApi() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context , listen: false).
    postAboutCommunity({
      "type":"privacy_policy",   //about , contact , chief_members , privacy_policy , refund_policy , faqs
      "communityId": prefs.getString(SharedPrefs.communityId),
      "original": "en",
      "translate": ["en"]
    });

    setState(() {
      details = _response.body["data"][0][0]["0"]["description"];
    });


  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Privacy Policy' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
            toolbarOpacity: 1,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
              onPressed: () {

                navService.goBack();

              },
            )),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Text(
                  details,
                ),
                SizedBox(height: 30.0),

              ],
            ),
          ),
        ),
      ),
    );

  }




}