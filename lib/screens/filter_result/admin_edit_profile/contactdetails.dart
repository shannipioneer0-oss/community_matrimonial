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
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../locale/TranslationService.dart';



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

  TextEditingController mobileController =new TextEditingController();
  TextEditingController altmobileController =new TextEditingController();
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

    mobileController.text =  widget.list[0];
    altmobileController.text =   widget.list[1];
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

  }

  @override
  void initState() {
    super.initState();

    initViews();

  }

  late ConnectivityResult _connectivityResult;

  @override
  Widget build(BuildContext context) {

    return Scaffold(key: _scaffoldKey,
        appBar: AppBar(
            title: Text('Contact Details' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
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
          Container(margin: EdgeInsets.only(top: 10) ,child:NumericTextField(icondata: Icons.phone_android, controller: mobileController, labelText:TranslationService.translate("mobile_no"), enabled: false)),
          SizedBox(height: 20,),
          NumericTextField(icondata: Icons.phone_android, controller: altmobileController, labelText: TranslationService.translate("alt_mobile_no"), enabled: false),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.email , controller: emailidController , labelText: TranslationService.translate("emailid"), enabled: false,),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.email , controller: altemailidController , labelText: TranslationService.translate("alt_emailid"), enabled: false,),
          SizedBox(height: 20,),
          CustomDropdown(icondata: MdiIcons.googleMaps  ,controller: countryController , labelText: TranslationService.translate("country") , onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValuesContacts(context , "country" , "") , "Select Country");
            countryController.text = value.label;
            country_value = value.value;

          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: MdiIcons.city  ,controller: permstateController , labelText: TranslationService.translate("perm_state"), onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet2(context, await Values.getValuesContactsState(context , "state" , "" , country_value) , "Select Country");
            permstateController.text = value.state_name;
            perm_State_value = value.Id;

            if(value.state_name.toLowerCase() == "other"){

              String state_name = "";
              DialogClass().showDailogwithTextField(context , "Enter Your Permanent State" , "Submit State" , "Enter State" , Icons.location_city , (p0) async {

                state_name = p0;

                print(state_name+"------"+country_value);

                final _response = await Provider.of<ApiService>(
                    context, listen: false).postInsertStateOther({"state_name": p0 , "country_id": country_value });

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
          CustomDropdown(icondata: MdiIcons.googleMaps  ,controller: workcountryController , labelText: TranslationService.translate("work_country") , onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet(context , await Values.getValuesContacts(context , "country" , "") , "Select Country");
            workcountryController.text = value.label;
            country_value2 = value.value;

          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: MdiIcons.city  ,controller: workstateController , labelText: TranslationService.translate("work_state"), onButtonPressed: () async {


            final value = await SingleSelectDialog().showBottomSheet2(context, await Values.getValuesContactsState(context , "state" , "" , country_value2) , "Select State");
            workstateController.text = value.state_name;
            work_state_value = value.Id;

            if(value.state_name.toLowerCase() == "other"){

              String state_name = "";
              DialogClass().showDailogwithTextField(context , "Enter Your Work State" , "Submit State" , "Enter State" , Icons.location_city , (p0) async {

                state_name = p0;

                final _response = await Provider.of<ApiService>(
                    context, listen: false).postInsertStateOther({"state_name": p0 , "country_id":country_value });

                if (_response.body["data"]["affectedRows"] == 1) {

                  workstateController.text = state_name;
                  work_state_value = _response.body["data"]["insertId"];

                }

              },);


            }

          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: MdiIcons.city  ,controller: workcityController , labelText: TranslationService.translate("work_city"), onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet3(context, await Values.getValuesContactsCity(context , work_state_value , country_value));
            workcityController.text = value.label;
            work_city_value = value.value;

            if(value.label.toLowerCase() == "other"){

              String city_name = "";
              DialogClass().showDailogwithTextField(context , "Enter Your Work City" , "Submit City" , "Enter City" , Icons.location_city , (p0) async {

                city_name = p0;

                final _response = await Provider.of<ApiService>(
                    context, listen: false).postInsertCityOther({"city_name": p0 , "state_id":work_state_value , "country_id":country_value });

                if (_response.body["data"]["affectedRows"] == 1) {

                  workcityController.text = city_name;
                  work_city_value = _response.body["data"]["insertId"];

                }

              },);


            }



          },),
          SizedBox(height: 20,),
          MultilineTextfield(icondata: MdiIcons.googleMaps, controller: permaddressController, labelText: TranslationService.translate("perm_address"), enabled: false, minlines: 3, maxlines: 5),
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
              String mobileNumberError = Validation.validateNotEmpty(
                  mobileController.text, 'Mobile Number').toString();
              String permanentAddressError = Validation.validateNotEmpty(
                  permaddressController.text, 'Permanent Address').toString();
              String emailIdError = Validation.validateNotEmpty(
                  emailidController.text, 'Email ID').toString();
              String alternateMobileError = Validation.validateNotEmpty(
                  altmobileController.text, 'Alternate Mobile').toString();
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
              String workStateError = Validation.validateNotEmpty(
                  workstateController.text, 'Work State').toString();
              String workCityError = Validation.validateNotEmpty(
                  workcityController.text, 'Work City').toString();


              if (
              mobileNumberError == "null" ||
                  permCountryError == "null" ||
                  permStateError == "null" ||
                  permCityError == "null" ) {
                DialogClass().showDialog2(
                    context, "Contact Details Submit Alert!",
                    "All fields are compulsory", "Ok");
              } else {

                List<Location> locations = await locationFromAddress(permaddressController.text.toString()+" "+permcityValue+", "+perm_State_value);

                SharedPreferences prefs = await SharedPreferences.getInstance();

                  EasyLoading.show(status: 'Please wait...');

                  print(locations[0].latitude.toString()+",,,,"+locations[0].longitude.toString());

                  final _response = await Provider.of<ApiService>(
                      context, listen: false)
                      .postContactDetailUpdate(
                      {
                        "mobile_number": mobileController.text.toString(),
                        "permanent_adddress": permaddressController.text
                            .toString(),
                        "whatsapp_number": "-----",
                        "current_address": "",
                        "emailid": emailidController.text.toString(),
                        "alternate_mobile": altmobileController.text.toString(),
                        "alternate_email": altemailidController.text.toString(),
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
                        "work_country": country_value2,
                        "work_state": work_state_value,
                        "work_city": work_city_value,
                        "location": locations[0].latitude.toString()+","+locations[0].longitude.toString(),
                        "Id": widget.list[17],
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
            },)
        ])))));


  }


}