import 'package:chopper/chopper.dart';
import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/SingleSelectDialog.dart';
import 'package:community_matrimonial/app_utils/Values.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/user_profile/ButtonSubmit.dart';
import 'package:community_matrimonial/screens/user_profile/CustomDropdown.dart';
import 'package:community_matrimonial/screens/user_profile/CustomTextField.dart';
import 'package:community_matrimonial/screens/user_profile/MultilineTextfield.dart';
import 'package:community_matrimonial/screens/user_profile/NumericFields.dart';
import 'package:community_matrimonial/utils/Designs.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:community_matrimonial/utils/validation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_picker/country_picker.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../locale/TranslationService.dart';
import '../../../utils/PhoneInputField.dart';



class ContactDetailsEdit extends StatelessWidget {

  final List list;
  ContactDetailsEdit( this.list);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactDetailsStateful(list),
      builder: EasyLoading.init(),
    );
  }
}


class ContactDetailsStateful extends StatefulWidget {

  final List list;
  ContactDetailsStateful(this.list);

  @override
  ContactDetailsScreen createState() => ContactDetailsScreen();

}

class ContactDetailsScreen  extends State<ContactDetailsStateful>{


  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PhoneInputController mobileController = PhoneInputController();

  PhoneInputController altmobileController = PhoneInputController();

  TextEditingController emailidController =new TextEditingController();
  TextEditingController altemailidController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController permstateController = new TextEditingController();
  TextEditingController permcityController = new TextEditingController();

  TextEditingController workcountryController = new TextEditingController();
  TextEditingController workstateController = new TextEditingController();
  TextEditingController workcityController = new TextEditingController();

  TextEditingController permaddressController = new TextEditingController();
  TextEditingController workaddressController = new TextEditingController();
  TextEditingController contactdurationController = new TextEditingController();

  String  country_value = "" , perm_State_value = "" , permcityValue = "";
  String work_state_value = "" , work_city_value = "",  perm_address = "" , workaddress = "";
  String contact_duration_value = "";
  String country_value2 = "";

  String mobilemcc = "" , mobilemcc2 = "" ;
  String mobilemccerrocheck = "";
  String code1 = "" ,code2 = "";
  bool? isvalid = false , isvalid2 = false;


  initViews() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    emailidController.text =   widget.list[2];
    altemailidController.text  =  widget.list[3];
    countryController.text =   widget.list[4];
    permstateController.text =   widget.list[5];
    permcityController.text =  widget.list[6];
    workstateController.text =   widget.list[7];
    workcityController.text =  widget.list[8];
    permaddressController.text =  widget.list[9];
    workaddressController.text =   widget.list[10];
    contactdurationController.text =   widget.list[11];

    country_value = widget.list[12];
    perm_State_value = widget.list[13];
    permcityValue =  widget.list[14];
    work_state_value = widget.list[15];
    work_city_value = widget.list[16];

    perm_address = widget.list[9];
    workaddress = widget.list[10];
    contact_duration_value = widget.list[11];




    final res = await utils().getMobileNumber(utils().replaceNull(widget.list[0].toString()));
    final res2 = await utils().getMobileNumber(utils().replaceNull(widget.list[1].toString()));

    if(utils().replaceNull(prefs.getString(SharedPrefs.mobileNumber).toString()) != ""){

      mobileController.setValue(CountryParser.parse(res.split("_")[1]) , res.split("_")[0]);
      mobilemcc = CountryParser.parse(res.split("_")[1]).phoneCode+res.split("_")[0];
      mobilemccerrocheck = res.split("_")[0];


    }

    if(utils().replaceNull(prefs.getString(SharedPrefs.alternateMobile).toString()) != ""){
      altmobileController.setValue(CountryParser.parse(res2.split("_")[1]) , res2.split("_")[0]);
      mobilemcc2 = CountryParser.parse(res2.split("_")[1]).phoneCode+res2.split("_")[0];

    }

  }

  @override
  void initState() {
    super.initState();

    initViews();

  }

  Future<bool?> isValidPhone({
    required String number,
    required String isoCode,
  }) async {

    try {

      final parsed = await PhoneNumberUtil.isValidPhoneNumber(
          number , isoCode
      );

      print(parsed);

      return parsed;

    } catch (e) {

      print(e);
      return false;
    }
  }



  late ConnectivityResult _connectivityResult;

  @override
  Widget build(BuildContext context) {

    return Scaffold(key: _scaffoldKey,
        appBar: AppBar(
            title: Text('Contact Details\nRavaldev Matrimony' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
            toolbarOpacity: 1,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
              onPressed: () {

                navService.goBack();

              },
            )),


        body: SafeArea(child: SingleChildScrollView(child:Container(margin: EdgeInsets.only(left: 15 ,right: 15) ,child:Column(children: [

          Divider(),

          Container(margin: EdgeInsets.only(top: 10) ,child:/*NumericTextField(icondata: Icons.phone_android, controller: mobileController, labelText:TranslationService.translate("mobile_no"), enabled: false)*/PhoneInputField(
            controller: mobileController,
            onChanged: (countryCode, number) {

              mobilemcc = CountryParser.parse(countryCode).phoneCode+number;
              mobilemccerrocheck = number;


            },
            onChanged2: () async {

              final clipboard = await Clipboard.getData('text/plain');
              if (clipboard != null && clipboard.text != null) {
                print("Clipboard text: ${clipboard.text}");

                final res = await utils().getMobileNumber(
                    clipboard.text.toString().replaceAll(RegExp(r'[^0-9]') , ''));

                mobilemcc = CountryParser.parse(res.split("_")[1]).phoneCode+res.split("_")[0];
                mobilemccerrocheck = res.split("_")[0];

                mobileController.setValue(CountryParser.parse(res.split("_")[1]), res.split("_")[0]);

                code1 = res.split("_")[1];




              }



            },
          ),),
          SizedBox(height: 20,),
          PhoneInputField(
            controller: altmobileController,
            onChanged: (countryCode, number) {

              mobilemcc2 = CountryParser.parse(countryCode).phoneCode+number;



            },
            onChanged2: () async {

              final clipboard = await Clipboard.getData('text/plain');
              if (clipboard != null && clipboard.text != null) {
                print("Clipboard text: ${clipboard.text}");

                final res = await utils().getMobileNumber(
                    clipboard.text.toString().replaceAll(RegExp(r'[^0-9]') , ''));

                mobilemcc2 = CountryParser.parse(res.split("_")[1]).phoneCode+res.split("_")[0];

                altmobileController.setValue(CountryParser.parse(res.split("_")[1]), res.split("_")[0]);

                code2 = res.split("_")[1];



              }



            },
          ),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.email , controller: emailidController , labelText: TranslationService.translate("emailid"), enabled: false,),
          /* SizedBox(height: 20,),
          CustomTextField(icondata: Icons.email , controller: altemailidController , labelText: TranslationService.translate("alt_emailid"), enabled: false,),
      */    SizedBox(height: 20,),
          CustomDropdown(icondata: MdiIcons.googleMaps  ,controller: countryController , labelText: TranslationService.translate("perm_country") , onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValuesContacts(context , "country" , "") , "Select Country");
            countryController.text = value.label;
            country_value = value.value;

          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: MdiIcons.city  , controller: permstateController , labelText: TranslationService.translate("perm_state"), onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet2(context, await Values.getValuesContactsState(context , "state" , "" , country_value) , "Select State");
            permstateController.text = value.state_name;
            perm_State_value = value.Id;

            print(perm_State_value+"====----");

            if(value.state_name.toLowerCase() == "other"){

              String state_name = "";
              DialogClass().showDailogwithTextField(context , "Enter Your Permanent State" , "Submit State" , "Enter State" , Icons.location_city , (p0) async {

                state_name = p0;

                print(state_name+"------"+country_value);

                final _response = await Provider.of<ApiService>(
                    context, listen: false).postInsertStateOther({"state_name": p0 , "country_id":country_value });



                if (_response.body["data"]["affectedRows"] == 1) {

                  permstateController.text = state_name;
                  perm_State_value = _response.body["data"]["insertId"];

                }

              },);


            }

          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: MdiIcons.city  ,controller: permcityController , labelText: TranslationService.translate("perm_city"), onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet3(context, await Values.getValuesContactsCity(context , perm_State_value , country_value));
            permcityController.text = value.label;
            permcityValue = value.value;


            if(value.label.toLowerCase() == "other"){

              String city_name = "";
              DialogClass().showDailogwithTextField(context , "Enter Your Permanent City" , "Submit City" , "Enter City" , Icons.location_city , (p0) async {

                city_name = p0;

                print(city_name+"------"+country_value);

                final _response = await Provider.of<ApiService>(
                    context, listen: false).postInsertCityOther({"city_name": p0 , "state_id":perm_State_value , "country_id":country_value });

                if (_response.body["data"]["affectedRows"] == 1) {

                  permcityController.text = city_name;
                  permcityValue = _response.body["data"]["insertId"];

                }

              },);


            }

          },),
          SizedBox(height: 20,),
          MultilineTextfield(icondata: MdiIcons.googleMaps, controller: permaddressController, labelText: TranslationService.translate("perm_address"), enabled: false, minlines: 3, maxlines: 5),
          SizedBox(height: 20,),
          CustomDropdown(icondata: MdiIcons.googleMaps  ,controller: workcountryController , labelText: TranslationService.translate("work_country") , onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet(context , await Values.getValuesContacts(context , "country" , "") , "Select Country");
            workcountryController.text = value.label;
            country_value2 = value.value;

          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: MdiIcons.city  ,controller: workstateController , labelText: TranslationService.translate("work_state"), onButtonPressed: () async {


            final value = await SingleSelectDialog().showBottomSheet2(context, await Values.getValuesContactsState(context , "state" , "" , country_value2) , "Select Work State");
            workstateController.text = value.state_name;
            work_state_value = value.Id;


            if(value.state_name.toLowerCase() == "other"){

              String state_name = "";
              DialogClass().showDailogwithTextField(context , "Enter Your Work State" , "Submit State" , "Enter State" , Icons.location_city , (p0) async {

                state_name = p0;

                print(state_name+"------"+country_value);
                SharedPreferences prefs = await SharedPreferences.getInstance();


                final _response = await Provider.of<ApiService>(
                    context, listen: false).postInsertStateOther({"state_name": p0 , "country_id":country_value2 ,"community_id":prefs.getString(SharedPrefs.communityId) });

                if (_response.body["data"]["affectedRows"] == 1) {

                  workstateController.text = state_name;
                  work_state_value = _response.body["data"]["insertId"];

                }

              },);


            }

          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: MdiIcons.city  ,controller: workcityController , labelText: TranslationService.translate("work_city"), onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet3(context, await Values.getValuesContactsCity(context , work_state_value , country_value2));
            workcityController.text = value.label;
            work_city_value = value.value;

            if(value.label.toLowerCase() == "other"){

              String city_name = "";
              DialogClass().showDailogwithTextField(context , "Enter Your Work City" , "Submit City" , "Enter City" , Icons.location_city , (p0) async {

                city_name = p0;

                print(city_name+"------"+country_value);

                SharedPreferences prefs = await SharedPreferences.getInstance();

                final _response = await Provider.of<ApiService>(
                    context, listen: false).postInsertCityOther({"city_name": p0 , "state_id":work_state_value , "country_id":country_value2 ,"community_id":prefs.getString(SharedPrefs.communityId)});

                if (_response.body["data"]["affectedRows"] == 1) {

                  workcityController.text = city_name;
                  work_city_value = _response.body["data"]["insertId"];

                }

              },);


            }



          },),
          SizedBox(height: 20,),
          MultilineTextfield(icondata: MdiIcons.googleMaps, controller: workaddressController , labelText: TranslationService.translate("work_address"), enabled: false, minlines: 3, maxlines: 5),
          SizedBox(height: 20,),
          MultilineTextfield(icondata: Icons.timelapse , controller: contactdurationController , labelText: TranslationService.translate("contact_time"), enabled: false, minlines: 2, maxlines: 3,),
          SizedBox(height: 20,),
          ButtonSubmit(text: 'Submit Contact Details', onButtonPressed: () async {




            ConnectivityResult result = await Connectivity().checkConnectivity();
            setState(() {
              _connectivityResult = result;
            });

            if (_connectivityResult == ConnectivityResult.none) {
              DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");
            }else {

              print(mobileController.toString()+"--------");

              String mobileNumberError = Validation.validateNotEmpty(
                  mobilemccerrocheck , 'Mobile Number').toString();
              String permanentAddressError = Validation.validateNotEmpty(
                  permaddressController.text, 'Permanent Address').toString();
              String emailIdError = Validation.validateNotEmpty(
                  emailidController.text, 'Email ID').toString();
              String alternateMobileError = Validation.validateNotEmpty(
                  mobilemcc2 , 'Alternate Mobile').toString();
              String alternateEmailError = Validation.validateNotEmpty(
                  altemailidController.text, 'Alternate Email').toString();
              String workingAddressError = Validation.validateNotEmpty(
                  workaddressController.text, 'Working Address').toString();
              String contactTimeError = Validation.validateNotEmpty(
                  contactdurationController.text, 'Contact Time').toString();
              String permCountryError = Validation.validateNotEmpty(
                  countryController.text, 'Permanent Country').toString();
              String permStateError = Validation.validateNotEmpty(
                  permstateController.text, 'Permanent State').toString();
              String permCityError = Validation.validateNotEmpty(
                  permcityController.text, 'Permanent City').toString();



              if (
              mobileNumberError == "null" ||
                  permCountryError == "null" ||
                  permStateError == "null" ||
                  permCityError == "null"
              ) {

                DialogClass().showDialog2(
                    context, "Contact Details Submit Alert!",
                    "Mobilenumber , Permanent Country , Permanent State ,Permanent City fields are compulsory", "Ok");

              } else {

                print(isvalid.toString()+"=====");

                isvalid = await isValidPhone(number: "+"+mobilemcc, isoCode: code1);
                isvalid2 = await isValidPhone(number: "+"+mobilemcc, isoCode: code2);

                if(!isvalid!){

                  DialogClass().showDialog2(
                      context, "Validation Alert!",
                      "Mobile number is not valid", "Ok");

                  return;

                }else if(!isvalid2!){

                  DialogClass().showDialog2(
                      context, "Validation Alert!",
                      "Alternate Mobile number is not valid", "Ok");

                  return;

                }

                List<Location> locations = await locationFromAddress(permaddressController.text.toString()+" "+permcityValue+", "+perm_State_value);

                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (widget.list[5] == "" || widget.list[5] == null) {

                  EasyLoading.show(status: 'Please wait...');

                  final _response = await Provider.of<ApiService>(
                      context, listen: false)
                      .postContactDetail(
                      {
                        "mobile_number": mobilemcc,
                        "permanent_adddress": permaddressController.text
                            .toString(),
                        "whatsapp_number": "-----",
                        "current_address": "",
                        "emailid": emailidController.text.toString(),
                        "alternate_mobile": mobilemcc2,
                        "alternate_email": "",
                        "working_address": workaddressController.text
                            .toString(),
                        "contact_time": contactdurationController.text
                            .toString(),
                        "perm_country": country_value,
                        "perm_state": perm_State_value,
                        "perm_city": permcityValue,
                        "cur_country": "India",
                        "cur_state": "",
                        "cur_city": "",
                        "work_country": country_value,
                        "work_state": work_state_value,
                        "work_city": work_city_value,
                        "location": locations[0].latitude.toString()+","+locations[0].longitude.toString(),
                        "userId": widget.list[18],
                        "communityId": prefs.getString(SharedPrefs.communityId),
                        "profileId": widget.list[19]
                      }
                  );

                  print("insert\n");
                  print(_response.body.toString()+"{]{]");

                  if (_response.body["data"]["affectedRows"] == 1) {

                      navService.goBack();

                  } else {
                    EasyLoading.dismiss();

                    DialogClass().showDialog2(
                        context, "Contact Details Submit Alert!",
                        "Some problem occured Please try again", "Ok");
                  }
                } else {
                  EasyLoading.show(status: 'Please wait...');

                  print(locations[0].latitude.toString()+",,,,"+locations[0].longitude.toString()+"-----"+mobilemcc2);

                  final _response = await Provider.of<ApiService>(
                      context, listen: false)
                      .postContactDetailUpdate(
                      {
                        "mobile_number": mobilemcc,
                        "permanent_adddress": permaddressController.text
                            .toString(),
                        "whatsapp_number": "-----",
                        "current_address": "",
                        "emailid": emailidController.text.toString(),
                        "alternate_mobile": mobilemcc2,
                        "alternate_email": "",
                        "working_address": workaddressController.text
                            .toString(),
                        "contact_time": contactdurationController.text
                            .toString(),
                        "perm_country": country_value,
                        "perm_state": perm_State_value,
                        "perm_city": permcityValue,
                        "cur_country": "India",
                        "cur_state": "",
                        "cur_city": "",
                        "work_country": country_value,
                        "work_state": work_state_value,
                        "work_city": work_city_value,
                        "location": locations[0].latitude.toString()+","+locations[0].longitude.toString(),
                        "Id": widget.list[17]
                      }
                  );


                  print("update\n");
                  print(_response.body.toString());


                  if (_response.body["success"] == 1) {

                    EasyLoading.dismiss();

                    navService.goBack();
                  } else {
                    DialogClass().showDialog2(
                        context, "Contact Details Submit Alert!",
                        "Some problem occured Please try again", "Ok");
                  }
                }
              }
            }},)
        ])))));


  }


}