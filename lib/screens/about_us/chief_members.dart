import 'dart:convert';

import 'package:community_matrimonial/network_utils/model/ChiefMembers.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_utils/Dialogs.dart';



class Member {
  final int id;
  final String name;
  final String position;
  final String image;
  final String description;
  final String communityId;

  Member({
    required this.id,
    required this.name,
    required this.position,
    required this.image,
    required this.description,
    required this.communityId,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    final int id = int.parse(json['Id']);
    final String name = json['name'];
    final String position = json['position'];
    final String image = json['image'];
    final String description = json['description'];
    final String communityId = json['communityId'];
    return Member(
      id: id,
      name: name,
      position: position,
      image: image,
      description: description,
      communityId: communityId,
    );
  }
}


class ChiefMembers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ChiefMembersScreen(),
      ),
    );
  }

}







class ChiefMembersScreen extends StatefulWidget {

  @override
  ChiefMembersState createState() => ChiefMembersState();

}





class ChiefMembersState extends State<ChiefMembersScreen> {

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

  ChiefMembers1? chiefmembers = null;
  late SharedPreferences prefs;
  initAboutusApi() async {

     prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context , listen: false).
    selectChiefMembers({
      "communityId": prefs.getString(SharedPrefs.communityId),
    });


    setState(() {
      chiefmembers = ChiefMembers1.fromJson(_response.body);
    });


  }


  RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Committee Members' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
            toolbarOpacity: 1,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
              onPressed: () {

                navService.goBack();

              },
            )),
        body: chiefmembers?.data?.length == 0 ? Container(child:Center(child:Text("No Data found" ,style: TextStyle(color: Colors.black54 ,fontSize: 18),)))   :ListView.builder(
          itemCount: chiefmembers == null ? 0 : chiefmembers?.data?.length,
          itemBuilder: (context, index) {

            return ListTile(
              leading: GestureDetector(onTap: (){

                _showImageDialog(context , Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+chiefmembers!.data![index].image.toString());

              } ,child:CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+chiefmembers!.data![index].image.toString()),
              ),),
              title: Text(chiefmembers!.data![index].name.toString() ,style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold),),
              subtitle: Text(chiefmembers!.data![index].description.toString().replaceAll(exp, "")),
              trailing:  Container(

                width: MediaQuery.of(context).size.width*0.25,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    chiefmembers!.data![index].position.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            );



          },
        ),
      ),
    );

  }


  void _showImageDialog(BuildContext context , String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.network(url , width: MediaQuery.of(context).size.width*0.7, height:MediaQuery.of(context).size.height*0.4 ,),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }



}
