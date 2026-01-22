


import 'dart:io';
import 'dart:math';

import 'package:chopper/chopper.dart';
import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/StylishDrawer.dart';
import 'package:community_matrimonial/network_utils/model/fetch_matches_match.dart';
import 'package:community_matrimonial/screens/chat/models/message.dart';
import 'package:community_matrimonial/screens/inbox/inbox_row_data.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:huge_listview/huge_listview.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_switcher/slide_switcher.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../network_utils/service/api_service.dart';


class Inbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InboxStateful(),
      builder: EasyLoading.init(),
    );
  }
}


class InboxStateful extends StatefulWidget {

  @override
  InboxScreen createState() => InboxScreen();

}


class InboxScreen extends State<InboxStateful>{

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0 , page_selected = 0;
  String total_count  = "0";

  static const int PAGE_SIZE = 16;
  final scroll = ItemScrollController();

  HugeListViewController controller = HugeListViewController(totalItemCount: 8);
  HugeListViewController controller2 = HugeListViewController(totalItemCount: 8);


  Future<List<UserMatch>> _loadPage(BuildContext context  , int page , int pageSize , int selecteindex) async {

    print(page.toString()+"-----"+pageSize.toString()+"-----"+selecteindex.toString()+"----");

    SharedPreferences prefs = await SharedPreferences.getInstance();

    EasyLoading.show(status: 'Please wait...');
    late Response<dynamic> _response;

    if(selectedIndex == 0){

      _response = await Provider.of<ApiService>(context, listen: false).postInterestSentRecieved(
          {
            "userId":prefs.getString(SharedPrefs.userId),
            "type":"i",
            "Id":prefs.getString(SharedPrefs.userId),
            "gender":prefs.getString(SharedPrefs.gender),
            "communityId": prefs.getString(SharedPrefs.communityId),
            "original": "en",
            "translate": ["en"],
            "limit":Strings.limit,
            "offset":page*pageSize
          }

      );

    }else if(selectedIndex == 1){


      _response = await Provider.of<ApiService>(context, listen: false).postInterestSentRecieved(
          {
            "userId":prefs.getString(SharedPrefs.userId),
            "type":"other",
            "Id":prefs.getString(SharedPrefs.userId),
            "gender":prefs.getString(SharedPrefs.gender),
            "communityId": prefs.getString(SharedPrefs.communityId),
            "original": "en",
            "translate": ["en"],
            "limit":Strings.limit,
            "offset":page*pageSize
          }

      );



    }






    EasyLoading.dismiss();

    ResponseData searchResult = ResponseData.fromJson(_response.body);

    setState(() {

      controller.totalItemCount = searchResult.getTotalRowCount()[0].totalRowCount;

      if(searchResult.getTotalRowCount()[0].totalRowCount > 0) {
        total_count = searchResult.getTotalRowCount()[0].totalRowCount.toString();
      }else{
        total_count = "0";
      }



    });

    int from = page * pageSize;
    int to = min(searchResult.getTotalRowCount()[0].totalRowCount , from + pageSize);

    return searchResult.getUsers();
  }



  HugeListView setLists(int index){

    return HugeListView<UserMatch>(
      key: Key(index.toString()),
      scrollController: scroll,
      listViewController: controller,
      pageSize: PAGE_SIZE,
      startIndex: 0,
      firstShown: (item) => {


        print(item.toString()+"__________"+controller.totalItemCount.toString()),
        if( item >= controller.totalItemCount &&  controller.totalItemCount <= int.parse(total_count)){

          controller.totalItemCount = controller.totalItemCount + int.parse(Strings.limit) ,
          _loadPage(context,  (controller.totalItemCount / int.parse(Strings.limit)).toInt() - 1  , PAGE_SIZE, selectedIndex),

          print(item),

        }

      },
      velocityThreshold: 16,
      pageFuture: (page) =>  _loadPage(context,  page , PAGE_SIZE, selectedIndex),
      itemBuilder: (context, index, UserMatch entry) {

          return InboxRowData(entry , selectedIndex);

      },
      errorBuilder: (context, error) {
        return Center(child: Text("No Data Available"),);
      },
      thumbBuilder: DraggableScrollbarThumbs.SemicircleThumb,
      placeholderBuilder: (context, index) => Container(),
      alwaysVisibleThumb: false,
      emptyBuilder: (context) {
        return Center(child: Text("No Data Available"),);
      },

    );


  }

  HugeListView setLists2(int index){
    return HugeListView<UserMatch>(
      key: Key((index).toString()),
      scrollController: scroll,
      listViewController: controller2,
      pageSize: PAGE_SIZE,
      startIndex: 0,
      firstShown: (item) => {

        if( item >= controller2.totalItemCount &&  controller2.totalItemCount <= int.parse(total_count)){

        controller2.totalItemCount = controller2.totalItemCount + int.parse(Strings.limit) ,
        _loadPage(context,  (controller2.totalItemCount / int.parse(Strings.limit)).toInt() - 1  , PAGE_SIZE, selectedIndex),

        print(item),

      }

        },
      velocityThreshold: 8,
      pageFuture: (page) =>  _loadPage(context,  page , PAGE_SIZE, selectedIndex),
      itemBuilder: (context, index, UserMatch entry) {
        return InboxRowData(entry ,selectedIndex);
      },
      errorBuilder: (context, error) {
        return Center(child: Text("No Data Available"),);
      },
      thumbBuilder: DraggableScrollbarThumbs.SemicircleThumb,
      placeholderBuilder: (context, index) => Container(),
      alwaysVisibleThumb: false,
      emptyBuilder: (context) {
        return Center(child: Text("No Data Available"),);
      },

    );
  }


  final Connectivity _connectivity = Connectivity();
  late Stream<ConnectivityResult> _connectionStream;

  @override
  void initState() {
    super.initState();

    _checkConnectivity();

  }


  initOfflinemessages() async {

    Directory? externalDir = await getExternalStorageDirectory();

    if (externalDir != null) {
      // Create a custom directory within the external storage
      String customDirPath = '${externalDir.path}/Storage';

      print(customDirPath);
      Directory customDir = Directory(customDirPath);

      // Ensure the custom directory exists
      if (!customDir.existsSync()) {
        customDir.createSync(recursive: true);
      }

      Directory directory = Directory(customDirPath);
      await Hive.initFlutter(customDirPath);

    }

    bool isRegistered = Hive.isAdapterRegistered(0);

    if(isRegistered == false){
      Hive.registerAdapter<Message123>(MessageAdapter());
    }

    /// Open box
    await Hive.openBox<Message123>("messages");

  }


  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  Future<void> _checkConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = result;
    });
    if (_connectivityResult == ConnectivityResult.none) {
      DialogClass().showNoInternetAlert(context);
    }
  }




  @override
  Widget build(BuildContext context) {


    return WillPopScope(onWillPop: (){

      print("+_+_+");
      navService.pushNamed("/main_screen" , args:0);

      return Future.value(false);
    }, child:Scaffold(key: _scaffoldKey,

      appBar: AppBar(
          title: Text('Inbox' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
          toolbarOpacity: 1,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Image.asset("assets/images/menu_img.png" , width: 50, height: 40,),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          )),
      drawer: StylishDrawer(),
      body:Column(children: [

        Container(margin: EdgeInsets.only(top: 0 ,bottom: 0) , child:SlideSwitcher(

            children: [
              SizedBox(width: MediaQuery.of(context).size.width/2  ,child:Container( child: Text('Interest Sent' , textAlign: TextAlign.center, style: TextStyle(color: selectedIndex == 0 ? ColorsPallete.blue_2 : Colors.white , fontWeight: FontWeight.bold , fontSize: 16),),),),
              SizedBox(width: MediaQuery.of(context).size.width/2 ,child:Container( child: Text('Interest Recieved' , textAlign: TextAlign.center , style: TextStyle(color: selectedIndex == 1 ? ColorsPallete.blue_2 : Colors.white , fontWeight: FontWeight.bold , fontSize: 16)),),),
            ],
            containerBorderRadius: 2,
            indents: 12,
            containerColor: ColorsPallete.Pink,
            onSelect: (index) { setState(() {

              selectedIndex = index;

              _loadPage(context, 0 , 8 , selectedIndex);

            });},
            containerHeight: 50,
            containerWight: MediaQuery.of(context).size.width,
            direction: Axis.horizontal

        ),),

        Container(height:MediaQuery.of(context).size.height*0.65 ,margin: EdgeInsets.only(top: 15 ,bottom: 0 ) , child: selectedIndex == 0 ? setLists(123) :
        selectedIndex == 1 ? setLists2(345) : Container(),

        )

      ],)



    ));

  }




}