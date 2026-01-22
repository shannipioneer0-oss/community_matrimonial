




import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/Userdata.dart';
import 'package:community_matrimonial/network_utils/model/savedSearch.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SavedSearch extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SavedSearchScreen(),
      ),
    );
  }

}

class SavedSearchScreen extends StatefulWidget{

  @override
  SavedSearchState createState() => SavedSearchState();

}


class SavedSearchState extends State<SavedSearchScreen> {


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

    Future.delayed(Duration(milliseconds: 100), ()
    {
      initUserData(context);
    });

  }

  String validity_days = "0" ,num_interest = "0" , number_contacts = "0" , number_horoscope = "0" ,number_video = "0" , isexpired = "0" ;
  String num_interest_used = "0" , num_contacts_used = "0" ,num_horoscope_used = "0" , number_video_used = "0"  ,joined_days = "0" , remaining_days = "0";

  List<Data>? list_saved_search = [];

  initUserData(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context , listen: false).
    postSelectSavedSearch({
      "userId":prefs.getString(SharedPrefs.userId),
      "communityId": prefs.getString(SharedPrefs.communityId)
    });

    savedSearch savedsearch_list = savedSearch.fromJson(_response.body);

    setState(() {
      list_saved_search =  savedsearch_list.data!.where((element) => element.searchType == "mobile").toList();
    });




  }





  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
          title: Text('Saved Search' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
          toolbarOpacity: 1,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
            onPressed: () {

              navService.goBack();

            },
          )),
      body: list_saved_search!.length > 0 ? ListView.builder(
        itemCount: list_saved_search!.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(list_saved_search![index].searchName.toString()),
              subtitle: Text('SearchType : '+list_saved_search![index].searchType.toString() , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15 , color: Colors.pink),),
              trailing: IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("savedSearch" , list_saved_search![index].searchParams.toString());

                  navService.pushNamed("/main_screen" , args:3);

                },
              ),
            ),
          );
        },
      ) :  Center(child: Text("No Saved Search Found"),),
    );

  }







}
