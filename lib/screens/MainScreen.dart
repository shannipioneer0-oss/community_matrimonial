
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
import 'package:community_matrimonial/utils/universalbackwrapper_custom.dart';
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

import '../utils/universalback_wrapper.dart';


class MainScreenContainer extends StatefulWidget {

  final int type;
  const MainScreenContainer({Key? key, required this.type}) : super(key: key);

  @override
  MainScreenAppState createState() => MainScreenAppState();

}

class MainScreenAppState extends State<MainScreenContainer> {

  int currentpage = -1;

  @override
  void initState() {
    super.initState();

    _checkConnectivity();

    if (utils().isconnected() == false) {
      Future.delayed(Duration(milliseconds: 100), () {
        DialogClass().showDialog2(
            context, "No Internet", "Sorry Internet is not available", "OK");
      });
    }

    print(widget.type.toString() + "__++++++++)______");

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


    if(await utils().isvalidFreeDate() == true){

      return;
    }

    if (prefs.getString(SharedPrefs.role_type) == "admin") {

    } else {


      if (prefs.getString(SharedPrefs.reason_date).toString() != "null") {
        DateFormat format = DateFormat("dd/MM/yyyy");
        DateTime dateTime = format.parse(
            prefs.getString(SharedPrefs.reason_date).toString());
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


        print(prefs.getString(SharedPrefs.remainingDays).toString() + "()()()" +
            prefs.getString(SharedPrefs.isverify_payment).toString());


        if (prefs.getString(SharedPrefs.remainingDays).toString() != "null") {

          if (int.parse(
              prefs.getString(SharedPrefs.remainingDays).toString()) <=
              0) {

            final res  = await   DialogClass().showPremiumInfoDialog(
                context, TranslationService.translate("renewal_alert"),
                TranslationService.translate("renewal_alert_desc"), "Ok");

            if (res == false || res == true) {
              navService.pushNamed("/main_screen" , args: 0);
              //Navigator.pop(context);
              // SystemNavigator.pop();
            }

          }


        }else if(await utils().isvalidFreeDate2() == true){

          final res  = await  DialogClass().showPremiumInfoDialog(
              context, TranslationService.translate("renewal_alert"),
              TranslationService.translate("renewal_alert_desc"), "Ok");

          if (res == false || res == true) {
            navService.pushNamed("/main_screen" , args: 0);
            //Navigator.pop(context);
            // SystemNavigator.pop();
          }


        } else {
          if (prefs.getString(SharedPrefs.isverify_payment).toString() ==
              "null") {
            if (int.parse(
                prefs.getString(SharedPrefs.joined_days).toString()) >=
                14) {
              final res = await DialogClass().showPremiumInfoDialog(
                  context, TranslationService.translate("trial_period"),
                  TranslationService.translate("trial_period_desc"),
                  "Ok");

              if (res == false) {
                navService.pushNamed("/membership");
                //Navigator.pop(context);
                // SystemNavigator.pop();
              }
            } else if (int.parse(
                prefs.getString(SharedPrefs.joined_days).toString()) >=
                13) {
              DialogClass().showPremiumInfoDialog(
                  context, TranslationService.translate("trial_period_1"),
                  TranslationService.translate("trial_period_desc_1"),
                  "Ok");
            } else if (int.parse(
                prefs.getString(SharedPrefs.joined_days).toString()) >=
                12) {

              DialogClass().showPremiumInfoDialog(
                  context, TranslationService.translate("trial_period_1"),
                  TranslationService.translate("trial_period_desc_2"),
                  "Ok");

            } else if (int.parse(
                prefs.getString(SharedPrefs.joined_days).toString()) >=
                11) {

              DialogClass().showPremiumInfoDialog(
                  context, TranslationService.translate("trial_period_1"),
                  TranslationService.translate("trial_period_desc_3"),
                  "Ok");

            } else {
              print("11112222");

              if (prefs.getString(SharedPrefs.joined_days_done).toString() !=
                  "1") {
                final res = await DialogClass().showPremiumInfoDialog(
                    context, TranslationService.translate("joined_alert"),
                    TranslationService.translate("joined_alert_desc"), "Ok");

                if (res == false) {
                  prefs.setString(SharedPrefs.joined_days_done, "1");
                }
              }
            }
          } else
          if (prefs.getString(SharedPrefs.isverify_payment).toString() == "1") {
            final res = await DialogClass().showPremiumInfoDialog(
                context, TranslationService.translate("payment_verification"),
                TranslationService.translate("payment_verification_details"),
                "Ok");

            if (res == true || res == false) {
              navService.pushNamed("/main_screen", args: 0);
            }
          }
        }
      }


      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = prefs.getString(SharedPrefs.version).toString();

      print(version + "-----" + packageInfo.version);

      if (version.toString() != "null") {
        if (packageInfo.version !=
            version.split("_")[1].replaceAll(".apk", "")) {
          final res = await DialogClass().showDialogBeforesubmit(
              context, "Update Avialable",
              "Please update your apk as latest version is available",
              "Download",
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
    int target;

    if (widget.type == -1) {
      target = (fullname.isEmpty) ? 0 : 2;
    } else {
      target = widget.type;
    }

    // Ensure the UI builds with the new page
    setState(() {
      currentpage = target;
    });


  }


  Center? _getpage(int page) {

  //9328141639

    switch (page) {
      case 0:
        return Center(
          child: UserDetail(),
        );
      case 1:

        initDialogs();
        return Center(
          child: Inbox(),
        );
      case 2:

        initDialogs();
        return Center(
          child: DashboardApp(),
        );
      case 3:

        initDialogs();
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

  GlobalKey<FancyBottomNavigationPlusState> _bottomNavKey = GlobalKey();

  @override
  @override
  Widget build(BuildContext context) {



    // 1. Prevent building the nav bar until we have a real index
    if (currentpage == -1) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return PopScope(
      // canPop: false prevents the app from exiting automatically
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        debugPrint("Back detected on page: $currentpage");


          if(currentpage == 0){

            Dialogs.materialDialog(
              msg: "Are you sure you want to exit?",
              title: "Exit Screen",
              context: context,
              actions: [
                IconsOutlineButton(
                  onPressed: () => SystemNavigator.pop(),
                  text: "Yes Exit",
                ),
                IconsOutlineButton(
                  onPressed: () => Navigator.of(context).pop(),
                  text: "Cancel",
                ),
              ],
            );


          } else {

            setState(() {
              if (currentpage > 0) {
                currentpage = currentpage - 1;
              }
              _bottomNavKey.currentState?.setPage(currentpage);
            });

          }


      }, child: Theme( // Use Theme instead of MaterialApp to keep the pink accent
        data: ThemeData(
            primaryColor: Colors.pinkAccent,
            iconTheme: const IconThemeData(color: Colors.white),
            textTheme: const TextTheme(
                displayMedium: TextStyle(color: Colors.white))
        ),
        child: Scaffold(
          body: _getpage(currentpage),
          bottomNavigationBar: SafeArea(
            child: FancyBottomNavigationPlus(
              key: _bottomNavKey,
              // This MUST be the GlobalKey defined in your State class
              barBackgroundColor: ColorsPallete.blue_2,
              initialSelection: currentpage,
              tabs: [
                TabData(icon: const Icon(Icons.account_circle_outlined),
                    title: TranslationService.translate("profile")),
                TabData(icon: const Icon(Icons.mail_outline),
                    title: TranslationService.translate("inbox")),
                TabData(icon: const Icon(Icons.home),
                    title: TranslationService.translate("home")),
                TabData(icon: const Icon(Icons.search),
                    title: TranslationService.translate("search")),
              ],
              titleStyle: const TextStyle(color: Colors.white),
              onTabChangedListener: (position) {

                  setState(() {
                    currentpage = position;
                  });

              },
            ),
          ),
        ),
      ),
    );
  }


}