
import 'dart:convert';

import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/Values.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/filter/StylishCheckbox.dart';
import 'package:community_matrimonial/screens/user_profile/ButtonSubmit.dart';
import 'package:community_matrimonial/screens/user_profile/CustomDropdown.dart';
import 'package:community_matrimonial/screens/user_profile/CustomTextField.dart';
import 'package:community_matrimonial/utils/Designs.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:community_matrimonial/utils/validation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_utils/SingleSelectDialog.dart';
import 'package:http/http.dart' as http;


class HoroscopeDetail_Edit extends StatelessWidget {

  final List list;
  HoroscopeDetail_Edit(this.list);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HoroscopeDetailStateful(list),
      builder: EasyLoading.init(),
    );
  }
}


class HoroscopeDetailStateful extends StatefulWidget {

  final List list;
  HoroscopeDetailStateful(this.list);

  @override
  HoroscopeDetailScreen createState() => HoroscopeDetailScreen();

}

class HoroscopeDetailScreen  extends State<HoroscopeDetailStateful> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController  rashiController = new TextEditingController();
  TextEditingController birthstarController = new TextEditingController();
  TextEditingController  gotraController = new TextEditingController();
  TextEditingController birthdateController = new TextEditingController();
  TextEditingController birthcityController = new TextEditingController();
  TextEditingController birthtimeController = new TextEditingController();

  bool ismangalik = false , believe_horoscope = false;
  String rashi = "" ,birth_star = "" , gotra= "" , birth_date = "" , birth_city = "", birth_time = "";
  String ismangalik_value = "", believe_in_horoscope    = "";
  String location_value = "" , timezone = "";

  late ConnectivityResult _connectivityResult;

  @override
  void initState() {
    super.initState();

    initValues();

  }

  initValues() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    rashiController.text =  widget.list[0];
    birthstarController.text =   widget.list[1];
    gotraController.text =   widget.list[2];
    birthdateController.text =  widget.list[3];
    birthcityController.text =   widget.list[4];
    birthtimeController.text  =   widget.list[5];

    setState(() {

      ismangalik =   widget.list[6] == "Yes" ? true : false;
      believe_horoscope =   widget.list[7] == "Yes" ? true : false;

    });

    rashi =  widget.list[8];
    birth_star = widget.list[9];
    birth_date = widget.list[3];
    birth_time = widget.list[4];
    birth_city = widget.list[5];

    ismangalik_value =   ismangalik == true ? "1" : "0";
    believe_in_horoscope = believe_horoscope == true ? "Yes" : "No";

   // timezone = prefs.getString(SharedPrefs.timezone).toString();
   // location_value = prefs.getString(SharedPrefs.locationCoordinates).toString();

  }


  final TextEditingController _textEditingController = TextEditingController();

  void _showTextFieldPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Area & City'),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: "Enter Area name followed by city",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Handle the entered text
                String enteredText = _textEditingController.text;
                List<Location> locations = await locationFromAddress(enteredText);

                 String location  = locations[0].latitude.toString()+","+locations[0].longitude.toString();

                final response = await http.get(Uri.parse("https://api.wheretheiss.at/v1/coordinates/"+locations[0].latitude.toString()+","+locations[0].longitude.toString()));

                String time_zone = "";
                if(response != null) {
                    time_zone = jsonDecode(response.body)["offset"].toString();
                }

                setState(() {

                  location_value =  location;
                  timezone = time_zone;

                });

                print(location_value+"------"+timezone);


                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,
        appBar: AppBar(
            title: Text('Horoscope Details',
              style: TextStyle(color: Colors.black87, fontSize: 18),),
            toolbarOpacity: 1,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Image.asset(
                "assets/images/back.png", width: 50, height: 40,),
              onPressed: () {

                navService.goBack();

              },
            )),


        body: SafeArea(child: SingleChildScrollView(child: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(children: [

            Divider(),
            Container(margin: EdgeInsets.only(top: 10) ,child:CustomDropdown(icondata: MdiIcons.starBox  ,controller:rashiController  , labelText: TranslationService.translate("rashi"), onButtonPressed: () async {

              final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "rashi" , "") , "Select Rashi");
              rashiController.text = value.label;
              rashi = value.value;

            },),),
            SizedBox(height: 20,),
            CustomDropdown(icondata: MdiIcons.starBox  ,controller:birthstarController  , labelText: TranslationService.translate("birth_star"), onButtonPressed: () async {

              final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "birth_star" , "") , "Select Birth Star");
              birthstarController.text = value.label;
              birth_star = value.value;

            },),
            SizedBox(height: 20,),
            CustomTextField(icondata: Icons.person , controller: gotraController , labelText: TranslationService.translate("gotra"), enabled: false,),
            SizedBox(height: 20,),
            GestureDetector(onTap: () async {

             final date =   await showDatePickerDialog(
                  context: context,
                  initialDate: DateTime(2022, 10, 10),
                  minDate: DateTime(1955, 10, 10),
                  maxDate: DateTime(2024, 10, 30),
                  currentDate: DateTime(2022, 10, 15),
                  selectedDate: DateTime(2022, 10, 16),
                  currentDateDecoration: const BoxDecoration(),
                  currentDateTextStyle: const TextStyle(),
                  daysOfTheWeekTextStyle: const TextStyle(),
                  disabledCellsDecoration: const BoxDecoration(),
                  disabledCellsTextStyle: const TextStyle(),
                  enabledCellsDecoration: const BoxDecoration(),
                  enabledCellsTextStyle: const TextStyle(),
                  initialPickerType: PickerType.days,
                  selectedCellDecoration: const BoxDecoration(),
                  selectedCellTextStyle: const TextStyle(),
                  leadingDateTextStyle: const TextStyle(),
                  slidersColor: Colors.lightBlue,
                  highlightColor: Colors.redAccent,
                  slidersSize: 20,
                  splashColor: Colors.lightBlueAccent,
                  splashRadius: 40,
                  centerLeadingDate: true,
                );

                if(date != null) {

                  String day = "" , month = "";

                  if(date.day.toString().length < 2){
                    day = "0"+date.day.toString();
                  }else{
                    day = date.day.toString();
                  }

                  if(date.month.toString().length < 2){
                    month = "0"+date.month.toString();
                  }else{
                    month = date.month.toString();
                  }

                  birthdateController.text =
                      day + "/" + month + "/" + date.year.toString();
                }

              }  ,child:CustomTextField(icondata: Icons.date_range_sharp ,controller: birthdateController , labelText: TranslationService.translate("birth_date"), enabled: true,),),
              SizedBox(height: 20,),
              CustomTextField(icondata: Icons.location_city , controller: birthcityController , labelText: Strings.birth_city, enabled: false,),
              SizedBox(height: 20,),
            GestureDetector(onTap: () async {

             final time =    await showTimePicker(context: context, initialTime: TimeOfDay(hour: 12, minute: 00));
             birthtimeController.text = time!.hour.toString()+":"+time!.minute.toString()+":"+"00";


              }  ,child:CustomTextField(icondata: Icons.timelapse ,controller: birthtimeController , labelText: TranslationService.translate("birth_time"), enabled: true,),),
             SizedBox(height: 20,),
              Row(
                children: [
                  StylishCheckbox(
                    value: ismangalik,
                    onChanged: (bool value) {
                      setState(() {
                        ismangalik = value;
                      });
                    },
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    TranslationService.translate("is_mangalik"),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  StylishCheckbox(
                    value: believe_horoscope,
                    onChanged: (bool value) {
                      setState(() {
                        believe_horoscope = value;
                      });
                    },
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    TranslationService.translate("believe_in_horoscope"),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              ButtonSubmit(text:"Get Birth Place Location", onButtonPressed: (){


                  _showTextFieldPopup(context);


              }),
              SizedBox(height: 10.0),
              Text("TimeZone : "+timezone , textAlign: TextAlign.left,),
              SizedBox(height: 10.0),
              Text("Location Co-ordinates : "+location_value , textAlign: TextAlign.left,),
              SizedBox(height: 20,),
              ButtonSubmit(text: 'Submit Horoscopic Details', onButtonPressed: () async {

   ConnectivityResult result = await Connectivity().checkConnectivity();
            setState(() {
              _connectivityResult = result;
            });
    if (_connectivityResult == ConnectivityResult.none) {
    DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");
    }else {
      String astroRashiError = Validation.validateNotEmpty(
          rashiController.text, 'Astro Rashi');
      String birthStarError = Validation.validateNotEmpty(
          birthstarController.text, 'Birth Star');
      String gotraError = Validation.validateNotEmpty(
          gotraController.text, 'Gotra');
      String birthDateError = Validation.validateNotEmpty(
          birthdateController.text, 'Birth Date');
      String birthPlaceError = Validation.validateNotEmpty(
          birthcityController.text, 'Birth Place');
      String birthTimeError = Validation.validateNotEmpty(
          birthtimeController.text, 'Birth Time');


      if (birthDateError == "null"
          && birthPlaceError == "null" || birthTimeError == "null") {
        DialogClass().showDialog2(context, "Horoscope Details Submit Alert!",
            "All fields are compulsory", "Ok");
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        //prefs.remove(SharedPrefs.astroRashi);

        print(prefs.getString(SharedPrefs.astroRashi).toString()+"---"+prefs.getString(SharedPrefs.horoscope_id).toString());



        if (birth_date == "") {
          EasyLoading.show(status: 'Please wait...');

          final _response = await Provider.of<ApiService>(
              context, listen: false)
              .postInsertHoroscope(
              [0],
              rashi,
              birth_star,
              gotraController.text.toString(),
              believe_horoscope == true ? "1"  :"0",
              birthdateController.text.toString(),
              birthcityController.text.toString(),
              birthtimeController.text.toString(),
              "",
              "",
              ismangalik == true ? "1" : "0",
              widget.list[12],
              widget.list[11],
              prefs.getString(SharedPrefs.communityId).toString(),
              timezone,
              location_value);

          if (_response.body["data"]["affectedRows"] == 1) {

            EasyLoading.dismiss();
            navService.goBack();

          }
        } else {
          EasyLoading.show(status: 'Please wait...');


          final _response = await Provider.of<ApiService>(
              context, listen: false).postHoroscopeUpdate(
              [0],
              rashi,
              birth_star,
              gotraController.text.toString(),
              believe_horoscope == true ? "1"  :"0",
              birthdateController.text.toString(),
              birthcityController.text.toString(),
              birthtimeController.text.toString(),
              "0",
              "00",
              ismangalik == true ? "1" : "0",
              location_value,
              timezone,
              widget.list[10]);


          print(_response.body);


          if (_response.body["success"] == 1) {

            EasyLoading.dismiss();

            navService.goBack();
          } else {
            DialogClass().showDialog2(
                context, "horoscope Details Submit Alert!",
                "Some problem occured Please try again", "Ok");
          }
        }
      }
    }
              },)
            ])))));
  }

}