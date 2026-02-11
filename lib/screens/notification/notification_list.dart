import 'dart:convert';
import 'dart:math';

import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/StylishDrawer.dart';
import 'package:community_matrimonial/network_utils/model/notification_model.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/filter_result/SearchResultList.dart';
import 'package:community_matrimonial/screens/notification/notification_item.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:huge_listview/huge_listview.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotificationStateful extends StatefulWidget {

  @override
  Notification createState() => Notification();

}



class Notification extends State<NotificationStateful> {

  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  static const int PAGE_SIZE = 8;
  final scroll = ItemScrollController();
  HugeListViewController controller = HugeListViewController(totalItemCount: 1);
  String total_count = "";


  List<NotificationItem> listNotificatiuons  =[];

   _loadPage(BuildContext context  ,int page, int pageSize) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context, listen: false).postFetchNotification({
      "userId": prefs.getString(SharedPrefs.userId),
      "communityId": prefs.getString(SharedPrefs.communityId),
      "original": "en",
      "translate": ["en"]
    });


    print(_response.body.toString());
    NotificationModel model = NotificationModel.fromJson(_response.body);

    //print(model.data[0][0]["0"]!.senderId.toString()+"____");

    setState(() {

      for(int i=0; i<model.data[0][0].length; i++){

        listNotificatiuons.add(model.data[0][0][i.toString()]!);
      }

    });



    //print(searchResult.data[0][2].notificationType.toString())
  }

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

    Future.delayed(const Duration(milliseconds: 100), () {

      _loadPage(context, 0, 8);

    });



  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(


        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Notifications' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
          toolbarOpacity: 1,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Image.asset("assets/images/ic_launcher.png" , width: 50, height: 40,),
            onPressed: () {

            },
          ),


        ),
        drawer: StylishDrawer(),
        body:Container(constraints: BoxConstraints(minHeight: double.infinity) ,

            child:  ListView.builder(
              itemCount: listNotificatiuons.length,
              itemBuilder: (context, index) {
                final NotificationItem item = listNotificatiuons[index];

                return NotificationStatefulItem(item: item, callbackFunction: (String ) {

                  listNotificatiuons.clear();
                  _loadPage(context, 0, 8);

                },);
              },
            ),

         )
        );


  }





}