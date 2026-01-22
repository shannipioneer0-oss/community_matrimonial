
import 'dart:convert';

import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/Userdata.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/model/user_plan_data.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/chat/ChatList.dart';
import 'package:community_matrimonial/screens/dashboard/dashboard.dart';
import 'package:community_matrimonial/screens/filter/filter_screen.dart';
import 'package:community_matrimonial/screens/filter_result/search_result.dart';
import 'package:community_matrimonial/screens/inbox/inbox.dart';
import 'package:community_matrimonial/screens/user_profile/user_detail.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:fancy_bottom_navigation_plus/fancy_bottom_navigation_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:intl/intl.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/Strings.dart';
import 'package:http/http.dart' as http;


class MainScreenContainer extends StatefulWidget {

  final int type;
  const MainScreenContainer({Key? key, required this.type}) : super(key: key);

  @override
  MainScreenAppState createState() => MainScreenAppState();

}

class MainScreenAppState extends State<MainScreenContainer>{
  int currentpage = -1;




  @override
  void initState() {
    super.initState();

    _checkConnectivity();

    if(utils().isconnected() == false){

      Future.delayed(Duration(milliseconds: 100) , (){
        DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");
      });

    }

    print(widget.type.toString()+"__++++++++)______");

    //TranslationService.load("en");

    Future.delayed(Duration(milliseconds: 200), () {
      Userdata().initUserData(context);
    });



     initScreen();

  }





  @override
  void dispose() {
    // Unregister the observer to avoid memory leaks

    super.dispose();
  }


  initDialogs() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();


    if(prefs.getString(SharedPrefs.reason_date).toString() != "null") {

    DateFormat format = DateFormat("dd/MM/yyyy");
    DateTime dateTime = format.parse(prefs.getString(SharedPrefs.reason_date).toString());
    DateTime dateTimenow = DateTime.now();



      if (prefs.getString(SharedPrefs.reason).toString() != "null") {
        if (dateTimenow.isBefore(dateTime)) {
          DialogClass().showDialog4(context, "App In Progress Alert",
              "App Will start from " +
                  prefs.getString(SharedPrefs.reason_date).toString() +
                  " and reason is  " +
                  prefs.getString(SharedPrefs.reason).toString(), "OK");
        }
      }


      if (prefs.getString(SharedPrefs.remainingDays).toString() != "null") {
        if (int.parse(prefs.getString(SharedPrefs.remainingDays).toString()) <=
            0) {
          DialogClass().showDialog3(context, "Renewal Alert!",
              "Your Plan has Expired. Please Renew to continue", "Ok");
        }
      } else {

        if (int.parse(prefs.getString(SharedPrefs.joined_days).toString()) >=
            14) {
          DialogClass().showDialog3(context, "Trial Period Expired",
              "Your Trial Period has expired. Please Upgrade to continue",
              "Ok");
        }

      }
    }


    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version =  prefs.getString(SharedPrefs.version).toString();

    print(version+"-----"+packageInfo.version);

    if(version.toString() != "null") {
      if (packageInfo.version != version.split("_")[1].replaceAll(".apk", "")) {
        final res = await DialogClass().showDialogBeforesubmit(
            context, "Update Avialable",
            "Please update your apk as latest version is available", "Download",
            "1");

        if (res != null) {
          EasyLoading.show(status: "Downloading Wait ...");

          final response = await http.get(Uri.parse(
              'https://matriapi.shannishah.com/uploads/apks/zalawad_apk/' +
                  version));
          if (response.statusCode == 200) {
            // Calculate the checksum of the downloaded APK
            final bytes = response.bodyBytes;
            final checksum = sha256.convert(bytes).toString();


           /* try {
              //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
              OtaUpdate()
                  .execute(
                'https://matriapi.shannishah.com/uploads/apks/zalawad_apk/' +
                    version,
                // OPTIONAL
                destinationFilename: version,
                //OPTIONAL, ANDROID ONLY - ABILITY TO VALIDATE CHECKSUM OF FILE:
                sha256checksum: checksum,
              ).listen(
                    (OtaEvent event) {
                  if (event.status == "INSTALLING") {
                    EasyLoading.dismiss();
                  }
                },
              );
            } catch (e) {
              print('Failed to make OTA update. Details: $e');
            }*/
          }

          print('https://matriapi.shannishah.com/uploads/apks/zalawad_apk/' +
              version);


          /*

         EasyLoading.show(status: "Downloaidng APK...");

        FileDownloader.downloadFile(
            url: "https://matriapi.shannishah.com/uploads/apks/zalawad_apk/"+version,
            name: "matrimony.apk",
            subPath: res?.absolute.path ,
            onProgress: (String? fileName, double progress) {

            },
            onDownloadCompleted: (String path) async {

              EasyLoading.dismiss();
              OpenFile.open(path);



            },
            onDownloadError: (String error) {

            });*/

        }
      }
    }




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



  String getSha256Checksum(String input) {
    final bytes = utf8.encode(input); // Convert string to bytes
    final digest = sha256.convert(bytes); // Calculate the SHA-256 hash
    return digest.toString(); // Convert the digest to a hexadecimal string
  }


  initScreen() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fullname = prefs.getString(SharedPrefs.fullname) ?? "";



    if(widget.type == -1) {
      if (fullname == "" || fullname.isEmpty) {
        navService.pushNamed("/basic_details", args: "insert");

        setState(() {
          currentpage = 0;
        });
      } else {
        setState(() {
          currentpage = 2;
        });
      }
    }else{

      print(widget.type.toString()+"_______+++++++++++++++");

        if(widget.type == 0){
          setState(() {
            currentpage = 0;
          });
        }else if(widget.type == 1){
          setState(() {
            currentpage = 1;
          });
        }else if(widget.type == 2){
          setState(() {
            currentpage = 2;
          });
        }else if(widget.type == 3){
          setState(() {
            currentpage = 3;
          });
        }else if(widget.type == 4){
          setState(() {
            currentpage = 4;
          });
        }


        print(currentpage.toString()+"{}");



    }


  }



  Center? _getpage(int page) {
    switch (page) {
      case 0:
        return Center(
          child: UserDetail(),
        );
      case 1:
        return Center(
          child: Inbox(),
        );
      case 2:
        return Center(
          child: DashboardApp(),
        );
      case 3:

        return Center(
          child: FilterScreenApp(),
        );
      default:
        Center(
          child: Container()
        );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    return VisibilityDetector(
    key: Key('my-widget-key'),
    onVisibilityChanged: (visibilityInfo) {
    num visiblePercentage = visibilityInfo.visibleFraction * 100;
    if(visiblePercentage >= 50){

      Future.delayed(Duration(milliseconds: 100), () {
        Userdata().initUserData(context);
      });

      Future.delayed(Duration(milliseconds: 1000), ()
      {
        initDialogs();
      });


    }

    },
    child:WillPopScope(
        onWillPop: (){

      if(currentpage == 2){


        Dialogs.materialDialog(
            msg: "Are you sure you want to exit?",
            title: "Exit Screen",
            color: Colors.white,
            context: context,
            onClose: (value) => print("returned value is '$value'"),
            actions: [
              IconsOutlineButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                text: "Yes Exit",
                iconData: Icons.info,
                textStyle: TextStyle(color: Colors.green),
                iconColor: Colors.green,
              ),

              IconsOutlineButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: "Cancel",
                iconData: Icons.cancel,
                textStyle: TextStyle(color: Colors.red),
                iconColor: Colors.red,
              ),

            ]);

      }else{
        setState(() {
          currentpage = currentpage -1;
          navService.pushNamed("/main_screen" , args:currentpage);
        });

      }

      print("++++++++++++++++++++++");


      return Future.value(false);
    },
    child: MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.pinkAccent,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          textTheme: TextTheme(displayMedium: TextStyle(color: Colors.white))
      ),
      home: Scaffold(
        body: currentpage != -1 ?  _getpage(currentpage) : Container(),
        bottomNavigationBar: SafeArea(child: FancyBottomNavigationPlus(
          barBackgroundColor:  ColorsPallete.blue_2,
          initialSelection: currentpage ,
          tabs: [
            TabData(icon: const Icon(Icons.account_circle_outlined), title:TranslationService.translate("profile") ),
            TabData(icon: const Icon(Icons.mail_outline), title: TranslationService.translate("inbox") ),
            TabData(icon: const Icon(Icons.home), title: TranslationService.translate("home")),
            TabData(icon: const Icon(Icons.search), title: TranslationService.translate("search")),
          ],
          titleStyle: TextStyle(color: Colors.white),
          onTabChangedListener: (position) {
            setState(() {
              currentpage = position;
            });
          },
        ),
      ),
    ))));
  }
}