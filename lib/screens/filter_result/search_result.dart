import 'dart:convert';
import 'dart:math';
import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/SearchDataFilter.dart';
import 'package:community_matrimonial/app_utils/StylishDrawer.dart';
import 'package:community_matrimonial/network_utils/model/fetch_matches.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/filter_result/SearchResultList.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:huge_listview/huge_listview.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SearchResultApp extends StatelessWidget {

  final List maps;
  SearchResultApp({required this.maps});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  SearchResultAppStateful(maps),
      builder: EasyLoading.init(),
    );
  }
}


class SearchResultAppStateful extends StatefulWidget {

  final List maps;
  SearchResultAppStateful(this.maps);

  @override
  SearchResultScreen createState() => SearchResultScreen();

}


class SearchResultScreen extends State<SearchResultAppStateful> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const int PAGE_SIZE = 16;
  final scroll = ItemScrollController();
  HugeListViewController controller = HugeListViewController(totalItemCount: int.parse(Strings.limit));
  String total_count = "0";

  final Connectivity _connectivity = Connectivity();
  late Stream<ConnectivityResult> _connectionStream;
  bool isscroll = true;
  String gender = "";


  List<User> members = [];
  int currentPage = 1;
  double totalPages = 1;
  int perPage = 50;
  bool isLoading = false;

  ScrollController _scrollController = ScrollController();

  late  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();

    initprefs();

    //controller.totalItemCount = 0;

    _connectionStream = _connectivity.onConnectivityChanged as Stream<ConnectivityResult>;
    _connectionStream.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");
      }
    });

    controller.totalItemCount = PAGE_SIZE;
    total_count = "0";
    current_length = 0;


    _loadPage(context, 0, 16 , true);


    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {

          if(currentPage <= totalPages) {
            offset = offset + 16;
            _loadPage(context, 0, 16, false);
          }

      }
    });


  }

   initprefs() async {

    prefs = await SharedPreferences.getInstance();

   }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.totalItemCount = PAGE_SIZE;
    total_count = "0";
    current_length = 0;
  }



  int current_length = 16;
  int offset  =0;
   _loadPage(BuildContext context  ,int page, int pageSize , bool isInitial) async {




    if (isLoading) return;
    if (currentPage > totalPages)
      return;



    isLoading = true;

    if (isInitial) {
      currentPage = 1;
      members.clear();
      totalPages = 1;

      offset = 0;

    }else{



    }


    if(page == 0) {
      EasyLoading.show(status: 'Please wait...');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    print({
      "userId": widget.maps[0],
      "profileId":widget.maps[1],
      "gender": widget.maps[2],
      "name": widget.maps[3],
      "father_name":widget.maps[4],
      "age_from":widget.maps[5],
      "age_to":widget.maps[6],
      "height_from": widget.maps[7],
      "height_to": widget.maps[8],
      "mother_tongue": widget.maps[9],
      "marital_status": widget.maps[10],
      "profile_image": widget.maps[11],
      "location": widget.maps[12],
      "education_list": widget.maps[13],
      "occupation_list": widget.maps[14],
      "rashi": widget.maps[15],
      "birth_star":widget.maps[16],
      "income":widget.maps[17],
      "mangalik":widget.maps[18].toString(),
      "is_handicap":widget.maps[19],

      "Id":widget.maps[0],
      "communityId":prefs.getString(SharedPrefs.communityId),
      "original": "en",
      "translate": ["en"],
      "role": prefs.getString(SharedPrefs.role_type),
      "limit":int.parse(Strings.limit),
      "offset":page*pageSize
    });



      final _response = await ApiService.create().postAdvancedSearch({
        "userId": widget.maps[0],
        "profileId": widget.maps[1],
        "gender": widget.maps[2],
        "name": widget.maps[3],
        "father_name": widget.maps[4],
        "age_from": widget.maps[5],
        "age_to": widget.maps[6],
        "height_from": widget.maps[7],
        "height_to": widget.maps[8],
        "mother_tongue": widget.maps[9],
        "marital_status": widget.maps[10],
        "profile_image": widget.maps[11],
        "location": widget.maps[12],
        "education_list": widget.maps[13],
        "occupation_list": widget.maps[14],
        "rashi": widget.maps[15],
        "birth_star": widget.maps[16],
        "income": widget.maps[17],
        "mangalik": widget.maps[18].toString(),
        "is_handicap": widget.maps[19],
        "Id": widget.maps[0],
        "communityId": prefs.getString(SharedPrefs.communityId),
        "original": "en",
        "translate": ["en"],
        "role": prefs.getString(SharedPrefs.role_type),
        "limit": int.parse(Strings.limit),
        "offset": offset
      });


      print(_response.body.toString() + "=====90909090");

      //print("mangalik---"+_response.body.toString());


      ResponseData searchResult = ResponseData.fromJson(_response.body);

      print(searchResult.data[0][0].length.toString() + '[[[[[[[[[');


      //  print(searchResult.getUsers()[0].name+"++++++");

      setState(() {
        members = searchResult.getUsers();

        total_count = searchResult.getTotalRowCount()[0].totalRowCount.toString();

        //current_length = searchResult.data[0][0].length;
        // controller.totalItemCount = searchResult.getTotalRowCount()[0].totalRowCount;
        totalPages =   (searchResult.getTotalRowCount()[0].totalRowCount/ perPage).ceilToDouble() == 0.0 ? 1 : (searchResult.getTotalRowCount()[0].totalRowCount/ perPage).ceilToDouble();
      });

      currentPage++;




    EasyLoading.dismiss();


    print("qwerty");// clone to force update
    isLoading = false;





  }

  @override
  Widget build(BuildContext context) {

   // print(controller.totalItemCount.toString() +"()()()()"+ total_count.toString());

    return Scaffold(

    appBar: AppBar(
        title: Text('Search Results ('+total_count+") \nRavaldev Matrimony" , style: TextStyle(color: Colors.black87 , fontSize: 18),),
    toolbarOpacity: 1,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: IconButton(
    icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
    onPressed: () {
      navService.goBack();
    },
    )),
    drawer: StylishDrawer(),
    body: ListView.builder(itemCount: members.length ,controller: _scrollController  ,itemBuilder: (context, index) {


      return  SearchResultList(fetchmatches: members[index] , index:index , prefs: prefs,);

    },) /*HugeListView<User>(
      scrollController: scroll,
      listViewController: controller,
      pageSize: PAGE_SIZE,
      startIndex: 0,
      velocityThreshold: 10,
      firstShown: (item) => {


           print("first++++"),

        if( item >= controller.totalItemCount - 5 &&  controller.totalItemCount <= int.parse(total_count)){

          print(item.toString()+"()"+controller.totalItemCount.toString()+"()"+total_count+"()"+current_length.toString()),

         // if(int.parse(total_count)-controller.totalItemCount-int.parse(Strings.limit) > 0  ){
            controller.totalItemCount =
                controller.totalItemCount + int.parse(Strings.limit),

        *//*  }else{
               controller.totalItemCount = controller.totalItemCount + int.parse(total_count)-controller.totalItemCount,
            isscroll = false,

          },*//*



          _loadPage(context ,  (controller.totalItemCount / int.parse(Strings.limit)).toInt() - 1  , PAGE_SIZE),

        } },
      pageFuture: (page) {

        print(page.toString()+"-=-=-=");

        return _loadPage(context , page , PAGE_SIZE);

        },

      itemBuilder: (context, index, User entry) {
        return  SearchResultList(fetchmatches: entry, index:index);
      },
      errorBuilder: (context, error) {

        print(error);
        return Center(child: Text("No Data Available"),);
      },
      thumbBuilder: DraggableScrollbarThumbs.SemicircleThumb,
      placeholderBuilder: (context, index) => Container(),
      alwaysVisibleThumb: false,
      emptyBuilder: (context) {
        return Center(child: Text("No Data Available"),);
      },

    ),*/

    );

  }


}