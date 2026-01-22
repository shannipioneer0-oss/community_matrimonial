import 'dart:convert';
import 'dart:math';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/model/privacy_settings.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/settings/settings.dart';
import 'package:community_matrimonial/screens/user_profile/CustomDropdown.dart';
import 'package:community_matrimonial/screens/user_profile/NumericFields.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../filter/dropdown.dart';



class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SettingsScreen(),
      ),
    );
  }

}







class SettingsScreen extends StatefulWidget {

  @override
  SettingsState createState() => SettingsState();

}


class Options{

   String label;
   String value;

   Options(this.label , this.value);

}


class SettingsState extends State<SettingsScreen> {


  String selectedOption = "";
  static const headerStyle = TextStyle(color: Color(0xffffffff) , fontSize: 18 , fontWeight: FontWeight.bold);

  String phone_privacy = "" , photo_privacy = "" , horoscope_privacy = "" , settings_id = "";

  List<Options> list_phone_privacy = [];
  List<Options> list_photo_privacy = [];
  List<Options> list_horoscope_privacy = [];

  final Connectivity _connectivity = Connectivity();
  late Stream<ConnectivityResult> _connectionStream;
  String randomotp = "";

  @override
  void initState() {
    super.initState();

    final random = Random();
    const digits = '0123456789';
    randomotp = List.generate(6 , (index) => digits[random.nextInt(digits.length)]).join();

    _connectionStream = _connectivity.onConnectivityChanged as Stream<ConnectivityResult>;
    _connectionStream.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");
      }
    });

    setState(() {

      list_phone_privacy.add(Options( "Phone number to Premium users only.(Recommended)" , "1"));
      list_phone_privacy.add(Options("Phone number accessible to Premium users only" , "2"));

      list_photo_privacy.add(Options( "Photos accessible to All the users." , "1"));
      list_photo_privacy.add(Options("Photos accessible to Premium users only." , "2"));

      list_horoscope_privacy.add(Options( "Horoscope accessible to Premium users only.(Recommended)" , "1"));
      list_horoscope_privacy.add(Options("Horoscope accessible to users allowed by me." , "2"));

    });

    initSetttings();

  }

  List data = [];
  initSetttings() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(
        context, listen: false).postFetchPrivacySettings({"userId":prefs.getString(SharedPrefs.userId)});

    data = _response.body["data"];

    setState(() {

      if(data.length > 0) {

        settings_id = _response.body["data"][0]["Id"].toString();
        phone_privacy = _response.body["data"][0]["phone_privacy"];
        photo_privacy = _response.body["data"][0]["photo_privacy"];
        horoscope_privacy = _response.body["data"][0]["horoscope_privacy"];

      }

    });


  }

  String hide_days = "0";

  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(
        title: Text('Settings\nRavaldev Matrimony' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
        toolbarOpacity: 1,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
          onPressed: () {

            navService.goBack();

          },
        )),
    body: SafeArea(child: SingleChildScrollView(child:Container( constraints: BoxConstraints(maxHeight: double.infinity)   , child:Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    /*Padding(
    padding: const EdgeInsets.all(10.0),
    child: Text(
    'Phone Privacy Settings',
    style: TextStyle(
    fontSize: 18.0,
    color: Colors.pink,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),

    StylishRadio(option: list_phone_privacy, isSelected: true , onChanged: (value) {

      setState(() {
        phone_privacy = value;
      });


    }, option_str: phone_privacy, ),


    Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
    'Photo Privacy Settings',
    style: TextStyle(
    fontSize: 18.0,
    color: Colors.pink,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
      StylishRadio(option: list_photo_privacy, isSelected: true, onChanged: (value) {


        setState(() {
          photo_privacy = value;
        });


      }, option_str: photo_privacy),

    Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
    'Horoscope Privacy Settings',
    style: TextStyle(
    fontSize: 18.0,
    color: Colors.pink,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    StylishRadio(option: list_horoscope_privacy , isSelected: true , onChanged: (String value){


      setState(() {
        horoscope_privacy = value;
      });


    }, option_str: horoscope_privacy,),


      Container(alignment: Alignment.bottomCenter , width: MediaQuery.of(context).size.width , margin: EdgeInsets.only(top: 10)  ,child:ElevatedButton(
        onPressed: () async {


          if(phone_privacy == "" || photo_privacy == "" || horoscope_privacy == "") {
            DialogClass().showDialog2(context, "Privacy Settings"  ,"Select All Privacy Setttings", "Ok");
          }else{
            Dialogs.materialDialog(
                msg: "Are you sure you want to submit settings",
                title: "Settings Alert!",
                color: Colors.white,
                context: context,
                onClose: (value) => print("returned value is '$value'"),
                actions: [
                  IconsOutlineButton(
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();



                      if (data.length == 0) {

                        SharedPreferences prefs = await SharedPreferences
                            .getInstance();
                        print({
                          "phone_privacy": phone_privacy,
                          "photo_privacy": photo_privacy,
                          "horoscope_privacy": horoscope_privacy,
                          "userId": prefs.getString(SharedPrefs.userId),
                          "communityId": prefs.getString(SharedPrefs.communityId),
                          "profileId": prefs.getString(SharedPrefs.profileid)
                        });


                        final _response = await Provider.of<ApiService>(
                            context, listen: false).postInsertSettings({
                          "phone_privacy": phone_privacy,
                          "photo_privacy": photo_privacy,
                          "horoscope_privacy": horoscope_privacy,
                          "userId": prefs.getString(SharedPrefs.userId),
                          "communityId": prefs.getString(SharedPrefs.communityId),
                          "profileId": prefs.getString(SharedPrefs.profileid)
                        });




                      } else {

                        SharedPreferences prefs = await SharedPreferences
                            .getInstance();
                        final _response = await Provider.of<ApiService>(
                            context, listen: false).postUpdateSettings({
                          "phone_privacy": phone_privacy,
                          "photo_privacy": photo_privacy,
                          "horoscope_privacy": horoscope_privacy,
                          "Id": settings_id,
                        });

                      }

                    },
                    text: "Submit",
                    iconData: Icons.info,
                    textStyle: TextStyle(color: Colors.green),
                    iconColor: Colors.green,
                  ),


                  IconsOutlineButton(
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    text: "Cancel",
                    iconData: Icons.cancel,
                    textStyle: TextStyle(color: Colors.red),
                    iconColor: Colors.red,
                  ),


                ]);
          }




        },
        style: ElevatedButton.styleFrom(

          backgroundColor: ColorsPallete.Pink2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:Container(width: MediaQuery.of(context).size.width*0.7 ,child: Text(
            'Submit Privacy Settings',textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18 ,color: Colors.white),
          ),
          ),),
      ),),
*/

    Container(margin: EdgeInsets.only(left: 15 ,right: 15)  ,child:Accordion(
          headerBorderColor: Colors.blueGrey,
          headerBorderColorOpened: Colors.transparent,
          headerBackgroundColorOpened: Colors.pink,
          headerBackgroundColor: ColorsPallete.blue_2,
          contentBackgroundColor: Colors.white,
          contentBorderColor: ColorsPallete.Pink,
          contentBorderWidth: 3,
          contentHorizontalPadding: 20,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          maxOpenSections: 8,
          disableScrolling: true,
          headerPadding:
          const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: false,
              leftIcon:  GestureDetector(onTap: ()  {


              }  ,child:Icon(Icons.edit, color: Colors.white),),
              header:  Text(TranslationService.translate("Language"), style: headerStyle),
              contentHorizontalPadding: 10,
              contentVerticalPadding: 10,
              content: Container(child:Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                GestureDetector(onTap: () async {

                     SharedPreferences prefs = await SharedPreferences.getInstance();
                     prefs.setString(SharedPrefs.translate, "en");


                     await TranslationService.load('en');

                     DialogClass().showDialog2(context, "Translate Alert!", "Translated to English", "Ok");


                   }  ,child:Text(
                TranslationService.translate('Translate to English'),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: ColorsPallete.blue_2,
                      ),
                    ),),
                SizedBox(height: 10,),



                GestureDetector(onTap: () async {

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString(SharedPrefs.translate, "gu");

                  await TranslationService.load('gu');

                  DialogClass().showDialog2(context, "Translate Alert!", "Translated to Gujarati", "Ok");


                }  ,child:Text(
                  TranslationService.translate('Translate to Gujarati'),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: ColorsPallete.blue_2,
                      ),
                    ),),
                SizedBox(height: 10,),



                  ],
                ),
              ),),
            ),]),),

      Container(margin: EdgeInsets.only(left: 15 ,right: 15)  ,child:Accordion(
          headerBorderColor: Colors.blueGrey,
          headerBorderColorOpened: Colors.transparent,
          headerBackgroundColorOpened: Colors.pink,
          headerBackgroundColor: ColorsPallete.blue_2,
          contentBackgroundColor: Colors.white,
          contentBorderColor: ColorsPallete.Pink,
          contentBorderWidth: 3,
          contentHorizontalPadding: 20,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          maxOpenSections: 8,
          disableScrolling: true,
          headerPadding:
          const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: false,
              leftIcon:  GestureDetector(onTap: ()  {


              }  ,child:Icon(Icons.edit, color: Colors.white),),
              header:  Text(TranslationService.translate('About Us'), style: headerStyle),
              contentHorizontalPadding: 10,
              contentVerticalPadding:5,
              content: Container(child:Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    GestureDetector(onTap: () async {

                      navService.pushNamed("/about_us");

                    }  ,child:Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: ColorsPallete.blue_2,
                        decoration: TextDecoration.underline,
                      ),
                    ),),
                    SizedBox(height: 15,),

                    GestureDetector(onTap: () async {

                      navService.pushNamed("/contact_us");


                    }  , child:Text(
                      TranslationService.translate('Contact Us'),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: ColorsPallete.blue_2,
                        decoration: TextDecoration.underline,
                      ),
                    ),),
                    SizedBox(height: 15,),

                    GestureDetector(onTap: () async {

                      navService.pushNamed("/chief_members");


                    }  ,child:Text(
                      TranslationService.translate('Committee Members'),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: ColorsPallete.blue_2,
                        decoration: TextDecoration.underline,
                      ),
                    ),),
                    SizedBox(height: 15,),

                    GestureDetector(onTap: () async {

                      navService.pushNamed("/faqs");

                    }  ,child:Text(
                      TranslationService.translate('Faqs'),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: ColorsPallete.blue_2,
                        decoration: TextDecoration.underline,
                      ),
                    ),),
                    SizedBox(height: 15,),


                    GestureDetector(onTap: () async {

                      navService.pushNamed("/privacy_policy");

                    }  ,child:Text(
                      TranslationService.translate('Privacy Policy'),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: ColorsPallete.blue_2,
                        decoration: TextDecoration.underline,
                      ),
                    ),),
                    SizedBox(height: 10,),





                  ],
                ),
              ),),
            ),]),),

    Container(alignment: Alignment.bottomCenter , width: MediaQuery.of(context).size.width , margin: EdgeInsets.only()  ,child:ElevatedButton(
    onPressed: () {

      TextEditingController controller  =new TextEditingController();
      TextEditingController controllerPassword  =new TextEditingController();

      Dialogs.materialDialog(
          color: Colors.white,
          msg: 'Are you sure you want to delete this account? ',
          title: 'Delete Account Alert!',
          customView: Container( padding: EdgeInsets.all(10) ,child:Column( crossAxisAlignment: CrossAxisAlignment.start ,children: [
            SizedBox(height: 20,),
            Text("Enter reason to delete") ,
            Container(child: TextField(controller: controller, ),),

            SizedBox(height: 20,),

            Text("Enter "+randomotp+" below to delete") ,
            Container(child: TextField(controller: controllerPassword, ),),
          ],),),
          customViewPosition: CustomViewPosition.BEFORE_ACTION,
          context: context,
          actions: [
            IconsButton(
              onPressed: () async {


                if(controllerPassword.text.toString() ==  randomotp) {

                  Navigator.of(context, rootNavigator: true).pop();

                  SharedPreferences prefs = await SharedPreferences
                      .getInstance();

                  final _response = await Provider.of<ApiService>(
                      context , listen: false).postDeleteAccount({
                    "delete_account_reason": controller.text.toString(),
                    "userId": prefs.getString(SharedPrefs.userId)
                  });

                  print(_response.body);

                  if(_response.body["success"].toString() == "1"){


                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove(SharedPrefs.isLogin);
                    prefs.clear();

                    navService.pushNamed("/intro");

                    showDialog(context: context, builder: (context) {

                      return AlertDialog(
                        content: Text("Account Deleted Successfully"),
                        actions: [ GestureDetector( onTap: (){

                          Navigator.of(context).pop();

                        } ,child: Text("Ok"),) ],);

                    },);

                  }else{



                  }


                }else{

                  showDialog(context: context, builder: (context) {

                    return AlertDialog(
                      content: Text("Enter "+randomotp+" properly to delete."),
                      actions: [ GestureDetector( onTap: (){

                        Navigator.of(context).pop();

                      } ,child: Text("Ok"),) ],);

                  },);


                }



              },
              text: 'Delete',
              iconData: Icons.done,
              color: Colors.blue,
              textStyle: TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
            IconsButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              text: 'Cancel',
              iconData: Icons.cancel,
              color: Colors.white,
              textStyle: TextStyle(color: Colors.red),
              iconColor: Colors.red,
            )

          ]);



    },
    style: ElevatedButton.styleFrom(

    backgroundColor: ColorsPallete.Pink,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
    ),
    ),
    child: Padding(
    padding: const EdgeInsets.all(10.0),
    child:Container(width: MediaQuery.of(context).size.width*0.7 ,child: Text(
      TranslationService.translate('Delete Profile'), textAlign: TextAlign.center,
    style: TextStyle(fontSize: 18 , color: Colors.white),
    ),
    ),),
    ),),
SizedBox(height: 20,),
      Container(alignment: Alignment.bottomCenter , width: MediaQuery.of(context).size.width , margin: EdgeInsets.only()  ,child:ElevatedButton(
        onPressed: () {

          TextEditingController controller  =new TextEditingController();
          TextEditingController controllerDays  =new TextEditingController();
          TextEditingController controllerPassword  =new TextEditingController();

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              return SafeArea(child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),

                      Text(
                        "Hide Account",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 8),
                      Text("Are you sure you want to Hide Account Temporarily"),

                      SizedBox(height: 20),

                      Text("Enter reason to hide"),
                      TextField(controller: controller),

                      SizedBox(height: 20),

                      NumericTextField(
                        icondata: MdiIcons.eyeOff,
                        controller: controllerDays,
                        labelText: "Enter No. of Days To Hide",
                        enabled: false,
                      ),

                      SizedBox(height: 20),

                      Text("Enter $randomotp below to hide"),
                      TextField(controller: controllerPassword),

                      SizedBox(height: 30),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Hide"),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("CANCEL"),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ));
            },
          );










        },
        style: ElevatedButton.styleFrom(

          backgroundColor: ColorsPallete.Pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:Container(width: MediaQuery.of(context).size.width*0.7 ,child: Text(
            TranslationService.translate('Hide Profile'), textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18 , color: Colors.white),
          ),
          ),),
      ),),

    Container(alignment: Alignment.bottomCenter , width: MediaQuery.of(context).size.width , margin: EdgeInsets.only(top: 10)  ,child:ElevatedButton(
        onPressed: () async {

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove(SharedPrefs.isLogin);
          prefs.clear();

          navService.pushNamedAndRemoveUntil("/intro");

        },
        style: ElevatedButton.styleFrom(

          backgroundColor: ColorsPallete.Pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:Container(width: MediaQuery.of(context).size.width*0.7 ,child: Text(
            TranslationService.translate('Logout') ,textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18 , color: Colors.white),
          ),
          ),),
      ),),

    ],
    )
    ))));

  }

}








class StylishRadio extends StatefulWidget {
  final List<Options> option;
  final bool isSelected;
  final ValueChanged<String> onChanged;
  final String option_str;

  StylishRadio({
    Key? key,
    required this.option,
    required this.isSelected,
    required this.onChanged,
    required this.option_str
  }) : super(key: key);

  @override
  _StylishRadioState createState() => _StylishRadioState();

}



class _StylishRadioState extends State<StylishRadio> {


  String selectedOption = "";

  @override
  Widget build(BuildContext context) {

   return Container( height: 140 , child:Column(

     children: widget.option.map((option) {

       return RadioListTile(
         title: Text(option.label),
         value: option.value,
         groupValue: widget.option_str,
         onChanged: (value) {

           setState(() {

             selectedOption = value!;
             widget.onChanged((option.value).toString());

           });

         },
       );

     }).toList(),

    ));

  }


}