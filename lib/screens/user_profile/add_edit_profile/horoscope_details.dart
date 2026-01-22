
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


class HoroscopeDetail extends StatelessWidget {

  final String type;
  HoroscopeDetail({required this.type});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HoroscopeDetailStateful(type),
      builder: EasyLoading.init(),
    );
  }
}


class HoroscopeDetailStateful extends StatefulWidget {

  final String type;
  HoroscopeDetailStateful(this.type);

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
  TextEditingController birthareaController = new TextEditingController();
  TextEditingController birthtimeController = new TextEditingController();

  bool ismangalik = false , believe_horoscope = false;
  String rashi = "" ,birth_star = "" , gotra= "" , birth_date = "" , birth_city = "", birth_time = "";
  String ismangalik_value = "", believe_in_horoscope    = "";
  String location_value = "" , timezone = "";

  late ConnectivityResult _connectivityResult;

  @override
  void initState() {
    super.initState();

    EasyLoading.dismiss();

    initValues();

  }

  initValues() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    rashiController.text =  utils().replaceNull(prefs.getString(SharedPrefs.astroRashi).toString().split(",")[0]);
    birthstarController.text =   utils().replaceNull(prefs.getString(SharedPrefs.birthStar).toString().split(",")[0]);
    gotraController.text =   utils().replaceNull(prefs.getString(SharedPrefs.gotra).toString());
    birthdateController.text =  utils().replaceNull(prefs.getString(SharedPrefs.birthDate).toString());
    birthcityController.text =   utils().replaceNull(prefs.getString(SharedPrefs.birthPlace).toString());
    birthtimeController.text  =   utils().replaceNull(prefs.getString(SharedPrefs.birthTime).toString());
    birthareaController.text = utils().replaceNull(prefs.getString(SharedPrefs.birthArea).toString());


    if(utils().replaceNull(prefs.getString(SharedPrefs.birthDate).toString()) == ""){
      birthdateController.text =  utils().formatGivenDate(prefs.getString(SharedPrefs.birthdate).toString());
    }

    setState(() {

      ismangalik =   prefs.getString(SharedPrefs.isMangalik).toString() == "1" ? true : false;
      believe_horoscope =   prefs.getString(SharedPrefs.believeHoroscope).toString() == "1" ? true : false;

    });

    rashi =  prefs.getString(SharedPrefs.astroRashi) != null ? prefs.getString(SharedPrefs.astroRashi).toString().split(",")[1] : "";
    birth_star = prefs.getString(SharedPrefs.birthStar) != null ? prefs.getString(SharedPrefs.birthStar).toString().split(",")[1] : "";
    birth_date = prefs.getString(SharedPrefs.birthDate).toString();
    birth_time = prefs.getString(SharedPrefs.birthTime).toString();
    birth_city = prefs.getString(SharedPrefs.birthPlace).toString();

    ismangalik_value =   ismangalik == true ? "1" : "0";
    believe_in_horoscope = believe_horoscope == true ? "Yes" : "No";

    timezone = prefs.getString(SharedPrefs.timezone).toString();
    location_value = prefs.getString(SharedPrefs.locationCoordinates).toString();

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
            title: Text('Horoscope Details\nRavaldev Matrimony',
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


        body: SingleChildScrollView(child: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(children: [

            Divider(),
              SizedBox(height: 15,),
              GestureDetector(onTap: () async {

                final date =   await showDatePickerDialog(
                  context: context,
                  initialDate: DateTime(2022, 10, 10),
                  minDate: DateTime(1955, 10, 10),
                  maxDate: DateTime(2024, 10, 30),
                  currentDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
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

              }  ,child:CustomTextField(icondata: Icons.date_range_sharp ,controller: birthdateController , labelText: "*"+TranslationService.translate("birth_date"), enabled: true,),),
              SizedBox(height: 20,),
              CustomTextField(icondata: Icons.location_city , controller: birthcityController , labelText: "*"+Strings.birth_city, enabled: false,),
              SizedBox(height: 20,),
              CustomTextField(icondata: Icons.location_city , controller: birthareaController , labelText: "*"+Strings.birth_area, enabled: false,),
              SizedBox(height: 20,),
              GestureDetector(onTap: () async {

                final time =    await showTimePicker(context: context, initialTime: TimeOfDay(hour: 12, minute: 00));
                birthtimeController.text = time!.hour.toString()+":"+time!.minute.toString()+":"+"00";


              }  ,child:CustomTextField(icondata: Icons.timelapse ,controller: birthtimeController , labelText: "*"+TranslationService.translate("birth_time"), enabled: true,),),
              SizedBox(height: 20,),
            Container(margin: EdgeInsets.only(top: 0) ,child:CustomDropdown(icondata: MdiIcons.starBox  ,controller:rashiController  , labelText: TranslationService.translate("rashi"), onButtonPressed: () async {

              final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "rashi" , "") , "Select Rashi");
              rashiController.text = value.label;
              rashi = value.value;

            },),),
            SizedBox(height: 20,),
            CustomDropdown(icondata: MdiIcons.starBox  ,controller:birthstarController  , labelText: TranslationService.translate("birth_star"), onButtonPressed: () async {

              final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "birth_star" , "") ,"Select Birth Star");
              birthstarController.text = value.label;
              birth_star = value.value;

            },),
           /* SizedBox(height: 20,),
            CustomTextField(icondata: Icons.person , controller: gotraController , labelText: TranslationService.translate("gotra"), enabled: false,),
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
              ),*/
              SizedBox(height: 30.0),
              /*ButtonSubmit(text:"Get Birth Place Location", onButtonPressed: (){


                  _showTextFieldPopup(context);


              }),
              SizedBox(height: 10.0),
              Text("TimeZone : "+timezone , textAlign: TextAlign.left,),
              SizedBox(height: 10.0),
              Text("Location Co-ordinates : "+location_value , textAlign: TextAlign.left,),
              SizedBox(height: 20,),*/
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
      String birthAreaError = Validation.validateNotEmpty(
          birthareaController.text, 'Birth Area');
      String birthTimeError = Validation.validateNotEmpty(
          birthtimeController.text, 'Birth Time');


      if ( birthDateError == "null"
          || birthPlaceError == "null" || birthTimeError == "null" || birthAreaError == "null") {
        DialogClass().showDialog2(context, "Horoscope Details Submit Alert!",
            "Field marked with * are compulsory", "Ok");
      } else {



        EasyLoading.show(status: 'Please wait...');

        SharedPreferences prefs = await SharedPreferences.getInstance();

        //prefs.remove(SharedPrefs.astroRashi);

        print(prefs.getString(SharedPrefs.astroRashi).toString()+"---"+prefs.getString(SharedPrefs.horoscope_id).toString());

        String enteredText = birthareaController.text.toString()+","+birthcityController.text.toString();
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





        if (prefs.getString(SharedPrefs.birthDate) == null) {


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
              prefs.getString(SharedPrefs.profileid).toString(),
              prefs.getString(SharedPrefs.userId).toString(),
              prefs.getString(SharedPrefs.communityId).toString(),
              timezone,
              location_value);

          if (_response.body["data"]["affectedRows"] == 1) {
            await prefs.setString(SharedPrefs.horoscope_id, _response
                .body["data"]["insertId"].toString());
            await prefs.setString(SharedPrefs.astroRashi, rashiController.text
                .toString() + "," + rashi);
            await prefs.setString(SharedPrefs.birthStar, birthstarController
                .text.toString() + "," + birth_star);
            await prefs.setString(SharedPrefs.gotra, gotraController.text
                .toString());
            await prefs.setString(SharedPrefs.believeHoroscope,
              believe_horoscope == true ? "1"  :"0",);
            await prefs.setString(SharedPrefs.birthDate, birthdateController
                .text.toString());
            await prefs.setString(SharedPrefs.birthPlace, birthcityController
                .text.toString());
            await prefs.setString(SharedPrefs.birthArea, birthareaController
                .text.toString());
            await prefs.setString(SharedPrefs.birthTime, birthtimeController
                .text.toString());
            await prefs.setString(SharedPrefs.birthCountry, "");
            await prefs.setString(SharedPrefs.horoscopeDoc, "");
            await prefs.setString(SharedPrefs.timezone, timezone);
            await prefs.setString(SharedPrefs.isMangalik, ismangalik == true ? "1" : "0");
            await prefs.setString(SharedPrefs.locationCoordinates,
                location_value);
            await prefs.setString(SharedPrefs.timezone, timezone);

            EasyLoading.dismiss();

            if (widget.type == "insert") {
              navService.pushNamed("/fml_details", args: "insert");
            } else {
              navService.goBack();
            }
          }
        } else {
          EasyLoading.show(status: 'Please wait...');

          print( {[0],
            rashi,
            birth_star,
            gotraController.text
                .toString(),
            believe_horoscope,
            birthdateController.text.toString(),
            birthcityController.text.toString(),
            birthtimeController.text.toString(),
            "0",
            "00",
            ismangalik_value,
            location_value,
            timezone,
            prefs.getString(SharedPrefs.horoscope_id).toString()});



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
              prefs.getString(SharedPrefs.horoscope_id).toString());





          if (_response.body["success"] == 1) {
            print(_response.body);


            await prefs.setString(SharedPrefs.astroRashi, rashiController.text
                .toString() + "," + rashi);
            await prefs.setString(SharedPrefs.birthStar, birthstarController
                .text.toString() + "," + birth_star);
            await prefs.setString(SharedPrefs.gotra, gotraController.text
                .toString());
            await prefs.setString(SharedPrefs.believeHoroscope,
                believe_horoscope == true ? "1" :"0");
            await prefs.setString(SharedPrefs.birthDate, birthdateController
                .text.toString());
            await prefs.setString(SharedPrefs.birthPlace, birthcityController
                .text.toString());
            await prefs.setString(SharedPrefs.birthArea, birthareaController
                .text.toString());
            await prefs.setString(SharedPrefs.birthTime, birthtimeController
                .text.toString());
            await prefs.setString(SharedPrefs.birthCountry, "");
            await prefs.setString(SharedPrefs.horoscopeDoc, "");
            await prefs.setString(SharedPrefs.timezone, timezone);
            await prefs.setString(SharedPrefs.isMangalik, ismangalik == true ? "1" : "0");
            await prefs.setString(SharedPrefs.locationCoordinates,
                location_value);
            await prefs.setString(SharedPrefs.timezone, timezone);


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
            ]))));
  }

}