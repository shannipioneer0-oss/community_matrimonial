





import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/network_utils/model/AboutUs.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutUs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AboutUsScreen(),
      ),
    );
  }

}







class AboutUsScreen extends StatefulWidget {

  @override
  AboutUsState createState() => AboutUsState();

}





class AboutUsState extends State<AboutUsScreen> {

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

  AboutUs1? aboutus1 = null;
  initAboutusApi() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context , listen: false).
    selectAboutUs({
      "communityId": prefs.getString(SharedPrefs.communityId),
    });

    print(_response.body);

    setState(() {
      aboutus1 = AboutUs1.fromJson(_response.body);
    });


  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('About Us' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
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

                aboutus1 == null ? Container()  :   Text(
                  aboutus1!.data![0].description.toString(),
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