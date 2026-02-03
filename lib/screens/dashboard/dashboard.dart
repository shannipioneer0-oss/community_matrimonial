
import 'dart:math';
import 'package:chopper/chopper.dart';
import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/StylishDrawer.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/model/fetch_matches_match.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/dashboard/CustomTab.dart';
import 'package:community_matrimonial/screens/dashboard/DahsboardList.dart';
import 'package:community_matrimonial/screens/filter_result/SearchResultList.dart';
import 'package:community_matrimonial/screens/user_profile/userdetail_other/contact.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:huge_listview/huge_listview.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardAppStateful(),
      builder: EasyLoading.init(),
    );
  }
}


class DashboardAppStateful extends StatefulWidget {

  @override
  DashboardScreen createState() => DashboardScreen();

}


class DashboardScreen extends State<DashboardAppStateful> {

 static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Item> listTabs = [];
  int selectedIndex = 0;
  int page_selected = 0;
  int tot1 = 0 , tot2 =0 ,tot3 = 0, tot4 =0 ,tot5 =0 ,tot6 =0 ,tot7 = 0 ,tot8 = 0 ,tot9= 0 ,tot10 =0;

  static const int PAGE_SIZE = 32;
  final scroll = ItemScrollController();
  HugeListViewController controller = HugeListViewController(totalItemCount: int.parse(Strings.limit));

  final scroll2 = ItemScrollController();
  HugeListViewController controller2 = HugeListViewController(totalItemCount: int.parse(Strings.limit));

  HugeListViewController controller3 = HugeListViewController(totalItemCount: int.parse(Strings.limit));

 HugeListViewController controller4 = HugeListViewController(totalItemCount: int.parse(Strings.limit));
 HugeListViewController controller5 = HugeListViewController(totalItemCount: int.parse(Strings.limit));
 HugeListViewController controller6 = HugeListViewController(totalItemCount: int.parse(Strings.limit));
 HugeListViewController controller7 = HugeListViewController(totalItemCount: int.parse(Strings.limit));
 HugeListViewController controller8 = HugeListViewController(totalItemCount: int.parse(Strings.limit));
 HugeListViewController controller9 = HugeListViewController(totalItemCount: int.parse(Strings.limit));
 HugeListViewController controller10 = HugeListViewController(totalItemCount: int.parse(Strings.limit));


  String total_count = "0" , pic1 = "";
 late SharedPreferences prefs;



  @override
  void initState() {
    super.initState();

    initprefs();
    _checkConnectivity();

    setState(() {

      listTabs.add(Item(text: TranslationService.translate("matches"), count: ""));
      listTabs.add(Item(text: TranslationService.translate("new_joined"), count: ""));
     // listTabs.add(Item(text: TranslationService.translate("recently_viewed") , count: ""));
      listTabs.add(Item(text: TranslationService.translate("my_shortlists") , count: ""));
      listTabs.add(Item(text: TranslationService.translate("others_shortlist_me") , count: ""));
     // listTabs.add(Item(text: TranslationService.translate("nearby") , count: ""));
      listTabs.add(Item(text: TranslationService.translate("my_viewed_profiles") , count: ""));
      listTabs.add(Item(text: TranslationService.translate("other_viewed_my_profile") , count: ""));
      listTabs.add(Item(text: TranslationService.translate("view_other_contacts") , count: ""));
      listTabs.add(Item(text: TranslationService.translate("other_viewed_my_contacts") , count: ""));

    });



  }

  String communityname = "";

  initprefs() async {

    prefs = await SharedPreferences.getInstance();

    setState(() {
      communityname = prefs.getString(SharedPrefs.communityName).toString();

    });

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



  List<UserMatch> list = [];

  Future<List<UserMatch>> loadPage( int page , int pageSize , int selecteindex) async {

   // print(page.toString()+"-----"+pageSize.toString()+"-----"+selecteindex.toString()+"----"+page_selected.toString());



    if(page == 0) {
     // EasyLoading.show(status: 'Please wait...');
    }

    var _response;

    if(selectedIndex == 0) {

      if(prefs.getString(SharedPrefs.ageRange) == null || prefs.getString(SharedPrefs.heightRange) == null || prefs.getString(SharedPrefs.maritalStatus_prefs) == null){

        WidgetsBinding.instance.addPostFrameCallback((_) {
          DialogClass().showDialog2(context, "Matches Alert!",
              "Please Enter Atleast age range , height range , marital status from partner preference to get data in Matches Tab",
              "OK Understood");
        });

      }else {

        print(prefs.getString(SharedPrefs.annualIncome_prefs).toString()+"=====-----++++");

        print({
          "userId": prefs.getString(SharedPrefs.userId),
          "age_from": prefs.getString(SharedPrefs.ageRange)?.split(
              "-")[0] ?? "18",
          "age_to": prefs.getString(SharedPrefs.ageRange)?.split("-")[1] ??
              "70",
          "height_from": prefs.getString(SharedPrefs.heightRange)?.split(
              "-")[0] ?? "",
          "height_to": prefs.getString(SharedPrefs.heightRange)?.split(
              "-")[1] ?? "",
          "marital_status": prefs.getString(SharedPrefs.maritalStatus_prefs) != null &&  prefs.getString(SharedPrefs.maritalStatus_prefs) != "" ? prefs.getString(SharedPrefs.maritalStatus_prefs)!.split("*")[1] : "",
          "perm_state": prefs.getString(SharedPrefs.state_prefs) != "Any"
              ? prefs.getString(SharedPrefs.state_prefs) != "" ? prefs
              .getString(SharedPrefs.state_prefs)?.split("*")[1] ?? ""
              : "Any" : "",
          "perm_city": prefs.getString(SharedPrefs.city_prefs) != "Any"
              ? prefs.getString(SharedPrefs.city_prefs) != "" ? prefs
              .getString(SharedPrefs.city_prefs)?.split("*")[1] ?? ""
              : "Any" : "",
          "education_list": prefs.getString(SharedPrefs.education_prefs) !=
              "Any" ? prefs.getString(SharedPrefs.education_prefs) != ""
              ? prefs.getString(SharedPrefs.education_prefs)?.split(
              "*")[1] ?? ""
              : "Any" : "",
          "occupation_list": prefs.getString(
              SharedPrefs.occupation_prefs) !=
              "Any" ? prefs.getString(SharedPrefs.occupation_prefs) != ""
              ? prefs.getString(SharedPrefs.occupation_prefs)?.split(
              "*")[1] ?? ""
              : "Any" : "",
          "income_range": prefs.getString(SharedPrefs.annualIncome_prefs) !=
              "Any" ? prefs.getString(SharedPrefs.annualIncome_prefs) != ""
              ? prefs.getString(SharedPrefs.annualIncome_prefs) ?? ""
              : "Any" : "Any",
          "complexion": prefs.getString(SharedPrefs.skintoneprefs) != "Any"
              ? prefs.getString(SharedPrefs.skintoneprefs) != "" ? prefs
              .getString(SharedPrefs.skintoneprefs)?.split("*")[1] ?? ""
              : "Any" : "",
          "body_type": prefs.getString(SharedPrefs.bodyType_prefs) != "Any"
              ? prefs.getString(SharedPrefs.bodyType_prefs) != "" ? prefs
              .getString(SharedPrefs.bodyType_prefs)?.split("*")[1] ?? ""
              : "Any" : "",
          "diet_type": prefs.getString(SharedPrefs.dietType_prefs) != "Any"
              ? prefs.getString(SharedPrefs.dietType_prefs) != "" ? prefs
              .getString(SharedPrefs.dietType_prefs)?.split("*")[1] ?? ""
              : "Any" : "",
          "drink_type": prefs.getString(SharedPrefs.drinkType_prefs) !=
              "Any"
              ? prefs.getString(SharedPrefs.drinkType_prefs) != "" ? prefs
              .getString(SharedPrefs.drinkType_prefs)?.split("*")[1] ?? ""
              : "Any" : "",
          "smoke_type": prefs.getString(SharedPrefs.smokeType_prefs) !=
              "Any"
              ? prefs.getString(SharedPrefs.smokeType_prefs) != "" ? prefs
              .getString(SharedPrefs.smokeType_prefs)?.split("*")[1] ?? ""
              : "Any" : "",
          "age_filter": prefs.getString(SharedPrefs.ageRange_filter),
          "height_filter": prefs.getString(SharedPrefs.heightRange_filter),
          "marital_filter": prefs.getString(
              SharedPrefs.maritalStatus_prefs_filter),

          "state_filter": prefs.getString(SharedPrefs.state_prefs_filter),
          "city_filter": prefs.getString(SharedPrefs.city_prefs_filter),
          "edu_filter": prefs.getString(SharedPrefs.education_prefs_filter),
          "occup_filter": prefs.getString(
              SharedPrefs.occupation_prefs_filter),
          "income_filter": prefs.getString(
              SharedPrefs.annualIncome_prefs_filter),
          "complexion_filter": prefs.getString(
              SharedPrefs.skintoneprefs_filter),
          "body_type_filter": prefs.getString(
              SharedPrefs.bodyType_prefs_filter),
          "eat_type_filter": prefs.getString(
              SharedPrefs.dietType_prefs_filter),
          "drink_type_filter": prefs.getString(
              SharedPrefs.drinkType_prefs_filter),
          "smoke_type_filter": prefs.getString(
              SharedPrefs.smokeType_prefs_filter),
          "Id": prefs.getString(SharedPrefs.userId),
          "gender": prefs.getString(SharedPrefs.gender),
          "communityId": prefs.getString(SharedPrefs.communityId),
          "original": "en",
          "translate": [prefs.getString(SharedPrefs.translate)],
          "limit": int.parse(Strings.limit),
          "offset": page * pageSize
        });



        _response =
        await Provider.of<ApiService>(context, listen: false).postMatches(
            {
              "userId": prefs.getString(SharedPrefs.userId),
              "age_from": prefs.getString(SharedPrefs.ageRange)?.split(
                  "-")[0] ?? "18",
              "age_to": prefs.getString(SharedPrefs.ageRange)?.split("-")[1] ??
                  "70",
              "height_from": prefs.getString(SharedPrefs.heightRange)?.split(
                  "-")[0] ?? "",
              "height_to": prefs.getString(SharedPrefs.heightRange)?.split(
                  "-")[1] ?? "",
              "marital_status": prefs.getString(SharedPrefs.maritalStatus_prefs) != null && prefs.getString(SharedPrefs.maritalStatus_prefs) != "" ? prefs.getString(SharedPrefs.maritalStatus_prefs)!.split("*")[1] : "",
              "perm_state": prefs.getString(SharedPrefs.state_prefs) != "Any"
                  ? prefs.getString(SharedPrefs.state_prefs) != "" ? prefs
                  .getString(SharedPrefs.state_prefs)?.split("*")[1] ?? ""
                  : "Any" : "",
              "perm_city": prefs.getString(SharedPrefs.city_prefs) != "Any"
                  ? prefs.getString(SharedPrefs.city_prefs) != "" ? prefs
                  .getString(SharedPrefs.city_prefs)?.split("*")[1] ?? ""
                  : "Any" : "",
              "education_list": prefs.getString(SharedPrefs.education_prefs) !=
                  "Any" ? prefs.getString(SharedPrefs.education_prefs) != ""
                  ? prefs.getString(SharedPrefs.education_prefs)?.split(
                  "*")[1] ?? ""
                  : "Any" : "",
              "occupation_list": prefs.getString(
                  SharedPrefs.occupation_prefs) !=
                  "Any" ? prefs.getString(SharedPrefs.occupation_prefs) != ""
                  ? prefs.getString(SharedPrefs.occupation_prefs)?.split(
                  "*")[1] ?? ""
                  : "Any" : "",
              "income_range": prefs.getString(SharedPrefs.annualIncome_prefs) !=
                  "Any" ? prefs.getString(SharedPrefs.annualIncome_prefs) != ""
                  ? prefs.getString(SharedPrefs.annualIncome_prefs) ?? ""
                  : "Any" : "Any",
              "complexion": prefs.getString(SharedPrefs.skintoneprefs) != "Any"
                  ? prefs.getString(SharedPrefs.skintoneprefs) != "" ? prefs
                  .getString(SharedPrefs.skintoneprefs)?.split("*")[1] ?? ""
                  : "Any" : "",
              "body_type": prefs.getString(SharedPrefs.bodyType_prefs) != "Any"
                  ? prefs.getString(SharedPrefs.bodyType_prefs) != "" ? prefs
                  .getString(SharedPrefs.bodyType_prefs)?.split("*")[1] ?? ""
                  : "Any" : "",
              "diet_type": prefs.getString(SharedPrefs.dietType_prefs) != "Any"
                  ? prefs.getString(SharedPrefs.dietType_prefs) != "" ? prefs
                  .getString(SharedPrefs.dietType_prefs)?.split("*")[1] ?? ""
                  : "Any" : "",
              "drink_type": prefs.getString(SharedPrefs.drinkType_prefs) !=
                  "Any"
                  ? prefs.getString(SharedPrefs.drinkType_prefs) != "" ? prefs
                  .getString(SharedPrefs.drinkType_prefs)?.split("*")[1] ?? ""
                  : "Any" : "",
              "smoke_type": prefs.getString(SharedPrefs.smokeType_prefs) !=
                  "Any"
                  ? prefs.getString(SharedPrefs.smokeType_prefs) != "" ? prefs
                  .getString(SharedPrefs.smokeType_prefs)?.split("*")[1] ?? ""
                  : "Any" : "",
              "age_filter": prefs.getString(SharedPrefs.ageRange_filter),
              "height_filter": prefs.getString(SharedPrefs.heightRange_filter),
              "marital_filter": prefs.getString(
                  SharedPrefs.maritalStatus_prefs_filter),

              "state_filter": prefs.getString(SharedPrefs.state_prefs_filter),
              "city_filter": prefs.getString(SharedPrefs.city_prefs_filter),
              "edu_filter": prefs.getString(SharedPrefs.education_prefs_filter),
              "occup_filter": prefs.getString(
                  SharedPrefs.occupation_prefs_filter),
              "income_filter": prefs.getString(
                  SharedPrefs.annualIncome_prefs_filter),
              "complexion_filter": prefs.getString(
                  SharedPrefs.skintoneprefs_filter),
              "body_type_filter": prefs.getString(
                  SharedPrefs.bodyType_prefs_filter),
              "eat_type_filter": prefs.getString(
                  SharedPrefs.dietType_prefs_filter),
              "drink_type_filter": prefs.getString(
                  SharedPrefs.drinkType_prefs_filter),
              "smoke_type_filter": prefs.getString(
                  SharedPrefs.smokeType_prefs_filter),
              "Id": prefs.getString(SharedPrefs.userId),
              "gender": prefs.getString(SharedPrefs.gender),
              "communityId": prefs.getString(SharedPrefs.communityId),
              "original": "en",
              "translate": [prefs.getString(SharedPrefs.translate)],
              "role": prefs.getString(SharedPrefs.role_type),
              "limit": int.parse(Strings.limit),
              "offset": page * pageSize
            }
        );
      }


    }else if(selectedIndex == 1){

      DateTime currentDate = DateTime.now();

      _response =
      await Provider.of<ApiService>(context, listen: false).postMatchJustJoined({
        "userId":prefs.getString(SharedPrefs.userId),
        "today": '${currentDate.year}-${currentDate.month}-${currentDate.day}',
        "Id":prefs.getString(SharedPrefs.userId),
        "gender":prefs.getString(SharedPrefs.gender),
        "communityId":prefs.getString(SharedPrefs.communityId),
        "original": "en",
        "translate": ["en"],
        "limit":int.parse(Strings.limit),
        "offset": page*pageSize
      });



    }else if(selectedIndex == 2){

      _response =
      await Provider.of<ApiService>(context, listen: false).postShortlist({
        "userId":prefs.getString(SharedPrefs.userId),
        "type":"i" ,
        "gender":prefs.getString(SharedPrefs.gender),
        "communityId":prefs.getString(SharedPrefs.communityId),
        "Id":prefs.getString(SharedPrefs.userId),
        "original": "en",
        "translate": ["en"],
        "limit":int.parse(Strings.limit),
        "offset":page*pageSize
      });



    }else if(selectedIndex == 3){

      _response =
      await Provider.of<ApiService>(context, listen: false).postShortlist({
        "userId":prefs.getString(SharedPrefs.userId),
        "type":"other" ,
        "gender":prefs.getString(SharedPrefs.gender),
        "Id":prefs.getString(SharedPrefs.userId),
        "communityId":prefs.getString(SharedPrefs.communityId),
        "original": "en",
        "translate": ["en"],
        "limit":int.parse(Strings.limit),
        "offset":page*pageSize
      });

   //   print(_response.body.toString());


    }else if(selectedIndex == 100){

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      print(position.latitude.toString()+"{}"+position.longitude.toString());

      _response =
      await Provider.of<ApiService>(context, listen: false).postMatchNearby({
        "lat1":position.latitude.toString(),
        "lng1":position.longitude.toString(),
        "userId":prefs.getString(SharedPrefs.userId),
        "distance_limit":"45" ,
        "communityId":prefs.getString(SharedPrefs.communityId),
        "gender":prefs.getString(SharedPrefs.gender),
        "Id":prefs.getString(SharedPrefs.userId),
        "original": "en",
        "translate": ["en"],
        "limit":int.parse(Strings.limit),
        "offset": page*pageSize
      });

    }else if(selectedIndex == 4){

      _response = await Provider.of<ApiService>(context, listen: false).postViewProfile(
          {
            "userId":prefs.getString(SharedPrefs.userId),
            "type":"i",
            "Id":prefs.getString(SharedPrefs.userId),
            "gender":prefs.getString(SharedPrefs.gender),
            "communityId": prefs.getString(SharedPrefs.communityId),
            "original": "en",
            "translate": ["en"],
            "limit":int.parse(Strings.limit),
            "offset":page*pageSize
          }

      );
      
    }else if(selectedIndex == 5){


      _response = await Provider.of<ApiService>(context, listen: false).postViewProfile(
          {
            "userId":prefs.getString(SharedPrefs.userId),
            "type":"other",
            "Id":prefs.getString(SharedPrefs.userId),
            "gender":prefs.getString(SharedPrefs.gender),
            "communityId": prefs.getString(SharedPrefs.communityId),
            "original": "en",
            "translate": ["en"],
            "limit":int.parse(Strings.limit),
            "offset":page*pageSize
          }

      );



    }else if(selectedIndex == 6){


      print( {
        "userId":prefs.getString(SharedPrefs.userId),
        "type":"i",
        "Id":prefs.getString(SharedPrefs.userId),
        "gender":prefs.getString(SharedPrefs.gender),
        "communityId": prefs.getString(SharedPrefs.communityId),
        "original": "en",
        "translate": ["en"],
        "limit":int.parse(Strings.limit),
        "offset":page*pageSize
      });

      _response = await Provider.of<ApiService>(context, listen: false).postViewContact(
          {
            "userId":prefs.getString(SharedPrefs.userId),
            "type":"i",
            "Id":prefs.getString(SharedPrefs.userId),
            "gender":prefs.getString(SharedPrefs.gender),
            "communityId": prefs.getString(SharedPrefs.communityId),
            "original": "en",
            "translate": ["en"],
            "limit":int.parse(Strings.limit),
            "offset":page*pageSize
          }

      );


    }else if(selectedIndex == 7){

      _response = await Provider.of<ApiService>(context, listen: false).postViewContact(
          {
            "userId":prefs.getString(SharedPrefs.userId),
            "type":"other",
            "Id":prefs.getString(SharedPrefs.userId),
            "gender":prefs.getString(SharedPrefs.gender),
            "communityId": prefs.getString(SharedPrefs.communityId),
            "original": "en",
            "translate": ["en"],
            "limit":int.parse(Strings.limit),
            "offset":page*pageSize
          }
      );



    }




    EasyLoading.dismiss();

    if(_response != null) {
      if (_response.body != null) {
        ResponseData searchResult = ResponseData.fromJson(_response.body);

        setState(() {
          //controller.totalItemCount = searchResult.getTotalRowCount()[0].totalRowCount;

          if (searchResult.getTotalRowCount()[0].totalRowCount > 0) {
            total_count =
                searchResult.getTotalRowCount()[0].totalRowCount.toString();
          } else {
            total_count = "0";
          }


          if (selectedIndex == 0 && total_count == "0") {
            DialogClass().showDialog2(context, "Matches Alert!",
                "Please Update your Partner Preference and Partner Preference Filter as you are not getting data , by adjusting your partner preference data you will get your matches",
                "OK Understood");
          }


          if (selectedIndex == 0) {
            listTabs[0].count = total_count;
          }
          if (selectedIndex == 1) {
            setState(() {
              listTabs[1].count = total_count;
            });
          }
          if (selectedIndex == 2) {
            listTabs[2].count = total_count;
          }
          if (selectedIndex == 3) {
            listTabs[3].count = total_count;
          }
          if (selectedIndex == 4) {
            listTabs[4].count = total_count;
          }
          if (selectedIndex == 5) {
            listTabs[5].count = total_count;
          }
          if (selectedIndex == 6) {
            listTabs[6].count = total_count;
          }
          if (selectedIndex == 7) {
            listTabs[7].count = total_count;
          }
          if (selectedIndex == 8) {
            listTabs[8].count = total_count;
          }
        });

        int from = page * pageSize;
        int to = min(
            searchResult.getTotalRowCount()[0].totalRowCount, from + pageSize);

        return searchResult.getUsers();
      }
      else {
        if (selectedIndex == 0 && total_count == "0") {
          DialogClass().showDialog2(context, "Matches Alert!",
              "Please Update your Partner Preference and Partner Preference Filter as you are not getting data , by adjusting your partner preference data you will get your matches",
              "OK Understood");
        }

        ResponseData searchResult = ResponseData.fromJson(
            _response == null ? {} : _response.body);

        List<UserMatch> matches = [];

        return matches;
      }
    }else{

      if (selectedIndex == 0 && total_count == "0") {

        WidgetsBinding.instance.addPostFrameCallback((_) {
          DialogClass().showDialog2(context, "Matches Alert!",
              "Please Update your Partner Preference and Partner Preference Filter as you are not getting data , by adjusting your partner preference data you will get your matches",
              "OK Understood");
        });

      }

      List<UserMatch> matches = [];

      return matches;
    }


  }



   int type = 0;
   int index = 0;
   int selected = 0;



  HugeListView setLists(int index){



      return HugeListView<UserMatch>(
          key: Key(index.toString()),
          scrollController: scroll,
          listViewController: controller,
          pageSize: PAGE_SIZE,
          startIndex: 0,
          velocityThreshold: 10,
          firstShown: (item) => {


            if( item >= controller.totalItemCount - 12 &&  controller.totalItemCount <= int.parse(total_count)){

            controller.totalItemCount = controller.totalItemCount + int.parse(Strings.limit) ,
            loadPage(  (controller.totalItemCount / int.parse(Strings.limit)).toInt() - 1  , PAGE_SIZE, selectedIndex),

              print(item),

          } },
          pageFuture: (page) =>   loadPage(  page , PAGE_SIZE, selectedIndex),
          itemBuilder: (context , index , UserMatch entry) {
            if (type == 1) {
              return SearchResultListOther(fetchmatches: entry, prefs: prefs,);
            } else {
              return prefs == null ?  Container()  : DashboardList(user: entry, index: index, onUpdate: (int page) {

                setState(() {
                  //selected = page;
                });

                loadPage(  0  , PAGE_SIZE, selectedIndex);

              }, prefs: prefs,);
            }
          },


          thumbBuilder: DraggableScrollbarThumbs.SemicircleThumb,
          placeholderBuilder: (context, index) => Container(),
          alwaysVisibleThumb: false,
          emptyBuilder: (context) {

            print("empty");
            return Center(child: Text("No Data Available"),);
          },
        waitBuilder:(context) {
          return Center(child: Text("Please Wait"),);
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
        firstShown: (item) => {  if( item >= controller2.totalItemCount - 12 &&  controller2.totalItemCount <= int.parse(total_count)){

          controller2.totalItemCount = controller2.totalItemCount + int.parse(Strings.limit) ,

          loadPage( (controller2.totalItemCount / int.parse(Strings.limit)).toInt() - 1  , PAGE_SIZE, selectedIndex),

          print(item),

        }},
        velocityThreshold: 8,
        pageFuture: (page) =>  loadPage(  page , PAGE_SIZE, selectedIndex),
        itemBuilder: (context, index, UserMatch entry) {
          if (type == 1) {
            return SearchResultListOther(fetchmatches: entry, prefs: prefs,);
          } else {
            return DashboardList(user: entry, index: index, onUpdate: (int page) {

              loadPage( page  , PAGE_SIZE, selectedIndex);

            },prefs: prefs,);
          }
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

  HugeListView setLists3(int index){
    return HugeListView<UserMatch>(
      key: Key((index).toString()),
      scrollController: scroll,
      listViewController: controller3,
      pageSize: PAGE_SIZE,
      startIndex: 0,
      firstShown: (item) => {

        if( item >= controller3.totalItemCount - 12 &&  controller3.totalItemCount <= int.parse(total_count)){

        controller3.totalItemCount = controller3.totalItemCount + int.parse(Strings.limit) ,
        loadPage( (controller3.totalItemCount / int.parse(Strings.limit)).toInt() - 1  , PAGE_SIZE, selectedIndex),

        print(item),

      }

      },
      velocityThreshold: 8,
      pageFuture: (page) =>  loadPage(  page , PAGE_SIZE, selectedIndex),
      itemBuilder: (context, index, UserMatch entry) {
        if (type == 1) {
          return SearchResultListOther(fetchmatches: entry, prefs: prefs,);
        } else {
          return DashboardList(user: entry, index: index, onUpdate: (int page) {

            loadPage( page  , PAGE_SIZE, selectedIndex);

          }, prefs: prefs,);
        }
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

  HugeListView setLists4(int index){
    return HugeListView<UserMatch>(
      key: Key((index).toString()),
      scrollController: scroll,
      listViewController: controller4,
      pageSize: PAGE_SIZE,
      startIndex: 0,
      firstShown: (item) => {

        if( item >= controller4.totalItemCount - 12 &&  controller4.totalItemCount <= int.parse(total_count)){

        controller4.totalItemCount = controller4.totalItemCount + int.parse(Strings.limit) ,
        loadPage( (controller4.totalItemCount / int.parse(Strings.limit)).toInt() - 1  , PAGE_SIZE, selectedIndex),

        print(item),

      }

        },
      velocityThreshold: 8,
      pageFuture: (page) =>  loadPage(  page , PAGE_SIZE, selectedIndex),
      itemBuilder: (context, index, UserMatch entry) {
        if (type == 1) {
          return SearchResultListOther(fetchmatches: entry, prefs: prefs,);
        } else {
          return DashboardList(user: entry, index: index, onUpdate: (int page) {


            loadPage( page  , PAGE_SIZE, selectedIndex);
          }, prefs: prefs,);
        }
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

  HugeListView setLists5(int index){
    return HugeListView<UserMatch>(
      key: Key((index).toString()),
      scrollController: scroll,
      listViewController: controller5,
      pageSize: PAGE_SIZE,
      startIndex: 0,
      firstShown: (item) => {   if( item >= controller5.totalItemCount - 12 &&  controller5.totalItemCount <= int.parse(total_count)){

        controller5.totalItemCount = controller5.totalItemCount + int.parse(Strings.limit) ,
        loadPage( (controller5.totalItemCount / int.parse(Strings.limit)).toInt() - 1  , PAGE_SIZE, selectedIndex),

        print(item),

      }   },
      velocityThreshold: 8,
      pageFuture: (page) =>  loadPage(  page , PAGE_SIZE, selectedIndex),
      itemBuilder: (context, index, UserMatch entry) {
        if (type == 1) {
          return SearchResultListOther(fetchmatches: entry, prefs: prefs,);
        } else {
          return DashboardList(user: entry, index: index, onUpdate: (int page) {

            loadPage(page  , PAGE_SIZE, selectedIndex);

          }, prefs: prefs,);
        }
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

  HugeListView setLists6(int index){
    return HugeListView<UserMatch>(
      key: Key((index).toString()),
      scrollController: scroll,
      listViewController: controller6,
      pageSize: PAGE_SIZE,
      startIndex: 0,
      firstShown: (item) => {

        if( item >= controller6.totalItemCount - 12 &&  controller6.totalItemCount <= int.parse(total_count)){

        controller6.totalItemCount = controller6.totalItemCount + int.parse(Strings.limit) ,
        loadPage(  (controller6.totalItemCount / int.parse(Strings.limit)).toInt() - 1  , PAGE_SIZE, selectedIndex),

        print(item),

      }

        },
      velocityThreshold: 8,
      pageFuture: (page) =>  loadPage(  page , PAGE_SIZE, selectedIndex),
      itemBuilder: (context, index, UserMatch entry) {
        if (type == 1) {
          return SearchResultListOther(fetchmatches: entry, prefs: prefs,);
        } else {
          return DashboardList(user: entry, index: index, onUpdate: (int page) {

            loadPage( page  , PAGE_SIZE, selectedIndex);

          }, prefs: prefs,);
        }
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

  HugeListView setLists7(int index){
    return HugeListView<UserMatch>(
      key: Key((index).toString()),
      scrollController: scroll,
      listViewController: controller7,
      pageSize: PAGE_SIZE,
      startIndex: 0,
      firstShown: (item) => {

        if( item >= controller7.totalItemCount - 12 &&  controller7.totalItemCount <= int.parse(total_count)){

        controller7.totalItemCount = controller7.totalItemCount + int.parse(Strings.limit) ,
        loadPage( (controller7.totalItemCount / int.parse(Strings.limit)).toInt() - 1  , PAGE_SIZE, selectedIndex),

        print(item),

      }   },
      velocityThreshold: 16,
      pageFuture: (page) =>  loadPage(  page , PAGE_SIZE, selectedIndex),
      itemBuilder: (context, index, UserMatch entry) {
        if (type == 1) {
          return SearchResultListOther(fetchmatches: entry, prefs: prefs,);
        } else {
          return DashboardList(user: entry, index: index, onUpdate: (int page) {

            loadPage( page  , PAGE_SIZE, selectedIndex);
          }, prefs: prefs,);
        }
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

  HugeListView setLists8(int index){
    return HugeListView<UserMatch>(
      key: Key((index).toString()),
      scrollController: scroll,
      listViewController: controller8,
      pageSize: PAGE_SIZE,
      startIndex: 0,
      firstShown: (item) => {

        if( item >= controller8.totalItemCount - 12 &&  controller8.totalItemCount <= int.parse(total_count)){

          controller8.totalItemCount = controller8.totalItemCount + int.parse(Strings.limit) ,
          loadPage( (controller8.totalItemCount / int.parse(Strings.limit)).toInt() - 1  , PAGE_SIZE, selectedIndex),

          print(item),

        }


      },
      velocityThreshold: 16,
      pageFuture: (page) =>  loadPage(  page , PAGE_SIZE, selectedIndex),
      itemBuilder: (context, index, UserMatch entry) {
        if (type == 1) {
          return SearchResultListOther(fetchmatches: entry, prefs: prefs,);
        } else {
          return DashboardList(user: entry, index: index, onUpdate: (int page) {

            loadPage( page  , PAGE_SIZE, selectedIndex);

          }, prefs: prefs,);
        }
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

  HugeListView setLists9(int index){
    return HugeListView<UserMatch>(
      key: Key((index).toString()),
      scrollController: scroll,
      listViewController: controller9,
      pageSize: PAGE_SIZE,
      startIndex: 0,
      firstShown: (item) => {

        if( item >= controller9.totalItemCount - 12 &&  controller9.totalItemCount <= int.parse(total_count)){

          controller9.totalItemCount = controller9.totalItemCount + int.parse(Strings.limit) ,
          loadPage(  (controller9.totalItemCount / int.parse(Strings.limit)).toInt() - 1  , PAGE_SIZE, selectedIndex),

          print(item),

        }

      },
      velocityThreshold: 16,
      pageFuture: (page) =>  loadPage(  page , PAGE_SIZE, selectedIndex),
      itemBuilder: (context, index, UserMatch entry) {
        if (type == 1) {
          return SearchResultListOther(fetchmatches: entry, prefs: prefs,);
        } else {
          return DashboardList(user: entry, index: index, onUpdate: (int page) {

            loadPage( page  , PAGE_SIZE, selectedIndex);

          }, prefs: prefs,);
        }
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

  HugeListView setLists10(int index){
    return HugeListView<UserMatch>(
      key: Key((index).toString()),
      scrollController: scroll,
      listViewController: controller10,
      pageSize: PAGE_SIZE,
      startIndex: 0,
      firstShown: (item) => {

        if( item >= controller10.totalItemCount - 12 &&  controller10.totalItemCount <= int.parse(total_count)){

          controller10.totalItemCount = controller10.totalItemCount + int.parse(Strings.limit) ,
          loadPage( (controller10.totalItemCount / int.parse(Strings.limit)).toInt() - 1  , PAGE_SIZE, selectedIndex),

          print(item),

        }

      },
      velocityThreshold: 16,
      pageFuture: (page) =>  loadPage(  page , PAGE_SIZE, selectedIndex),
      itemBuilder: (context, index, UserMatch entry) {
        if (type == 1) {
          return SearchResultListOther(fetchmatches: entry, prefs: prefs,);
        } else {
          return DashboardList(user: entry, index: index, onUpdate: (int page) {

            loadPage( page  , PAGE_SIZE, selectedIndex);

          }, prefs: prefs,);
        }
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


  @override
  void dispose() {

    print('Disposing of ${this.runtimeType}');

    super.dispose();



  }

 final ScrollController _scrollController = ScrollController();

 void scrollToIndex(int index) {
     double position = index >= 7  ? index * 170.0 : index * 150; // Assuming each item has a fixed height of 50
    _scrollController.animateTo(
     position,
     duration: Duration(milliseconds: 500),
     curve: Curves.easeInOut,
   );
 }



  @override
  Widget build(BuildContext context) {



    return Scaffold(

      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(communityname , style: TextStyle(color: Colors.black87 , fontSize: 18),),
        toolbarOpacity: 1,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Image.asset("assets/images/menu_img.png" , width: 50, height: 40,),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [

          Container(child: Center(child: IconButton(onPressed: () {

            setState(() {
                 if(type == 0){
                   type = 1;
                 }else{
                   type  = 0;
                 }
            });

          }, icon: type == 0 ?  Image.asset("assets/images/smalllist.png" , color: ColorsPallete.blue_2,) : Image.asset("assets/images/biglist.png" , color: ColorsPallete.blue_2) ,)),)

        ],

      ),
      drawer: StylishDrawer(),
      body:Container(constraints: BoxConstraints(minHeight: double.infinity)  ,margin: EdgeInsets.only(top: 70)  ,child:Column( children: [

        Container(
          height: 50,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.only(left: 10 ),
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: listTabs.length,
            itemBuilder: (context, index) {
              return GestureDetector( onTap: (){

                setState(() {
                  selectedIndex = index;
                  //page_selected = 0;

                  print(selectedIndex.toString()+"======");

                  //controller.value.doReload;

                });

                loadPage( 0 , 8 , selectedIndex);

              } ,child:MyCard(text: listTabs[index].text, isSelected: selectedIndex == index, counts: selectedIndex == index ?  listTabs[selectedIndex].count : listTabs[index].count ,));
            },
          ),
        ),

          GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dx > 0) {
                setState(() {

                  if(selectedIndex == 0){
                    selectedIndex = 0;
                  }else{
                    selectedIndex--;
                  }


                  scrollToIndex(selectedIndex);

                });
              } else if (details.velocity.pixelsPerSecond.dx < 0) {
                setState(() {

                  if(selectedIndex == 9){
                    selectedIndex = 9;
                  }else{
                    selectedIndex++;
                  }

                  scrollToIndex(selectedIndex);

                });
              }
            },
            child:Container(height:MediaQuery.of(context).size.height*0.68 ,margin: EdgeInsets.only(top: 15 , left: type == 1 ? 3 : 20 ) , child: selectedIndex == 0 ? setLists(123) :
       selectedIndex == 1 ? setLists2(345) : selectedIndex == 2 ? setLists3(456) : selectedIndex == 3 ? setLists4(567) : selectedIndex == 100 ? setLists5(678) : selectedIndex == 4 ?
       setLists5(789) : selectedIndex == 6 ? setLists6(890) : selectedIndex == 7 ? setLists7(900) : selectedIndex == 8 ? setLists8(901)
         :selectedIndex == 9 ? setLists9(902) : Container(),

       ))],  )
    ));

  }



}



class Item {

  String text;
  String count;

  Item({required this.text , required this.count});

}