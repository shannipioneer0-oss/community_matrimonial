






import 'dart:convert';

import 'package:community_matrimonial/app_utils/ButtonTextImage.dart';
import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/SearchDataFilter.dart';
import 'package:community_matrimonial/app_utils/SingleSelectDialog.dart';
import 'package:community_matrimonial/app_utils/StylishDrawer.dart';
import 'package:community_matrimonial/app_utils/Values.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/model/DataFetch.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/filter/CircleWithNumber.dart';
import 'package:community_matrimonial/screens/filter/StylishCheckbox.dart';
import 'package:community_matrimonial/screens/filter/dropdown.dart';
import 'package:community_matrimonial/screens/user_profile/CustomDropdown.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/data.dart';
import 'package:community_matrimonial/utils/lists.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterScreenApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SearchDataFilter()),
        ],
        child: FilterScreenAppStateful(),
      ),
      builder: EasyLoading.init(),
    );
  }
}




class FilterScreenAppStateful extends StatefulWidget {

  @override
  FilterScreen createState() => FilterScreen();

}


class FilterScreen extends State<FilterScreenAppStateful> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int isload = 0;
  List<Widget> parts = [];

  Future<void> setUI() async {
    // Simulate a delay of 2 seconds
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      parts.add(part1Stateful());
    });


    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      parts.add(part2stateful());
    });

    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      parts.add(part3stateful());
    });

  }





  final Connectivity _connectivity = Connectivity();
  late Stream<ConnectivityResult> _connectionStream;
  String gender = "";

  @override
  void initState() {
    super.initState();

    _checkConnectivity();

    context.read<SearchDataFilter>().age_from = "18";
    context.read<SearchDataFilter>().age_to = "70";

    context.read<SearchDataFilter>().height_from = "4ft 0inch";
    context.read<SearchDataFilter>().height_to = "7ft 5inch";



    setUI();
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


    showalertdailogForSaving(BuildContext context1) {

    TextEditingController controller = TextEditingController();

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Your Search Title'),
              content: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Enter your Search Title',
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {

                    Navigator.of(context).pop();

                    SharedPreferences prefs = await SharedPreferences.getInstance();

                    context1
                        .read<SearchDataFilter>()
                        .profileId = context1
                        .read<SearchDataFilter>()
                        .profileidController
                        .text
                        .toString()
                        .length == 0 ? "0" : context1
                        .read<SearchDataFilter>()
                        .profileidController
                        .text
                        .toString();
                    context1
                        .read<SearchDataFilter>()
                        .search_name = context1
                        .read<SearchDataFilter>()
                        .search_name_controller
                        .text
                        .toString()
                        .length == 0 ? "0" : context1
                        .read<SearchDataFilter>()
                        .search_name_controller
                        .text
                        .toString();
                    context1
                        .read<SearchDataFilter>()
                        .search_fathername = context1
                        .read<SearchDataFilter>()
                        .search_fathername_controller
                        .text
                        .toString()
                        .length == 0 ? "0" : context1
                        .read<SearchDataFilter>()
                        .search_fathername_controller
                        .text
                        .toString();
                    context1
                        .read<SearchDataFilter>()
                        .location = context1
                        .read<SearchDataFilter>()
                        .search_location_controller
                        .text
                        .toString()
                        .length == 0 ? "0" : context1
                        .read<SearchDataFilter>()
                        .search_location_controller
                        .text
                        .toString();

                    context1
                        .read<SearchDataFilter>()
                        .income = context1
                        .read<SearchDataFilter>()
                        .Income_controller
                        .text
                        .toString()
                        .length == 0 ? "0" : context1
                        .read<SearchDataFilter>()
                        .Income_controller
                        .text
                        .toString();


                    print(context1
                        .read<SearchDataFilter>()
                        .mangalik+"=================="+ context1
                        .read<SearchDataFilter>()
                        .marital_status);

                    navService.pushNamed("/search_result", args: [
                      prefs.getString(SharedPrefs.userId),
                      context1
                          .read<SearchDataFilter>()
                          .profileId,
                      context1
                          .read<SearchDataFilter>()
                          .gender,
                      context1
                          .read<SearchDataFilter>()
                          .search_name,
                      context1
                          .read<SearchDataFilter>()
                          .search_fathername,
                      context1
                          .read<SearchDataFilter>()
                          .age_from,
                      context1
                          .read<SearchDataFilter>()
                          .age_to,
                      context1
                          .read<SearchDataFilter>()
                          .height_from,
                      context1
                          .read<SearchDataFilter>()
                          .height_to,
                      context1
                          .read<SearchDataFilter>()
                          .mother_tongue,
                      context1
                          .read<SearchDataFilter>()
                          .marital_status,
                      context1
                          .read<SearchDataFilter>()
                          .location,
                      context1
                          .read<SearchDataFilter>()
                          .education,
                      context1
                          .read<SearchDataFilter>()
                          .occupation,
                      context1
                          .read<SearchDataFilter>()
                          .rashi,
                      context1
                          .read<SearchDataFilter>()
                          .birth_star,
                      context1
                          .read<SearchDataFilter>()
                          .income,
                      context1
                          .read<SearchDataFilter>()
                          .mangalik,
                      context1
                          .read<SearchDataFilter>()
                          .handicap,
                      context1
                          .read<SearchDataFilter>()
                          .institute_wise,
                    ]);






                     await Provider.of<ApiService>(context, listen: false).postSaveSearch({
                      "search_name":controller.text.toString(),
                      "search_type":"mobile",
                      "search_params": jsonEncode({
                        "profile_id":context1.read<SearchDataFilter>().profileidController.text,
                        "gender":context1.read<SearchDataFilter>().gender,
                        "name":context1.read<SearchDataFilter>().search_name,
                        "fathername":context1.read<SearchDataFilter>().search_fathername,
                        "age_from":context1.read<SearchDataFilter>().age_from,
                        "age_to":context1.read<SearchDataFilter>().age_to,
                        "height_from": context1.read<SearchDataFilter>().height_from,
                        "height_to":context1.read<SearchDataFilter>().height_to,
                        "marital_status": context1.read<SearchDataFilter>().maritalController.text+","+context1.read<SearchDataFilter>().marital_status,
                        "mother_tongue":context1.read<SearchDataFilter>().mothertongueController.text+","+context1.read<SearchDataFilter>().mother_tongue,
                        "location": context1.read<SearchDataFilter>().search_location_controller.text,
                        "education":context1.read<SearchDataFilter>().highesteducationController.text+","+context1.read<SearchDataFilter>().education,
                        "occupation":context1.read<SearchDataFilter>().occupationController.text+","+context1.read<SearchDataFilter>().occupation,
                        "rashi":context1.read<SearchDataFilter>().rashiController.text+","+context1.read<SearchDataFilter>().rashi,
                        "birth_star":context1.read<SearchDataFilter>().birthstarController.text+","+context1.read<SearchDataFilter>().birth_star,
                        "income": context1.read<SearchDataFilter>().Income_controller.text,
                        "mangalik":context1.read<SearchDataFilter>().mangalik,
                        "handicap":context1.read<SearchDataFilter>().handicap,
                        "institute":context1.read<SearchDataFilter>().raputedController.text+","+context1.read<SearchDataFilter>().institute_wise
                      }),
                      "userId":prefs.getString(SharedPrefs.userId),
                      "communityId":prefs.getString(SharedPrefs.communityId)
                    });






                  },
                  child: Text('Save & Search'),
                ),
              ],
            );
          }
      );
    }

     @override
  void dispose() {
    super.dispose();

    destroy();

  }

  destroy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("savedSearch", "");
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),child: AppBar(
        title: Text('Search\nRavaldev Matrimony' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
        toolbarOpacity: 1,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Image.asset("assets/images/menu_img.png" , width: 50, height: 40,),
          onPressed: () {

            _scaffoldKey.currentState!.openDrawer();

          },
        ),
        actions: [


    Container(height: 30  ,child:ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, // Background color
    foregroundColor: Colors.white,
    // Text color
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    ),
    padding: EdgeInsets.all(5),
    elevation: 5.0,)  ,icon: Icon(Icons.close), label: Text("Reset"), onPressed: () async {

      context.read<SearchDataFilter>().clearAllFields();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      gender = prefs.getString(SharedPrefs.gender).toString().toLowerCase();
      String role = prefs.getString(SharedPrefs.role_type).toString();


      setState(() {

        if(role == "admin") {
          context
              .read<SearchDataFilter>()
              .gender = "All";

          gender = "All";
        }else{

          if(gender == "male")
          {
            context.read<SearchDataFilter>().gender = "Female";
            gender = "Female";
          }else{
            context.read<SearchDataFilter>().gender = "Male";
            gender = "Male";
          }
        }
      });


    })),

          SizedBox(width: 10,),
          Container(height: 30  ,child:ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, // Background color
            foregroundColor: Colors.white,
            // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(5),
            elevation: 5.0,)  ,icon: Icon(Icons.search), label: Text("Search"), onPressed: () async {


            SharedPreferences prefs = await SharedPreferences.getInstance();

            if(prefs.getBool("is_save") == false) {

              context
                  .read<SearchDataFilter>()
                  .profileId = context
                  .read<SearchDataFilter>()
                  .profileidController
                  .text
                  .toString()
                  .length == 0 ? "0" : context
                  .read<SearchDataFilter>()
                  .profileidController
                  .text
                  .toString();
              context
                  .read<SearchDataFilter>()
                  .search_name = context
                  .read<SearchDataFilter>()
                  .search_name_controller
                  .text
                  .toString()
                  .length == 0 ? "0" : context
                  .read<SearchDataFilter>()
                  .search_name_controller
                  .text
                  .toString();
              context
                  .read<SearchDataFilter>()
                  .search_fathername = context
                  .read<SearchDataFilter>()
                  .search_fathername_controller
                  .text
                  .toString()
                  .length == 0 ? "0" : context
                  .read<SearchDataFilter>()
                  .search_fathername_controller
                  .text
                  .toString();
              context
                  .read<SearchDataFilter>()
                  .location = context
                  .read<SearchDataFilter>()
                  .search_location_controller
                  .text
                  .toString()
                  .length == 0 ? "0" : context
                  .read<SearchDataFilter>()
                  .search_location_controller
                  .text
                  .toString();

              context
                  .read<SearchDataFilter>()
                  .income = context
                  .read<SearchDataFilter>()
                  .Income_controller
                  .text
                  .toString().length == 0 ? "0" : context
                  .read<SearchDataFilter>()
                  .income = context
                  .read<SearchDataFilter>()
                  .Income_controller
                  .text
                  .toString();



              navService.pushNamed("/search_result", args: [
                prefs.getString(SharedPrefs.userId),
                context
                    .read<SearchDataFilter>()
                    .profileId,
                context
                    .read<SearchDataFilter>()
                    .gender,
                context
                    .read<SearchDataFilter>()
                    .search_name,
                context
                    .read<SearchDataFilter>()
                    .search_fathername,
                context
                    .read<SearchDataFilter>()
                    .age_from,
                context
                    .read<SearchDataFilter>()
                    .age_to,
                context
                    .read<SearchDataFilter>()
                    .height_from,
                context
                    .read<SearchDataFilter>()
                    .height_to,
                context
                    .read<SearchDataFilter>()
                    .mother_tongue,
                context
                    .read<SearchDataFilter>()
                    .marital_status,
                context
                    .read<SearchDataFilter>()
                    .profile_image,
                context
                    .read<SearchDataFilter>()
                    .location,
                context
                    .read<SearchDataFilter>()
                    .education,
                context
                    .read<SearchDataFilter>()
                    .occupation,
                context
                    .read<SearchDataFilter>()
                    .rashi,
                context
                    .read<SearchDataFilter>()
                    .birth_star,
                context
                    .read<SearchDataFilter>()
                    .income,

                context
                    .read<SearchDataFilter>()
                    .mangalik,
                context
                    .read<SearchDataFilter>()
                    .handicap,
                context.read<SearchDataFilter>()
                    .institute_wise,
              ]);
            }else{

              showalertdailogForSaving(context);

            }

          },
          ),),
        ],
      ),),
      drawer: StylishDrawer(),
      body: SingleChildScrollView(child:Container( margin: EdgeInsets.only(left: 10 , top: 10)  ,child:  Column(children: parts)))) ;

  }






}



class part1Stateful extends StatefulWidget {



  @override
  part1 createState() => part1();

}



 class part1 extends State<part1Stateful>{

   List<String> Age = Lists().generateNumberList(18, 70);
   String from_age = "18" , to_age = "70" , gender = "All" , from_height = "4ft 0inch" , to_height = "7ft 5inch";
   String selected_gender = "";
   String  marital_value = "0";
   bool switchValue = false;


   TextEditingController maritalController = new TextEditingController();

   @override
  void initState() {
    super.initState();


    initGender();
    initSavePrefer();

    initFromSavedSearch();

   }

   initFromSavedSearch() async {

     SharedPreferences prefs = await SharedPreferences.getInstance();


     if(prefs.getString("savedSearch").toString() != "") {
       Map<String, dynamic> jsonObject = jsonDecode(
           prefs.getString("savedSearch").toString());

       context
           .read<SearchDataFilter>()
           .profileidController
           .text = jsonObject["profile_id"];

       setState(() {
         context
             .read<SearchDataFilter>()
             .gender = jsonObject["gender"];
         gender = jsonObject["gender"];

         from_age = jsonObject["age_from"];
         context
             .read<SearchDataFilter>()
             .age_from = jsonObject["age_from"];

         to_age = jsonObject["age_to"];
         context
             .read<SearchDataFilter>()
             .age_to = jsonObject["age_to"];

         from_height = jsonObject["height_from"];
         context
             .read<SearchDataFilter>()
             .height_from = jsonObject["height_from"];

         to_height = jsonObject["height_to"];
         context
             .read<SearchDataFilter>()
             .height_to = jsonObject["height_to"];

         context
             .read<SearchDataFilter>()
             .maritalController
             .text = jsonObject["marital_status"].split(",")[0];
         context
             .read<SearchDataFilter>()
             .marital_status = jsonObject["marital_status"].split(",")[1];

         context
             .read<SearchDataFilter>()
             .search_name_controller
             .text =
         jsonObject["name"].toString() == "0" ? "" : jsonObject["name"]
             .toString();
       });
     }




   }


   initSavePrefer() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setBool("is_save", false);

   }

   String role = "";
   List<String> listgender = [];
   initGender() async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
     gender = prefs.getString(SharedPrefs.gender).toString().toLowerCase();
     role = prefs.getString(SharedPrefs.role_type).toString();

     setState(() {

       if(role == "admin"){
         listgender.add("All");
         listgender.add("Male");
         listgender.add("Female");
         gender = "All";
         context.read<SearchDataFilter>().gender = "All";
       }else {
         if (gender == "male") {
           listgender.add("Female");
           gender = "Female";
           context.read<SearchDataFilter>().gender = "Female";
         } else {
           listgender.add("Male");
           gender = "Male";
           context.read<SearchDataFilter>().gender = "Male";
         }
       }

     });


   }





  @override
  Widget build(BuildContext context) {


      final  filter =  context.watch<SearchDataFilter>();

      setState(() {
        from_age =  filter.age_from;
        to_age =  filter.age_to;
        from_height =  filter.height_from;
        to_height =  filter.height_to;
      });




    return Column(children: [

        Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'Save this search :', // Text indicating the purpose of the CupertinoSwitch
            style: TextStyle(fontSize: 18.0 , fontWeight: FontWeight.bold , color: Colors.pink),
          ),
          CupertinoSwitch(
            activeColor: Colors.pink,
            value: switchValue,
            onChanged: (value) async {

              SharedPreferences prefs = await SharedPreferences.getInstance();

              prefs.setBool("is_save", value);

              setState(() {
                switchValue = value; // Update the CupertinoSwitch state
              });
            },
          ),

        ]),

      Container(child:Row(children: [  CircleWithNumber(number: "01") , const SizedBox(width: 15,) , Text("Profile ID Search", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


        Image.asset("assets/images/path.png" , height: 60,) , SizedBox(width: 30,) ,
        Expanded(flex: 7  ,child: TextFormField(
          controller: context.read<SearchDataFilter>().profileidController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            hintText: 'Enter Profile ID To Search',
            hintStyle: const TextStyle(fontSize: 14),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: ColorsPallete.Pink)
            ),
          ),
        ),),

      ],)),

      Container(child:Row(children: [ CircleWithNumber(number: "02") , const SizedBox(width: 15,) , Text("Gender", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


        Image.asset("assets/images/path_two.png" , height: 60,) , const SizedBox(width: 30,) ,
        Expanded(flex: 7  ,child: DropDown(listItems: listgender, onItemSelected: (String value) {

          setState(() {
            gender = value;
            context.read<SearchDataFilter>().gender = value;
          });

        }, selectedItem: role == "admin" ? "All" : gender  , label: 'Select Gender', seq: "gender",)),

      ],)),


      Container(child:Row(children: [ CircleWithNumber(number: "03") , SizedBox(width: 15,) , Text("Age", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


        Image.asset("assets/images/path.png" , height: 60,) , const SizedBox(width: 30,) ,
        Expanded(flex: 7  ,child: DropDown(listItems: Age, onItemSelected: (String value) {

          setState(() {
            from_age = value;
            context.read<SearchDataFilter>().age_from = value;
                      });

        }, selectedItem: from_age, label: 'From', seq: "from_age",)),
        Expanded(flex: 1  ,child: Container()),
        Expanded(flex: 7  ,child: DropDown(listItems: Age, onItemSelected: (String value) {

          setState(() {
            to_age = value;
            context.read<SearchDataFilter>().age_to = value;
          });

        }, selectedItem: to_age , label: 'To', seq: "to_age",)),

      ],)),

      Container(child:Row(children: [ CircleWithNumber(number: "04") , const SizedBox(width: 15,) , Text("Height(ft Inch)", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin: const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


        Image.asset("assets/images/path_two.png" , height: 60,) , SizedBox(width: 30,) ,
        Expanded(flex: 7  ,child: DropDown(listItems: Data().heights, onItemSelected: (String value) {

          setState(() {
            from_height = value;
            context.read<SearchDataFilter>().height_from = value;
          });

        }, selectedItem: from_height , label: 'From', seq: "from_height",)),
        Expanded(flex: 1  ,child: Container()),
        Expanded(flex: 7  ,child: DropDown(listItems: Data().heights, onItemSelected: (String value) {

          setState(() {
            to_height = value;
            context.read<SearchDataFilter>().height_to = value;
          });


        }, selectedItem: to_height , label: 'To', seq: "to_height",)),

      ],)),

      Container(child:Row(children: [ CircleWithNumber(number: "05") , const SizedBox(width: 15,) , Text("Marital Status", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin: const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


        Image.asset("assets/images/path.png" , height: 60,) , SizedBox(width: 30,) ,
        Expanded(child: CustomDropdown(icondata: MdiIcons.heart  ,controller: context.read<SearchDataFilter>().maritalController , labelText: TranslationService.translate("marital_status"), onButtonPressed: () async {

          EasyLoading.show(status: 'Please wait...');
          List<DataFetch> listitem =  await Values.getValues(context , "marital_status" , "");

          EasyLoading.dismiss();

          final value = await SingleSelectDialog().showBottomSheet(context, listitem ,"Select Marital Status");
          context.read<SearchDataFilter>().maritalController.text = value.label;
          context.read<SearchDataFilter>().marital_status = value.value;


        },),),

      ],)),

      Container(child:Row(children: [ CircleWithNumber(number: "06") , const SizedBox(width: 15,) , Text("Profile Image Wise", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin: const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


        Image.asset("assets/images/path.png" , height: 60,) , SizedBox(width: 30,) ,
        Expanded(child: CustomDropdown(icondata: MdiIcons.heart  ,controller: context.read<SearchDataFilter>().profileImageController , labelText: TranslationService.translate("profile_image_wise"), onButtonPressed: () async {

          EasyLoading.show(status: 'Please wait...');
          List<DataFetch> listitem =  [];

          listitem.add(DataFetch(label: "All Profiles", value: "all"));
          listitem.add(DataFetch(label: "Profiles With Images", value: "with"));
          listitem.add(DataFetch(label: "Profiles Without Images", value: "without"));

          EasyLoading.dismiss();

          final value = await SingleSelectDialog().showBottomSheet(context, listitem , "Select Imagewise");
          context.read<SearchDataFilter>().profileImageController.text = value.label;
          context.read<SearchDataFilter>().profile_image = value.value;


        },),),

      ],)),


      Container(child:Row(children: [ CircleWithNumber(number: "07") , const SizedBox(width: 15,) , Text("Search By Name", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin: const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


        Image.asset("assets/images/path_two.png" , height: 60,) , SizedBox(width: 30,) ,
        Expanded(flex: 7  ,child: TextFormField(

          controller: context.read<SearchDataFilter>().search_name_controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            hintText: 'Enter Name To Search',
            hintStyle: const TextStyle(fontSize: 14),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: ColorsPallete.Pink)
            ),
          ),
        ),),

      ],)),


    ]);

  }

   }



class part2stateful extends StatefulWidget {

  @override
  part2 createState() => part2();

}

 class part2 extends State<part2stateful>{

   TextEditingController mothertongueController = new TextEditingController();
   TextEditingController highesteducationController =new TextEditingController();
   TextEditingController occupationController =new TextEditingController();
   TextEditingController rashiController =new TextEditingController();
   TextEditingController birthstarController =new TextEditingController();


   String mother_tongue_value = "0" , highest_edu_value = "0" , occupation_value = "0" ,rashi = "0" , birth_star ="0";

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initFromSavedSearch();

  }


   initFromSavedSearch() async {

     SharedPreferences prefs = await SharedPreferences.getInstance();


     if(prefs.getString("savedSearch").toString() != "") {
       Map<String, dynamic> jsonObject = jsonDecode(
           prefs.getString("savedSearch").toString());

       setState(() {
         context
             .read<SearchDataFilter>()
             .search_fathername_controller
             .text = jsonObject["fathername"].toString() == "0"
             ? ""
             : jsonObject["fathername"].toString();

         context
             .read<SearchDataFilter>()
             .mothertongueController
             .text = jsonObject["mother_tongue"].split(",")[0];
         context
             .read<SearchDataFilter>()
             .mother_tongue = jsonObject["mother_tongue"].split(",")[1];

         context
             .read<SearchDataFilter>()
             .search_location_controller
             .text = jsonObject["location"];

         context
             .read<SearchDataFilter>()
             .highesteducationController
             .text = jsonObject["education"].split(",")[0];
         context
             .read<SearchDataFilter>()
             .education = jsonObject["education"].split(",")[1];

         context
             .read<SearchDataFilter>()
             .occupationController
             .text = jsonObject["occupation"].split(",")[0];
         context
             .read<SearchDataFilter>()
             .occupation = jsonObject["occupation"].split(",")[1];

         context
             .read<SearchDataFilter>()
             .rashiController
             .text = jsonObject["rashi"].split(",")[0];
         context
             .read<SearchDataFilter>()
             .rashi = jsonObject["rashi"].split(",")[1];

         context
             .read<SearchDataFilter>()
             .birthstarController
             .text = jsonObject["birth_star"].split(",")[0];
         context
             .read<SearchDataFilter>()
             .birth_star = jsonObject["birth_star"].split(",")[1];
       });
     }


   }




   @override
  Widget build(BuildContext context) {

    return Column(children: [ Container(child:Row(children: [ CircleWithNumber(number: "08") , const SizedBox(width: 15,) , Text("Search By Fathername", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin: const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [

        Image.asset("assets/images/path.png" , height: 60,) , SizedBox(width: 30,) ,
        Expanded(flex: 7  ,child: TextFormField(
          controller: context.read<SearchDataFilter>().search_fathername_controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            hintText: 'Enter FatherName To Search',
            hintStyle: const TextStyle(fontSize: 14),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: ColorsPallete.Pink)
            ),
          ),
        ),),

      ],)),

      /*Container(child:Row(children: [ CircleWithNumber(number: "09") , const SizedBox(width: 15,) , Text("Mother Tongue", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin: const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [

        Image.asset("assets/images/path_two.png" , height: 60,) , SizedBox(width: 30,) ,
        Expanded(child: CustomDropdown(icondata: Icons.language  ,controller: context.read<SearchDataFilter>().mothertongueController , labelText: Strings.mother_tongue, onButtonPressed: () async {

          EasyLoading.show(status: 'Please wait...');
          List<DataFetch> listitem =  await Values.getValues(context , "languages" , "");
          EasyLoading.dismiss();

          final value = await SingleSelectDialog().showBottomSheet(context, listitem , "Select Languages");
          context.read<SearchDataFilter>().mothertongueController.text = value.label;
          context.read<SearchDataFilter>().mother_tongue = value.value;

        },),),

      ],)),*/


      Container(child:Row(children: [ CircleWithNumber(number: "10") , const SizedBox(width: 15,) , Text("Search By Location", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin: const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [

        Image.asset("assets/images/path.png" , height: 60,) , SizedBox(width: 30,) ,
        Expanded(flex: 7  ,child: TextFormField(
          controller: context.read<SearchDataFilter>().search_location_controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            hintText: 'Search By area/city/state/country',
            hintStyle: const TextStyle(fontSize: 14),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: ColorsPallete.Pink)
            ),
          ),
        ),),

      ],)),


      Container(child:Row(children: [ CircleWithNumber(number: "11") , const SizedBox(width: 15,) , Text("Education Search", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin: const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [

        Image.asset("assets/images/path_two.png" , height: 60,) , SizedBox(width: 30,) ,
        Expanded(child: CustomDropdown(icondata: MdiIcons.bookEducation  ,controller: context.read<SearchDataFilter>().highesteducationController , labelText: Strings.highest_education, onButtonPressed: () async {

          EasyLoading.show(status: "Loading...");
          List<EduFetchstate> listedu_fetch =  await Values.getEducationList(context , "education" , "");

          listedu_fetch.insert(0, EduFetchstate(degree_name: 'Any', degree_hindi: 'Any', degree_guj: 'Any', degree_marathi: 'Any', degree_tamil: 'Any', degree_urdu: 'Any', Id: '0'));

          EasyLoading.dismiss();

          final value = await SingleSelectDialog().showBottomSheetEducation(context, listedu_fetch);
          context.read<SearchDataFilter>().highesteducationController.text = value.degree_name;
          context.read<SearchDataFilter>().education = value.Id;


        },),),

      ],)),


      Container(child:Row(children: [ CircleWithNumber(number: "12") , const SizedBox(width: 15,) , Text("Occupation Search", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin: const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [

        Image.asset("assets/images/path.png" , height: 60,) , SizedBox(width: 30,) ,
        Expanded(child: CustomDropdown(icondata: Icons.sell  ,controller: context.read<SearchDataFilter>().occupationController , labelText: Strings.occupation, onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheetOccupation(context, await Values.getOccupationList(context , "education" , ""));
          context.read<SearchDataFilter>().occupationController.text = value.occupation;
          context.read<SearchDataFilter>().occupation = value.Id;

        },)),

      ],)),

      Container(child:Row(children: [ CircleWithNumber(number: "13") , const SizedBox(width: 15,) , Text("Rashi Search", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin: const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [

        Image.asset("assets/images/path_two.png" , height: 60,) , SizedBox(width: 30,) ,
        Expanded(child: CustomDropdown(icondata: MdiIcons.starBox  ,controller:context.read<SearchDataFilter>().rashiController  , labelText: Strings.rashi, onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "rashi" , "") , "Select Rashi");
          context.read<SearchDataFilter>().rashiController.text = value.label;
          context.read<SearchDataFilter>().rashi = value.value;

        },),),

      ],)),

      Container(child:Row(children: [ CircleWithNumber(number: "14") , const SizedBox(width: 15,) , Text("Birth Star Search", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin: const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [

        Image.asset("assets/images/path.png" , height: 60,) , SizedBox(width: 30,) ,
        Expanded(child: CustomDropdown(icondata: MdiIcons.starBox  ,controller:context.read<SearchDataFilter>().birthstarController  , labelText: Strings.birth_star, onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "birth_star" , "") , "Select Birth Star");
          context.read<SearchDataFilter>().birthstarController.text = value.label;
          context.read<SearchDataFilter>().birth_star = value.value;

        },),),

      ],)),
    ],);

  }



   }




 class part3stateful extends StatefulWidget {

  @override
  part3 createState() => part3();

}

 class part3 extends State<part3stateful>{


  TextEditingController raputedController = new TextEditingController();
   bool _isChecked = false , _isCheckedHandicap = false;
  String reputed_edu_value = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initFromSavedSearch();

  }


  initFromSavedSearch() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();



    if(prefs.getString("savedSearch") != "") {
    Map<String, dynamic> jsonObject = jsonDecode(prefs.getString("savedSearch").toString());



      setState(() {
        context
            .read<SearchDataFilter>()
            .Income_controller
            .text = jsonObject["income"].toString();

        print(jsonObject["mangalik"].toString() + "[]-------");

        if (jsonObject["mangalik"].toString() == "0") {
          context
              .read<SearchDataFilter>()
              .mangalik = jsonObject["mangalik"].toString();
        } else {
          context
              .read<SearchDataFilter>()
              .mangalik = jsonObject["mangalik"].toString();
        }

        if (jsonObject["handicap"].toString() == "0") {
          context
              .read<SearchDataFilter>()
              .handicap = jsonObject["handicap"].toString();
        } else {
          context
              .read<SearchDataFilter>()
              .handicap = jsonObject["handicap"].toString();
        }

        context
            .read<SearchDataFilter>()
            .raputedController
            .text = jsonObject["institute"].toString().split(",")[0];
        context
            .read<SearchDataFilter>()
            .institute_wise = jsonObject["institute"].toString().split(",")[1];
      });
    }




  }

  @override
  Widget build(BuildContext context) {

    final sharedData = context.watch<SearchDataFilter>();


    return Column(children: [Container(child:Row(children: [ CircleWithNumber(number: "15") , const SizedBox(width: 15,) , Text("Annual Income Wise Search", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin: const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


        Image.asset("assets/images/path_two.png" , height: 60,) , SizedBox(width: 30,) ,
        Expanded(child: CustomDropdown(icondata: MdiIcons.starBox  ,controller:context.read<SearchDataFilter>().Income_controller  , labelText: Strings.annual_income, onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "annual_income" , "") , "Select Annual Income");
          context.read<SearchDataFilter>().Income_controller.text = value.label;
          context.read<SearchDataFilter>().income = value.value;

        },),),
      ],)),

      /*Container(child:Row(children: [ CircleWithNumber(number: "16") , const SizedBox(width: 15,) , Text("Mangalik Search", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin: const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


        Image.asset("assets/images/path_two.png" , height: 60,) , SizedBox(width: 30,) ,Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey[200],
          ),
          child: Row(
            children: [
              StylishCheckbox(
                value:sharedData.mangalik == "0"  ?  false : true,
                onChanged: (bool value) {
                  setState(() {
                    _isChecked = value;

                    if(_isChecked == false){
                      context.read<SearchDataFilter>().mangalik = "0";
                    }else{
                      context.read<SearchDataFilter>().mangalik = "1";
                    }

                  });
                },
              ),
              SizedBox(width: 10.0),
              Text(
                'Is Mangalik?',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ],),),*/


      Container(child:Row(children: [ CircleWithNumber(number: "17") , const SizedBox(width: 15,) , Text("Physically Disabled", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


        Image.asset("assets/images/path.png" , height: 60,) , SizedBox(width: 30,) ,Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey[200],
          ),
          child: Row(
            children: [
              StylishCheckbox(
                value:sharedData.handicap == "0" ? false : true,
                onChanged: (bool value) {
                  setState(() {
                    _isCheckedHandicap = value;

                    if(_isCheckedHandicap == false){
                      context.read<SearchDataFilter>().handicap = "0";
                    }else{
                      context.read<SearchDataFilter>().handicap = "Yes";
                    }


                  });
                },
              ),
              SizedBox(width: 10.0),
              Text(
                'Is Physically Disabled?',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ],),),

     /* Container(child:Row(children: [ CircleWithNumber(number: "18") , const SizedBox(width: 15,) , Text("InsituteWise Search", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
      Container(margin: const EdgeInsets.only(left: 15 , right: 15 , bottom: 50) , child:Row(children: [

        Image.asset("assets/images/path_two.png" , height: 60,) , const SizedBox(width: 30,) ,
        Expanded(child: CustomDropdown(icondata: MdiIcons.bookEducation  ,controller: context.watch<SearchDataFilter>().raputedController , labelText: Strings.reputed_university, onButtonPressed: () async {

            EasyLoading.show(status: "Please Wait...");
          List<InstituteFetchstate> list_institute =  await Values.getReputedUniveristy(context , "education" , "");
          list_institute.insert(0, InstituteFetchstate(institute_name: 'Any', institute_hindi: 'Any', institute_guj: 'Any', institute_marathi: 'Any', institute_tamil: 'Any', institute_urdu: 'Any', Id: 'Any' , ));

            EasyLoading.dismiss();

          final value = await SingleSelectDialog().showBottomSheetInstitute(context, list_institute);
            context.read<SearchDataFilter>().raputedController.text = value.institute_name;
            sharedData.institute_wise = value.Id;

        },)),

      ],))*/],);

  }

 }