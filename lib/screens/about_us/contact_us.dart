import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/network_utils/model/ContactUs.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ContactUsScreen(),
      ),
    );
  }

}







class ContactUsScreen extends StatefulWidget {

  @override
  ContactUsState createState() => ContactUsState();

}





class ContactUsState extends State<ContactUsScreen> {


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

    initContactusApi();

  }


  ContactUs1? contact_us = null;
  initContactusApi() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context , listen: false).
    selectContactUs({
      "communityId": prefs.getString(SharedPrefs.communityId),
    });

    setState(() {
      contact_us =   ContactUs1.fromJson(_response.body) ;
    });


  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Contact Us' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

             contact_us == null ? Container() : HtmlWidget(
                contact_us!.data![0].details.toString(),
              ),
              SizedBox(height: 30.0),

            ],
          ),
        ),
      ),
    );

  }



  Widget _buildContactInfoTile({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.blue,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(value),
    );
  }





}