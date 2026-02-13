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
import '../../../network_utils/model/country.dart';
import '../../../utils/PhoneInputField.dart';
import '../../../utils/universalback_wrapper.dart';



class ContactDetails extends StatelessWidget {

  final String type;
  ContactDetails({required this.type});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactDetailsStateful(type),
      builder: EasyLoading.init(),
    );
  }
}


class ContactDetailsStateful extends StatefulWidget {

  final String type;
  ContactDetailsStateful(this.type);

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



  initViews() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();


    emailidController.text =   utils().replaceNull(prefs.getString(SharedPrefs.emailId).toString());
    altemailidController.text  =  utils().replaceNull(prefs.getString(SharedPrefs.alternateEmail).toString());
    countryController.text =   utils().replaceNull(prefs.getString(SharedPrefs.permCountry).toString().split(",")[0]);
    workcountryController.text =   utils().replaceNull(prefs.getString(SharedPrefs.work_country).toString().split(",")[0]);
    permstateController.text =   utils().replaceNull(prefs.getString(SharedPrefs.permState).toString().split(",")[0]);
    permcityController.text =  utils().replaceNull(prefs.getString(SharedPrefs.permCity).toString().split(",")[0]);
    workstateController.text =   utils().replaceNull(prefs.getString(SharedPrefs.workState).toString().split(",")[0]);
    workcityController.text =   utils().replaceNull(prefs.getString(SharedPrefs.workCity).toString().split(",")[0]);
    workaddressController.text =   utils().replaceNull(prefs.getString(SharedPrefs.workingAddress).toString());
    permaddressController.text =   utils().replaceNull(prefs.getString(SharedPrefs.permanentAddress).toString());
    contactdurationController.text =   utils().replaceNull(prefs.getString(SharedPrefs.contactTime).toString());

    final res = await utils().getMobileNumber(utils().replaceNull(prefs.getString(SharedPrefs.mobileNumber).toString()));
    final res2 = await utils().getMobileNumber(utils().replaceNull(prefs.getString(SharedPrefs.mobileNumber).toString()));



    if(utils().replaceNull(prefs.getString(SharedPrefs.mobileNumber).toString()) != ""){

      mobileController.setValue(CountryParser.parse(res.split("_")[1]) , res.split("_")[0]);
      mobilemcc = CountryParser.parse(res.split("_")[1]).phoneCode+res.split("_")[0];
      mobilemccerrocheck = res.split("_")[0];


    }

    if(utils().replaceNull(prefs.getString(SharedPrefs.alternateMobile).toString()) != ""){
      altmobileController.setValue(CountryParser.parse(res2.split("_")[1]) , res2.split("_")[0]);
      mobilemcc2 = CountryParser.parse(res2.split("_")[1]).phoneCode+res2.split("_")[0];

    }

    if(utils().replaceNull(prefs.getString(SharedPrefs.emailId).toString()) == ""){
      emailidController.text = prefs.getString(SharedPrefs.emailid).toString() == "undefined" || prefs.getString(SharedPrefs.emailid).toString() == "" ? "" : prefs.getString(SharedPrefs.emailid).toString();
    }

    country_value = prefs.getString(SharedPrefs.permCountry).toString().split(",")[1];
    country_value2 = prefs.getString(SharedPrefs.work_country).toString().split(",")[1];
    perm_State_value = prefs.getString(SharedPrefs.permState).toString().split(",")[1];
    permcityValue = prefs.getString(SharedPrefs.permCity).toString().split(",")[1];
    work_city_value = prefs.getString(SharedPrefs.workCity).toString().split(",")[1];
    work_state_value = prefs.getString(SharedPrefs.workState).toString().split(",")[1];
    perm_address = prefs.getString(SharedPrefs.permanentAddress).toString();
    workaddress = prefs.getString(SharedPrefs.workingAddress).toString();
    contact_duration_value = prefs.getString(SharedPrefs.contactTime).toString();

  }







  @override
  void initState() {
    super.initState();

    EasyLoading.dismiss();


    initViews();

  }

  late ConnectivityResult _connectivityResult;
  String mobilemcc = "" , mobilemcc2 = "" , mobilemcc3 = "";
  String mobilemccerrocheck = "";


  Future<bool?> isValidPhone({
    required String number,
    required String isoCode,
  }) async {

    try {

      print(number+"----"+isoCode);

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

   bool? isvalid = false , isvalid2 = false;
  String code1 = "+91" ,code2 = "+91";

  @override
  Widget build(BuildContext context) {

    return UniversalBackWrapper(
        isRoot: false

        ,child: Scaffold(key: _scaffoldKey,
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

              code1 = CountryParser.parse(countryCode).phoneCode;
              print(code1);


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


                print(code1);


              }



            },
          ),),
          SizedBox(height: 20,),
          PhoneInputField(
            controller: altmobileController,
            onChanged: (countryCode, number) {

              mobilemcc2 = CountryParser.parse(countryCode).phoneCode+number;

              code2 = CountryParser.parse(countryCode).phoneCode;

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

            final res = await Values.getValuesContactsState(context , "state" , "" , country_value);

            final value = await SingleSelectDialog().showBottomSheet2(context, res , "Select State");
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
                isvalid2 = await isValidPhone(number: "+"+mobilemcc2, isoCode: code2);

                if(!isvalid!){

                  DialogClass().showDialog2(
                      context, "Validation Alert!",
                      "Mobile number is not valid", "Ok");

                  return;

                }else if(!isvalid2! && mobilemcc2 != ""){

                  DialogClass().showDialog2(
                      context, "Validation Alert!",
                      "Alternate Mobile number is not valid", "Ok");

                  return;

                }

              //  List<Location> locations = await locationFromAddress(permaddressController.text.toString()+" "+permcityValue+", "+perm_State_value);

                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (prefs
                    .getString(SharedPrefs.permState)
                     == null) {

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
                        "location": "0,0",
                        "userId": prefs.getString(SharedPrefs.userId),
                        "communityId": prefs.getString(SharedPrefs.communityId),
                        "profileId": prefs.getString(SharedPrefs.profileid)
                      }
                  );

                  print("insert\n");
                  print(_response.body.toString());

                  if (_response.body["data"]["affectedRows"] == 1) {
                    await prefs.setString(SharedPrefs.contact_details_id,
                        _response.body["data"]["insertId"].toString());
                    await prefs.setString(SharedPrefs.mobileNumber,
                        mobilemcc);
                    await prefs.setString(SharedPrefs.whatsappNumber, "");
                    await prefs.setString(SharedPrefs.permanentAddress,
                        permaddressController.text.toString());
                    await prefs.setString(SharedPrefs.emailId, emailidController
                        .text.toString());
                    await prefs.setString(SharedPrefs.alternateMobile,
                        mobilemcc2);
                    await prefs.setString(SharedPrefs.alternateEmail,
                        altemailidController.text.toString());
                    await prefs.setString(SharedPrefs.workingAddress,
                        workaddressController.text.toString());
                    await prefs.setString(SharedPrefs.contactTime,
                        contactdurationController.text.toString());
                    await prefs.setString(SharedPrefs.permCountry,
                        countryController.text.toString() + "," +
                            country_value);
                    await prefs.setString(SharedPrefs.work_country,
                        workcountryController.text.toString() + "," +
                            country_value2);
                    await prefs.setString(SharedPrefs.permState,
                        permstateController.text + "," + perm_State_value);
                    await prefs.setString(SharedPrefs.permCity,
                        permcityController.text + "," + permcityValue);
                    await prefs.setString(SharedPrefs.workState,
                        workstateController.text.toString() + "," +
                            work_state_value);
                    await prefs.setString(SharedPrefs.workCity,
                        workcityController.text.toString() + "," +
                            work_city_value);

                    if (widget.type == "insert") {
                      navService.pushNamed(
                          "/education_details", args: "insert");
                    } else {
                      navService.goBack();
                    }
                  } else {
                    EasyLoading.dismiss();

                    DialogClass().showDialog2(
                        context, "Contact Details Submit Alert!",
                        "Some problem occured Please try again", "Ok");
                  }
                } else {
                  EasyLoading.show(status: 'Please wait...');

               //   print(locations[0].latitude.toString()+",,,,"+locations[0].longitude.toString()+"-----"+mobilemcc2);

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
                        "location": "0,0",
                        "Id": prefs.getString(SharedPrefs.contact_details_id),
                      }
                  );


                  print("update\n");
                  print(_response.body.toString());


                  if (_response.body["success"] == 1) {
                    await prefs.setString(SharedPrefs.mobileNumber,
                        mobilemcc);
                    await prefs.setString(SharedPrefs.whatsappNumber,
                        "--------");
                    await prefs.setString(SharedPrefs.permanentAddress,
                        permaddressController.text.toString());
                    await prefs.setString(SharedPrefs.emailId, emailidController
                        .text.toString());
                    await prefs.setString(SharedPrefs.alternateMobile,
                        mobilemcc2);
                    await prefs.setString(SharedPrefs.alternateEmail,
                        altemailidController.text.toString());
                    await prefs.setString(SharedPrefs.workingAddress,
                        workaddressController.text.toString());
                    await prefs.setString(SharedPrefs.contactTime,
                        contactdurationController.text.toString());
                    await prefs.setString(SharedPrefs.permCountry,
                        countryController.text.toString() + "," +
                            country_value);
                    await prefs.setString(SharedPrefs.work_country,
                        workcountryController.text.toString() + "," +
                            country_value2);
                    await prefs.setString(SharedPrefs.permState,
                        permstateController.text + "," + perm_State_value);
                    await prefs.setString(SharedPrefs.permCity,
                        permcityController.text + "," + permcityValue);
                    await prefs.setString(SharedPrefs.workState,
                        workstateController.text.toString() + "," +
                            work_state_value);
                    await prefs.setString(SharedPrefs.workCity,
                        workcityController.text.toString() + "," +
                            work_city_value);

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
        ]))))));


  }


}