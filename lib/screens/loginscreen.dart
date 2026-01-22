import 'dart:ui';
import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/RichTextFieldWithIndividualOnTap.dart';
import 'package:community_matrimonial/app_utils/StylishDrawer.dart';
import 'package:community_matrimonial/app_utils/TextFieldWithImage.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/ImageOverlayPainter.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../network_utils/service/api_service.dart';



class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginAppStateful(),
    );
  }
}


class LoginAppStateful extends StatefulWidget {

  @override
  LoginScreen createState() => LoginScreen();

}


class LoginScreen extends State<LoginAppStateful> {

  TextEditingController controllermobilenumber = new TextEditingController();
  TextEditingController controlleremail = new TextEditingController();

  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  int dismiss = 0;
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
  String token = "";


   @override
  void initState() {
    super.initState();

    /*_firebaseMessaging.getToken().then((value) {
      token = value!;
    });*/

  }

  int count = 0;



  @override
  Widget build(BuildContext context) {

      return Scaffold(

         body:SingleChildScrollView(

             child:Container(color: Colors.white , height: MediaQuery.of(context).size.height  ,child:Stack(
           fit: StackFit.expand,
           alignment: Alignment.topCenter,
           children: [
           // Background Image
           GestureDetector(onTap: () async {


             count++;

             if(count == 2){

               DialogClass().showCustomProgressDialog(context);

               final flavor = FlavorConfig.instance.name;
               String communityId = flavor == "appA" ? "20" : "2";

               final _response = await Provider.of<ApiService>(context, listen: false).postSendOtpSms(
                   {
                     "mobile": controllermobilenumber.text.toString(),
                     "communityId":communityId
                   }
               );

               if(_response.body != null) {

                 if (_response.body["data"] != "not_exists") {

                   SharedPreferences prefs = await SharedPreferences.getInstance();

                   await prefs.setString(SharedPrefs.userId, _response.body["data"][0]["Id"].toString());
                   await prefs.setString(
                       SharedPrefs.firstName, _response.body["data"][0]["name"]);
                   await prefs.setString(SharedPrefs.lastname,
                       _response.body["data"][0]["surname"]);
                   await prefs.setString(SharedPrefs.emailid,
                       _response.body["data"][0]["emailid"]);
                   await prefs.setString(
                       SharedPrefs.mobile, _response.body["data"][0]["mobile"]);
                   await prefs.setString(
                       SharedPrefs.gender, _response.body["data"][0]["gender"]);
                   await prefs.setString(SharedPrefs.birthdate,
                       _response.body["data"][0]["birthdate"]);
                   await prefs.setString(SharedPrefs.communityId,
                       _response.body["data"][0]["community_id"]);
                   await prefs.setString(SharedPrefs.communityName,
                       _response.body["data"][0]["community_name"]);
                   await prefs.setString(SharedPrefs.user_verify,
                       _response.body["data"][0]["user_verify"]);
                   await prefs.setString(SharedPrefs.mobile_verify,
                       _response.body["data"][0]["mobile_verify"]);
                   await prefs.setString(SharedPrefs.email_verify,
                       _response.body["data"][0]["email_verify"]);
                   await prefs.setString(SharedPrefs.profileid,
                       _response.body["data"][0]["profile_id"]);
                   await prefs.setString(SharedPrefs.joined_date,
                       _response.body["data"][0]["joined_date"]);
                   await prefs.setString(SharedPrefs.mobile_reg_token,
                       _response.body["data"][0]["mobile_reg_token"]);
                   await prefs.setString(SharedPrefs.delete_account,
                       _response.body["data"][0]["delete_account"]);
                   await prefs.setString(SharedPrefs.role_type,
                       _response.body["data"][0]["role"] ??  "");

                   print("sample");

                   if(_response.body["data"][0]["delete_account"].toString() == "0"){

                     final flavor = FlavorConfig.instance.name;
                     String communityId = flavor == "appA" ? "20" : "2";

                     print(communityId+"------"+_response.body["data"][0]["community_id"]+"-----"+flavor.toString());

                     if(_response.body["data"][0]["community_id"] == communityId) {

                       Navigator.of(context , rootNavigator: true).pop();
                       navService.pushNamed("/login_verify",
                           args: [controllermobilenumber.text.toString(), "0"]);

                     }else{


                       Navigator.of(context , rootNavigator: true).pop();
                       DialogClass().showDialog2(context, "Mobile Number Alert!",
                           "No Such Mobile Number Exists in our Record", "Ok");


                     }

                   }else{

                     Navigator.of(context, rootNavigator: true).pop();
                     showDialog(context: context, builder: (context) {

                       return AlertDialog(
                         content: Text("Sorry you can't login! your account is deleted. Contact support for any query."),
                         actions: [ GestureDetector( onTap: (){

                           Navigator.of(context).pop();

                         } ,child: Text("Ok"  , style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20 , color: Colors.purple),),) ],);

                     },);

                   }



                 } else {

                   Navigator.of(context, rootNavigator: true).pop();
                   DialogClass().showDialog2(context , "Mobile Number Alert!" ,
                       "No Such Mobile Number Exists in our Record" , "Ok");

                 }

               }else{

                 Navigator.of(context, rootNavigator: true).pop();

               }


             }




           }  ,child: Image.asset(
           'assets/images/image_top_edit_two.png',
           height: MediaQuery.of(context).size.height*0.4,
           fit: BoxFit.contain,
           alignment: Alignment.topCenter,
         ),),

        Positioned(top: MediaQuery.of(context).size.height*0.4 , left:MediaQuery.of(context).size.width*0.17 ,child: Text("LOGIN" , style: TextStyle(color: Colors.pink , fontSize:18 , fontWeight: FontWeight.w700 ),)),
             Positioned(top: MediaQuery.of(context).size.height*0.36 , left:MediaQuery.of(context).size.width*0.65 ,child: Image.asset("assets/images/heart.png" , width: 45 , height: 45, color: Colors.pink,),),

        Positioned(
            top: MediaQuery.of(context).size.height*0.5,

            child: Column(

          children: [

            TextFieldWithImage(
              hintText: TranslationService.translate("mobile_hint"),
              icon: Icons.call,
              textInputtype: TextInputType.number,
              controller: controllermobilenumber,// Replace with your desired icon
            ),

            Visibility(visible: false  ,child: TextFieldWithImage(
              hintText: TranslationService.translate("password_hint"),
              icon: Icons.password,
              textInputtype: TextInputType.visiblePassword,// Replace with your desired icon
              controller: controlleremail,
            ),),

             Visibility(visible: false  ,child:Container(
              width: MediaQuery.of(context).size.width*0.9,
              margin: EdgeInsets.only(right: 15 , bottom: 25),
              child: Text(TranslationService.translate("forgot_password") , textAlign: TextAlign.end , style: TextStyle(color:ColorsPallete.greyColor),),
            ),),

            GestureDetector(onTap:() async {


             DialogClass().showCustomProgressDialog(context);

             final flavor = FlavorConfig.instance.name;

             print(flavor.toString()+"===---===--===");
             String communityId = flavor == "appA" ? "20" : "2";

             //DialogClass().showDialog2(context, flavor.toString() , flavor.toString() , "OK");

              final _response = await Provider.of<ApiService>(context, listen: false).postSendOtpSms(
                  {
                    "mobile": controllermobilenumber.text.toString(),
                    "communityId":communityId
                  }
              );

              if(_response.body != null) {

                if (_response.body["data"] != "not_exists") {

                  SharedPreferences prefs = await SharedPreferences.getInstance();

                  await prefs.setString(SharedPrefs.userId, _response.body["data"][0]["Id"].toString());
                  await prefs.setString(
                      SharedPrefs.firstName, _response.body["data"][0]["name"]);
                  await prefs.setString(SharedPrefs.lastname,
                      _response.body["data"][0]["surname"]);
                  await prefs.setString(SharedPrefs.emailid,
                      _response.body["data"][0]["emailid"]);
                  await prefs.setString(
                      SharedPrefs.mobile, _response.body["data"][0]["mobile"]);
                  await prefs.setString(
                      SharedPrefs.gender, _response.body["data"][0]["gender"]);
                  await prefs.setString(SharedPrefs.birthdate,
                      _response.body["data"][0]["birthdate"]);
                  await prefs.setString(SharedPrefs.communityId,
                      _response.body["data"][0]["community_id"]);
                  await prefs.setString(SharedPrefs.communityName,
                      _response.body["data"][0]["community_name"]);
                  await prefs.setString(SharedPrefs.user_verify,
                      _response.body["data"][0]["user_verify"]);
                  await prefs.setString(SharedPrefs.mobile_verify,
                      _response.body["data"][0]["mobile_verify"]);
                  await prefs.setString(SharedPrefs.email_verify,
                      _response.body["data"][0]["email_verify"]);
                  await prefs.setString(SharedPrefs.profileid,
                      _response.body["data"][0]["profile_id"]);
                  await prefs.setString(SharedPrefs.joined_date,
                      _response.body["data"][0]["joined_date"]);
                  await prefs.setString(SharedPrefs.mobile_reg_token,
                      _response.body["data"][0]["mobile_reg_token"]);
                  await prefs.setString(SharedPrefs.delete_account,
                      _response.body["data"][0]["delete_account"]);
                  await prefs.setString(SharedPrefs.role_type,
                      _response.body["data"][0]["role"] ??  "");

                  print("sample");

                  if(_response.body["data"][0]["delete_account"].toString() == "0"){

                    final flavor = FlavorConfig.instance.name;
                    String communityId = flavor == "appA" ? "20" : "2";

                    print(communityId+"------"+_response.body["data"][0]["community_id"]+"-----"+flavor.toString());

                    if(_response.body["data"][0]["community_id"] == communityId) {

                      Navigator.of(context , rootNavigator: true).pop();
                      navService.pushNamed("/login_verify",
                          args: [controllermobilenumber.text.toString(), "1"]);

                    }else{


                      Navigator.of(context , rootNavigator: true).pop();
                      DialogClass().showDialog2(context, "Mobile Number Alert!",
                          "No Such Mobile Number Exists in our Record", "Ok");


                    }

                  }else{

                    Navigator.of(context, rootNavigator: true).pop();
                    showDialog(context: context, builder: (context) {

                      return AlertDialog(
                        content: Text("Sorry you can't login! your account is deleted. Contact support for any query."),
                        actions: [ GestureDetector( onTap: (){

                          Navigator.of(context).pop();

                        } ,child: Text("Ok"  , style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20 , color: Colors.purple),),) ],);

                    },);

                  }



                } else {

                  Navigator.of(context, rootNavigator: true).pop();
                  DialogClass().showDialog2(context , "Mobile Number Alert!" ,
                      "No Such Mobile Number Exists in our Record" , "Ok");

                }

              }else{

                Navigator.of(context, rootNavigator: true).pop();

              }



            },child:RoundedContainer(text: TranslationService.translate("login_now"), color: Colors.pink),),

            Container(margin: EdgeInsets.only(top: 15) ,child:RichTextWithIndividualOnTap()),

             Visibility(visible: false  ,child:Container(width: MediaQuery.of(context).size.width*0.4   ,margin: EdgeInsets.only(top: 25)   ,child:RoundedContainerWithImage(text: TranslationService.translate("login_google"), color: Colors.pink, image: 'assets/images/heart.png', textimage: 'G', )),)

          ],


        )),


        // Overlay Image on Non-White Portion
      ]

         ))









      ));


  }






}











