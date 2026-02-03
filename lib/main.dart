
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/model/profile_details_model.dart';
import 'package:community_matrimonial/network_utils/model/user_plan_data.dart';
import 'package:community_matrimonial/network_utils/service/BackgroundService.dart';
import 'package:community_matrimonial/network_utils/service/VideoCalls.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/MainScreen.dart';
import 'package:community_matrimonial/screens/about_us/about_us.dart';
import 'package:community_matrimonial/screens/about_us/chief_members.dart';
import 'package:community_matrimonial/screens/about_us/contact_us.dart';
import 'package:community_matrimonial/screens/about_us/faqs.dart';
import 'package:community_matrimonial/screens/about_us/member_list_trusteeshree.dart';
import 'package:community_matrimonial/screens/about_us/privacy_policy..dart';
import 'package:community_matrimonial/screens/chat/ChatScreen.dart';
import 'package:community_matrimonial/screens/dashboard/dashboard.dart';
import 'package:community_matrimonial/screens/filter/filter_screen.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/basic_details.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/contactdetails.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/documentUploadEdit.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/educationaldetails_edit.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/family_details_edit.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/hobby_details_edit.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/horoscope_details_edit.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/image_gallery.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/lifestyledetails_edit.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/occupational_details_edit.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/user_detail_edit.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/verify_doc_list.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/verify_image_list.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/verify_screen.dart';
import 'package:community_matrimonial/screens/filter_result/saved_search.dart';
import 'package:community_matrimonial/screens/filter_result/search_result.dart';
import 'package:community_matrimonial/screens/inbox/inbox.dart';
import 'package:community_matrimonial/screens/loginscreen.dart';
import 'package:community_matrimonial/screens/loginscreen_verify.dart';
import 'package:community_matrimonial/screens/membership/membership.dart';
import 'package:community_matrimonial/screens/notification/notification_list.dart';
import 'package:community_matrimonial/screens/registeration.dart';
import 'package:community_matrimonial/screens/settings/features.dart';
import 'package:community_matrimonial/screens/settings/settings.dart';
import 'package:community_matrimonial/screens/user_details/image_gallery.dart';
import 'package:community_matrimonial/screens/user_details/match_profile.dart';
import 'package:community_matrimonial/screens/user_details/user_details.dart';
import 'package:community_matrimonial/screens/user_profile/add_edit_profile/PreferenceFilter.dart';
import 'package:community_matrimonial/screens/user_profile/add_edit_profile/basic_details.dart';
import 'package:community_matrimonial/screens/user_profile/add_edit_profile/contactdetails.dart';
import 'package:community_matrimonial/screens/user_profile/add_edit_profile/documentUpload.dart';
import 'package:community_matrimonial/screens/user_profile/add_edit_profile/educationaldetails.dart';
import 'package:community_matrimonial/screens/user_profile/add_edit_profile/family_details.dart';
import 'package:community_matrimonial/screens/user_profile/add_edit_profile/family_member_details.dart';
import 'package:community_matrimonial/screens/user_profile/add_edit_profile/hobby_details_edit.dart';
import 'package:community_matrimonial/screens/user_profile/add_edit_profile/horoscope_details.dart';
import 'package:community_matrimonial/screens/user_profile/add_edit_profile/image_gallery.dart';
import 'package:community_matrimonial/screens/user_profile/add_edit_profile/lifestyledetails.dart';
import 'package:community_matrimonial/screens/user_profile/add_edit_profile/occupational_details.dart';
import 'package:community_matrimonial/screens/user_profile/add_edit_profile/partner_prefs_details.dart';
import 'package:community_matrimonial/screens/user_profile/user_detail.dart';
import 'package:community_matrimonial/screens/videocalls/call.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/animations.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/intro.dart';





String channelname = "" , message_type = "";
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();

  message_type = message.data["type"];

  if(message.data["type"] == "interest") {

    showFlutterNotification(message);

  }else if(message.data["type"] == "video"){
    print(message.data["channel"]);

    _showNotification();
 //   VideoCalls().displayIncomingCall(message.data["uuid"], message.data["caller"] , message.data["avatar"] , message.data["channel"] , message.data["mobile"] ,  message.data["token"]);

  }else if(message.data["type"] == "missed"){

    Future.delayed(Duration(milliseconds: 100) ,(){
        print("missed ___ misssed");
    });


  }else if(message.data["type"] == "decline"){

    Future.delayed(Duration(milliseconds: 100) ,(){
      print("decline ___ decline");
    });

  }




  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //print('Handling a background message ${message.messageId}');
}






/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  isFlutterLocalNotificationsInitialized = true;
}

Future<void> showFlutterNotification(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;

  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {

    var initializationSettingsAndroid =
    new AndroidInitializationSettings("@drawable/kin_removebg");


    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:(details) {
          navService.pushNamed("/notification");
        },
        onDidReceiveBackgroundNotificationResponse: (details) {
          navService.pushNamed("/notification");
        },);


    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );



  }
}


_showNotification()  {

   /*AwesomeNotifications().initialize(
      '',
      [
      NotificationChannel(
      channelGroupKey: "Notifikasi",
      channelKey: 'notifikasi',
      channelName: 'Notifikasi',
      channelDescription: 'Menampilkan notifikasi',
      defaultColor: const Color(0xFF9D50DD),
  ledColor: Colors.white,
  playSound: true,
  // soundSource: 'resource://raw/birds',
        soundSource: 'asset://assets/audio/incoming_call.mp3',
        importance: NotificationImportance.High,
        enableVibration: true,
        defaultPrivacy: NotificationPrivacy.Public,
  // defaultRingtoneType: DefaultRingtoneType.Ringtone,
  ),

  ],);



   AwesomeNotifications().createNotification(

      content: NotificationContent(
          id: -1, // -1 is replaced by a random number
          channelKey: 'alerts',
          title: 'Huston! The eagle has landed!',
          customSound: "resource://raw/incoming_call",
          body:
          "A small step for a man, but a giant leap to Flutter's community!",
          bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
          largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
          //'asset://assets/images/balloons-in-sky.jpg',
          notificationLayout: NotificationLayout.BigPicture,
          payload: {'notificationId': '1234567890'}),

      actionButtons: [
         NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
        NotificationActionButton(
          showInCompactView: true,
            key: 'REPLY',
            label: 'Reply Message',
            requireInputText: true,
            actionType: ActionType.KeepOnTop),
        NotificationActionButton(
            showInCompactView: true,
            key: 'DISMISS',
            label: 'Dismiss',
            actionType: ActionType.KeepOnTop,
            isDangerousOption: true)
      ]);
*/




}




_showNotificationMissedDeclined(RemoteMessage message , String type)  async {


  RemoteNotification? notification = message.notification;

  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {

    var initializationSettingsAndroid =
    new AndroidInitializationSettings("@drawable/kin_removebg");


    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:(details) {
        //navService.pushNamed("/notification");
      },
      onDidReceiveBackgroundNotificationResponse: (details) {
       // navService.pushNamed("/notification");
      },);


    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      type == "missed" ? "Timed Out" : "Call Declined",
      type == "missed" ?  "Your Video has been Timed out!" : "Your Video call has been declined",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',

        ),
      ),
    );



  }

}





/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


Future<void> main() async {

  debugDefaultTargetPlatformOverride = TargetPlatform.android;

  // Set the background messaging handler early on, as a named top-level function
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
   // await setupFlutterNotifications();
  }

  runApp(MyApp());

  initLoader();

}

initLoader(){

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 4000)
    ..loadingStyle = EasyLoadingStyle.custom //This was missing in earlier code
    ..backgroundColor = Colors.pink
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..maskColor = Colors.pink
    ..indicatorType = EasyLoadingIndicatorType.pumpingHeart
    ..dismissOnTap = true
    ..userInteractions = false;

}


class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        Provider<ApiService>(
        create: (_) => ApiService.create(),
          dispose: (_, ApiService service) => service.client.dispose(),
    ),
    ],child:MaterialApp(
      navigatorKey: NavigationService.navigationKey,
        builder: (context, child) {
          final mq = MediaQuery.of(context);

          return MediaQuery(
            data: mq.copyWith(
              textScaleFactor: 1.0,      // FIX: Stops distorted text
              boldText: false,           // Avoid OEM forcing bold fonts
            ),
            child: Directionality(       // FIX: Avoid shaping issues on some phones
              textDirection: TextDirection.ltr,
              child: RepaintBoundary(   // <-- Added RepaintBoundary
                child: child!,
              ),
            ),
          );
        },

        theme: ThemeData(
          useMaterial3: true,
          fontFamily: null,              // Ensure system default is used
        ),

      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => MainScreen());
          case '/intro':
            return Animations().setAnimation(IntroApp());
          case '/login':
            return Animations().setAnimation(LoginApp());
          case '/login_verify':
            return Animations().setAnimation(LoginVerifyApp(mobile_number : settings.arguments as List));
          case '/main_screen':
            return Animations().setAnimation(MainScreenContainer(type: int.parse(settings.arguments.toString())));
          case '/basic_details':
            return Animations().setAnimation(BasicDetails(type : settings.arguments.toString()));
          case '/lifestyle_details':
            return Animations().setAnimation(LifestyleDetails(type : settings.arguments.toString()));
          case '/contact_details':
            return Animations().setAnimation(ContactDetails(type : settings.arguments.toString()));
          case '/education_details':
            return Animations().setAnimation(EducationalDetails(type : settings.arguments.toString()));
          case '/occuaptional_details':
            return Animations().setAnimation(OccupationalDetail(type : settings.arguments.toString()));
          case '/horoscope_details':
            return Animations().setAnimation(HoroscopeDetail(type : settings.arguments.toString()));
          case '/fml_details':
            return Animations().setAnimation(FamilyDetails(type : settings.arguments.toString()));
          case '/fml_member_details':
            return Animations().setAnimation(FamilyMemberDetails(type : settings.arguments.toString()));
          case '/partner_details':
            return Animations().setAnimation(PartnerDetails(type : settings.arguments.toString()));
          case '/img_gallery':
            return Animations().setAnimation(ImageGallery(type : settings.arguments.toString()));
          case '/documents':
            return Animations().setAnimation(DocumentsUpload(type : settings.arguments.toString()));
          case '/user_detail':
            return Animations().setAnimation(UserDetailOther(user: settings.arguments as List,));
          case '/match_profile':
            return Animations().setAnimation(MatchProfile( settings.arguments as List,));
          case '/img_gallery_other':
            return Animations().setAnimation(ImageGalleryOther(settings.arguments as List));
          case '/membership':
            return Animations().setAnimation(Membership());
          case '/settings':
            return Animations().setAnimation(Settings());
          case '/preference_filter':
            return Animations().setAnimation(PreferenceFilter());
          case '/search_result':
            return Animations().setAnimation(SearchResultApp(maps: settings.arguments as List,));
          case '/notification':
            return Animations().setAnimation(NotificationStateful());
          /*case '/videocall':
            return Animations().setAnimation(Call(list: settings.arguments as List,));*/
          case '/main_page':
            return Animations().setAnimation(MyApp());
          case '/dashboard':
            return Animations().setAnimation(DashboardApp());
          case '/profile':
            return Animations().setAnimation(UserDetail());
          case '/search':
            return Animations().setAnimation(FilterScreenApp());
          case '/inbox':
            return Animations().setAnimation(Inbox());
          case '/membership_details':
            return Animations().setAnimation(Features());
          case '/chat_screen':
            return Animations().setAnimation(ChatScreen( settings.arguments as List));
          case '/about_us':
            return Animations().setAnimation(AboutUs());
          case '/contact_us':
            return Animations().setAnimation(ContactUs());
          case '/chief_members':
            return Animations().setAnimation(ChiefMembers());
          case '/faqs':
            return Animations().setAnimation(FaqsScreen());
          case '/privacy_policy':
            return Animations().setAnimation(PrivacyPolicy());
          case '/saved_search':
            return Animations().setAnimation(SavedSearch());
          case '/signup':
            return Animations().setAnimation(Registeration());
          case '/user_detail_other':
            return Animations().setAnimation(UserDetailOtherEdit(settings.arguments as String));
          case '/image_gallery_other_edit':
            return Animations().setAnimation(ImageGalleryEdit(settings.arguments as List));
          case '/basic_details_edit':
            return Animations().setAnimation(BasicDetailsEdit(settings.arguments as List));
          case '/contact_details_edit':
            return Animations().setAnimation(ContactDetailsEdit(settings.arguments as List));
          case '/lifestyle_details_edit':
            return Animations().setAnimation(LifestyleDetailsEdit(settings.arguments as List));
          case '/education_details_edit':
            return Animations().setAnimation(EducationalDetails_Edit(settings.arguments as List));
          case '/occuaptional_details_edit':
            return Animations().setAnimation(OccupationalDetail_Edit(settings.arguments as List));
          case  "/fml_details_edit":
            return Animations().setAnimation(FamilyDetails_Edit(settings.arguments as List));
          case  "/documents_edit":
            return Animations().setAnimation(DocumentsUploadEdit(settings.arguments as List));
          case '/horoscope_details_edit':
            return Animations().setAnimation(HoroscopeDetail_Edit(settings.arguments as List));
          case  "/verifyscreen":
            return Animations().setAnimation(VerifyScreen());
          case  "/verifyimagelist":
            return Animations().setAnimation(VerifyImageListEdit());
          case  "/verifydoclist":
            return Animations().setAnimation(VerifyDocListEdit());
          case  "/hobbies":
            return Animations().setAnimation(HobbyDetails());
          case  "/hobbies_edit":
            return Animations().setAnimation(HobbyDetailsEdit(settings.arguments as List));
          case  "/member_list_trusteeshree":
            return Animations().setAnimation(HtmlWithFilesScreen(settings.arguments as String,));

          default:
            return null;
        }
      },
    ));
  }
}

class MainScreen extends StatefulWidget {

  @override
  MyScreen createState() => MyScreen();

}


class MyScreen extends  State<MainScreen> {

  ///final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

   @override
  void initState() {
    super.initState();

    _checkConnectivity();

    inittranslate();

    //_firebaseMessaging.getToken().then((value) => print(value));

   /* CallKeep.instance.onEvent.listen((event) async {
      // TODO: Implement other events
      if (event == null) return;
      switch (event.type) {
        case CallKeepEventType.callAccept:
          final data = event.data as CallKeepCallData;
          print('call answered: '+data.toMap()["extra"]["channel"]);


          final appId = '4cc65cfab1864d6daeda7dc86d88e7e3';
          final appCertificate = 'be5a217853bd42149218ee5d4aa93da1';
          final channelNameTOMatch = data.toMap()["extra"]["channel"];

          print(channelNameTOMatch);
          String token =VideoCalls().getToken(channelNameTOMatch.toString());

          Future.delayed(const Duration(milliseconds: 500), () {
            navService.pushNamed("/videocall" ,args: [channelNameTOMatch ,token ,appId , "0" , "-1"]);
          });

          break;
        case CallKeepEventType.callDecline:
          final data = event.data as CallKeepCallData;

          VideoCalls().returnMissedorDeclinevideocalls([data.toMap()["extra"]["token"]], "", "", "decline");

          break;
        case CallKeepEventType.missedCallback:
          final data = event.data as CallKeepCallData;

          VideoCalls().returnMissedorDeclinevideocalls([data.toMap()["extra"]["token"]], "", "", "missed");

          break;
        default:
          break;
      }
    });*/




    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print foreground message here.
      //print('Handling a foreground message ${message.messageId}');
      print('Notification Message: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }

      if(message.data["type"] == "interest") {

        showFlutterNotification(message);

      }else if(message.data["type"] == "video"){

        channelname = message.data["channel"];
        //_showNotification();
      //  VideoCalls().displayIncomingCall(message.data["uuid"], message.data["caller"]  , message.data["avatar"] , message.data["channel"] , message.data["mobile"], message.data["token"]);

      }else if(message.data["type"] == "missed"){

        _showNotificationMissedDeclined(message ,"missed");


      }else if(message.data["type"] == "decline"){

        _showNotificationMissedDeclined(message ,"decline");

      }


    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');

    });




    Future.delayed(const Duration(milliseconds: 3500), () {
      navService.pushNamedAndRemoveUntil("/intro");
    });




  }


  inittranslate() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(prefs.getString(SharedPrefs.translate).toString()+"-=-=()()");

    if(prefs.getString(SharedPrefs.translate) == null){

      TranslationService.load("en");

    }else{

      if(prefs.getString(SharedPrefs.translate).toString() == "en"){
        TranslationService.load("en");
      }else if(prefs.getString(SharedPrefs.translate).toString() == "gu"){
        TranslationService.load("gu");
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
      _showNoInternetAlert();
    }
  }

  void _showNoInternetAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Internet Connection"),
          content: Text("Please check your internet connection."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



/*
  Future<void> _onCallAccepted(CallEvent callEvent) async {
    // the call was accepted

    final appId = '4cc65cfab1864d6daeda7dc86d88e7e3';
    final appCertificate = 'be5a217853bd42149218ee5d4aa93da1';
    final channelNameTOMatch = callEvent.userInfo?["channelid"];

    print(channelNameTOMatch);

    String token =VideoCalls().getToken(channelNameTOMatch.toString());

    Future.delayed(const Duration(milliseconds: 500), () {


      navService.pushNamed("/videocall" ,args: [channelNameTOMatch ,token ,appId , "0"]);
      /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Call(
                          channelName: channelNameTOMatch,
                          token: token,
                          appId: appId,
                          uid: "0"
                      ),
                ),
              );*/

    });


  }

  Future<void> _onCallRejected(CallEvent callEvent) async {
    // the call was rejected
  }

  Future<void> _onCallIncoming(CallEvent callEvent) async {
    // the Incoming call screen/notification was shown for user
  }
*/


  onEvent(event) {
    if (!mounted) return;
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(child: Container(color: Colors.pinkAccent ,child:Stack(
        fit: StackFit.expand,
        children: [
          // Background with Opacity
      Positioned(top: 0 , left: (MediaQuery.of(context).size.width*0.5)-MediaQuery.of(context).size.width*0.35  ,child: Container(
             child: Image.asset("assets/images/raval_launcher.png" , width: MediaQuery.of(context).size.width*0.7,
               height: MediaQuery.of(context).size.height*0.7, fit: BoxFit.scaleDown,),
          ),),

          Positioned(
            top: MediaQuery.of(context).size.height*0.1,
            child:Opacity(opacity: 0.65   ,child: Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: Text(
                'Ravaldev Matrimonial', textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Barboque', fontSize: 20, color: Colors.white ),),
            ),
          ),),
          // Heart Image at the Bottom
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.38,
              child: Image.asset(
                'assets/images/heart.png', // Replace with your heart image
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width*0.35,
            bottom: MediaQuery.of(context).size.width*0.3,
            child: Column(

              children: <Widget>[

                Container(child:Text('WELCOME TO' ,textAlign: TextAlign.center  ,style:TextStyle(fontSize: 12 ,)),),
                Container(margin: EdgeInsets.only(top: 5) ,child:Image.asset("assets/images/doubleheart.png" , width: 60, height: 60,),),
                Container(margin: EdgeInsets.only(top: 5) , child:Text('FIND YOUR' ,textAlign: TextAlign.center  ,style:TextStyle(fontSize: 14 ,)),),
                Container(margin: EdgeInsets.only(top: 5) , child:Text('LIFE PARTNER' ,textAlign: TextAlign.center  ,style:TextStyle(fontSize: 17 , fontWeight: FontWeight.bold)),),


              ],

            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.width*0.35,
            left: 30,
            child: Container(
              height: 70,
              child: Image.asset(
                'assets/images/balloons.png', // Replace with your heart image
                width: 40,
                height: 40,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.width*0.45,
            right: 30,
            child: Container(
              height: 70,
              child: Image.asset(
                'assets/images/balloons.png', // Replace with your heart image
                width: 60,
                height: 60,
              ),
            ),
          ),
        ],
      ),
    )));

  }


}
