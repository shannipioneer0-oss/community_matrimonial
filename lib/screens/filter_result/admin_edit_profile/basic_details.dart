import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/MultiSelectDialog.dart';
import 'package:community_matrimonial/app_utils/SingleSelectDialog.dart';
import 'package:community_matrimonial/app_utils/Values.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/model/marital_status.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/filter/StylishCheckbox.dart';
import 'package:community_matrimonial/screens/user_profile/ButtonSubmit.dart';
import 'package:community_matrimonial/screens/user_profile/CustomDropdown.dart';
import 'package:community_matrimonial/screens/user_profile/CustomTextField.dart';
import 'package:community_matrimonial/screens/user_profile/MultilineTextfield.dart';
import 'package:community_matrimonial/utils/Designs.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:community_matrimonial/utils/validation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../network_utils/model/DataFetch.dart';








class BasicDetailsEdit extends StatelessWidget {

  final List list;
  BasicDetailsEdit( this.list);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BasicDetailsStateful(list),
      builder: EasyLoading.init(),
    );
  }
}


class BasicDetailsStateful extends StatefulWidget {

  final List list;
  BasicDetailsStateful(this.list);


  @override
  BasicDetailsScreen createState() => BasicDetailsScreen();

}

class BasicDetailsScreen  extends State<BasicDetailsStateful>{

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController firstnameController =new TextEditingController();
  TextEditingController lastnameController =new TextEditingController();
  TextEditingController dobController =new TextEditingController();
  TextEditingController profilecreatedController = new TextEditingController();
  TextEditingController maritalController = new TextEditingController();
  TextEditingController casteController = new TextEditingController();
  TextEditingController subcasteController = new TextEditingController();
  TextEditingController langController = new TextEditingController();
  TextEditingController mothertongueController = new TextEditingController();
  TextEditingController nriController = new TextEditingController();

  String firtname = "" , lastname = ""  , dob = "" ,passdate = "";
  String created_value = "" , marital_value = "" , caste_value = "" , subcaste_value = "" , mother_tongue_value = "" , lang_known_value = "";

  @override
  void initState() {
    super.initState();

    initView();

  }

  initView() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(widget.list[2]+"-=-={}{}");

    firstnameController.text = widget.list[0] ;
    lastnameController.text = widget.list[1];
    dobController.text =  widget.list[2] == "" ? "" : utils().formatGivenDate(widget.list[2]);
    profilecreatedController.text =  widget.list[3];
    maritalController.text = widget.list[4];
    casteController.text =  widget.list[5] ;
    subcasteController.text =  widget.list[6];
    langController.text  =   widget.list[7];
    mothertongueController.text = widget.list[8];

    passdate = widget.list[2];


    firtname = widget.list[0] ;
    lastname = widget.list[1];
    dob      =   widget.list[2];
    created_value = widget.list[9];
    marital_value = widget.list[10];
    caste_value  = widget.list[11];
    subcaste_value  = widget.list[12];
    lang_known_value = widget.list[13];
    mother_tongue_value = widget.list[14];

    setState(() {
      if(widget.list[16] ==  "1"){
        isnri = true;
        nriController.text = widget.list[17];
      }else{
        isnri = false;
      }
    });

  }


  late ConnectivityResult _connectivityResult;

  bool isnri = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(key: _scaffoldKey,
        appBar: AppBar(
            title: Text('Basic Details\nRavaldev Matrimony' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
            toolbarOpacity: 1,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
              onPressed: () {

                navService.goBack();

              },
            )),


        body:SafeArea(child: SingleChildScrollView(child:Container(margin: EdgeInsets.only(left: 15 ,right: 15) ,child:Column(children: [

          Divider(),
          Container(margin: EdgeInsets.only(top: 10) ,child:CustomTextField(icondata: Icons.person  ,controller: firstnameController , labelText: TranslationService.translate("firstnameHint"), enabled: firtname.isEmpty ? false : false ,),),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.person , controller: lastnameController , labelText: TranslationService.translate("enter_surname"), enabled: lastname.isEmpty ? false : false,),
          SizedBox(height: 20,),
          GestureDetector(onTap: () async {

//print(dob.split("-")[2].toString());

            if(dob.isEmpty || dob.isNotEmpty){

              final date =  await showDatePickerDialog(
                context: context,
                initialDate: dobController.text.toString().isNotEmpty ? DateTime(int.parse(dob.split("-")[0].toString()), int.parse(dob.split("-")[1].toString()), int.parse(dob.split("-")[2].toString())) : DateTime(DateTime.now().year , DateTime.now().month , DateTime.now().day),
                minDate: DateTime(1940, 10, 10),
                maxDate: DateTime(2050, 10, 30),
                currentDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                selectedDate: dobController.text.toString().isNotEmpty ? DateTime(int.parse(dob.split("-")[0].toString()), int.parse(dob.split("-")[1].toString()), int.parse(dob.split("-")[2].toString())) : DateTime(DateTime.now().year , DateTime.now().month , DateTime.now().day),
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
                String day = "",
                    month = "";

                if (date.day
                    .toString()
                    .length < 2) {
                  day = "0" + date.day.toString();
                } else {
                  day = date.day.toString();
                }

                if (date.month
                    .toString()
                    .length < 2) {
                  month = "0" + date.month.toString();
                } else {
                  month = date.month.toString();
                }


                passdate = date.year.toString()+"-"+month+"-"+day;
                dobController.text = date.year.toString() + "-" + month + "-" + day;
              }


            }

          }  ,child:CustomTextField(icondata: Icons.date_range_sharp ,controller: dobController , labelText: TranslationService.translate("date_of_birth"), enabled: true,),),
          SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.person  ,controller: profilecreatedController , labelText: TranslationService.translate("profile_created_by"), onButtonPressed: () async {


            EasyLoading.show(status: 'Please wait...');
            List<DataFetch> listitem = await Values.getValues(context , "created_by" , "");
            EasyLoading.dismiss();

            final value = await SingleSelectDialog().showBottomSheet(context, listitem , "Select Profile Created by");
            profilecreatedController.text = value.label;
            created_value = value.value;




          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: MdiIcons.heart  ,controller: maritalController , labelText: TranslationService.translate("marital_status"), onButtonPressed: () async {

            EasyLoading.show(status: 'Please wait...');
            List<DataFetch> listitem =  await Values.getValues(context , "marital_status" , "");

            EasyLoading.dismiss();

            final value = await SingleSelectDialog().showBottomSheet(context, listitem , "Select Marital Status");
            maritalController.text = value.label;
            marital_value = value.value;

          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.person  ,controller: casteController , labelText: TranslationService.translate("caste"), onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "caste" , "") , "Select Caste");
            casteController.text = value.label;
            caste_value = value.value;


          },),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.person , controller: subcasteController , labelText: TranslationService.translate("shakh"), enabled: false,),

          /* SizedBox(height: 20,),
        CustomDropdown(icondata: Icons.language  ,controller: langController , labelText: TranslationService.translate("lang_known"), onButtonPressed: () async {

         MultiSelectDialogWithBottomSheet().showMultiSelect(context , await Values.getValuesMultiple(context , "languages" , "") , langController , "Select Languages", callback: (String newData) {
           lang_known_value = newData;
         },);




        },),
        SizedBox(height: 20,),
        CustomDropdown(icondata: Icons.language  ,controller: mothertongueController , labelText: TranslationService.translate("mother_tongue"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "mother_tongue" , "") , "Select Languages");
          mothertongueController.text = value.label;
          mother_tongue_value = value.value;

        },),
        SizedBox(height: 20,),
        Row(
          children: [
            StylishCheckbox(
              value: isnri,
              onChanged: (bool value) {
                setState(() {
                  isnri = value;
                });
              },
            ),
            SizedBox(width: 10.0),
            Text(
              TranslationService.translate("is_nri"),
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        SizedBox(height: 20,),
        isnri == true ? MultilineTextfield(icondata: MdiIcons.details, controller: nriController, labelText: TranslationService.translate("nri_details"), enabled: false, minlines: 3, maxlines: 7) : Container(),
        SizedBox(height: isnri == true ? 30 : 0,),*/

          SizedBox(height: 20,),
          ButtonSubmit(text: 'Submit Basic Details', onButtonPressed: () async {

            print("valuessssssssssssssss");

            ConnectivityResult result = await Connectivity().checkConnectivity();
            setState(() {
              _connectivityResult = result;
            });
            if (_connectivityResult == ConnectivityResult.none) {

              DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");

            }else {
              String firstNameError = Validation.validateNotEmpty(
                  firstnameController.text.toString(), 'First Name');
              String lastNameError = Validation.validateNotEmpty(
                  lastnameController.text.toString(), 'Last Name');
              String dobError = Validation.validateNotEmpty(
                  dobController.text.toString(), 'Date of Birth');
              String profileCreatedError = Validation.validateNotEmpty(
                  created_value, 'Profile Created By');
              String casteError = Validation.validateNotEmpty(caste_value, 'Caste');
              String subCasteError = Validation.validateNotEmpty(
                  subcasteController.text.toString(), 'Sub Caste');
              String languageError = Validation.validateNotEmpty(
                  lang_known_value, 'Language Known');
              String motherTongueError = Validation.validateNotEmpty(
                  mother_tongue_value, 'Mother Tongue');
              String maritalStatusError = Validation.validateNotEmpty(
                  marital_value, 'Marital Status');

              print(firstNameError+"---"+lastNameError+"----"+dobError+"-----"+profileCreatedError+"---"+casteError+"----"+subCasteError+"---"+maritalStatusError);

              if (firstNameError == "null" ||
                  lastNameError == "null" ||
                  dobError == "null" ||
                  profileCreatedError == "null" ||
                  casteError == "null" ||
                  subCasteError == "null" ||
                  maritalStatusError == "null") {
                DialogClass().showDialog2(
                    context, "Basic Details Submit Alert!", "All fields are compulsory",
                    "Ok");
              } else {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                //print(prefs.getString(SharedPrefs.fullname).toString()+"{}{}{}{}");

                if (widget.list[0] ==  "") {
                  EasyLoading.show(status: 'Please wait...');

                  print( {
                    "fullname": firstnameController.text.toString() + " " +
                        lastnameController.text.toString(),
                    "created_by": created_value,
                    "dob": passdate,
                    "age": calculateAge( passdate.toString().isEmpty ? DateTime(int.parse(dobController.text.toString().split("-")[0]) , int.parse(dobController.text.toString().split("-")[1]) , int.parse(dobController.text.toString().split("-")[2]))  :  DateTime(int.parse(passdate.toString().split("-")[0]) , int.parse(passdate.toString().split("-")[1]) , int.parse(passdate.toString().split("-")[2]))).toString(),
                    "marital_status": marital_value,
                    "religion": "Hindu",
                    "caste": caste_value,
                    "subcaste": subcasteController.text.toString(),
                    "language_known": lang_known_value,
                    "mother_tongue": mother_tongue_value,
                    "isnri" : isnri == false ? "0" : "1" ,
                    "nri_detail" : nriController.text.toString(),
                    "userId": widget.list[18][0],
                    "communityId": prefs.getString(SharedPrefs.communityId),
                    "profileId": widget.list[19]
                  });


                  final _response = await Provider.of<ApiService>(
                      context, listen: false)
                      .postBasicDetail(
                      {
                        "fullname": firstnameController.text.toString() + " " +
                            lastnameController.text.toString(),
                        "created_by": created_value,
                        "dob": passdate.toString().isEmpty ?  dobController.text.toString() : passdate,
                        "age": calculateAge( passdate.toString().isEmpty ? DateTime(int.parse(dobController.text.toString().split("-")[0]) , int.parse(dobController.text.toString().split("-")[1]) , int.parse(dobController.text.toString().split("-")[2]))  :  DateTime(int.parse(passdate.toString().split("-")[0]) , int.parse(passdate.toString().split("-")[1]) , int.parse(passdate.toString().split("-")[2]))).toString(),
                        "marital_status": marital_value,
                        "religion": "Hindu",
                        "caste": caste_value,
                        "subcaste": subcasteController.text.toString(),
                        "language_known": lang_known_value,
                        "mother_tongue": mother_tongue_value,
                        "isnri" : isnri == false ? "0" : "1" ,
                        "nri_detail" : nriController.text.toString(),
                        "userId": widget.list[18][0],
                        "communityId": prefs.getString(SharedPrefs.communityId),
                        "profileId": widget.list[19]
                      }
                  );

                  if (_response.body["data"]["affectedRows"] == 1) {

                    EasyLoading.dismiss();

                      navService.goBack();

                  } else {

                    EasyLoading.dismiss();

                    DialogClass().showDialog2(
                        context, "Basic Details Submit Alert!",
                        "Some problem occured Please try again", "Ok");
                  }
                } else {
                  EasyLoading.show(status: 'Please wait...');

                  print(widget.list[15]+"[][]");

                  final _response = await Provider.of<ApiService>(
                      context, listen: false)
                      .postBasicDetailUpdate(
                      {
                        "fullname": firstnameController.text.toString() + " " +
                            lastnameController.text.toString(),
                        "created_by": created_value,
                        "dob": passdate,
                        "age": calculateAge( passdate.toString().isEmpty ? DateTime(int.parse(dobController.text.toString().split("-")[0]) , int.parse(dobController.text.toString().split("-")[1]) , int.parse(dobController.text.toString().split("-")[2]))  :  DateTime(int.parse(passdate.toString().split("-")[0]) , int.parse(passdate.toString().split("-")[1]) , int.parse(passdate.toString().split("-")[2]))).toString(),
                        "marital_status": marital_value,
                        "religion": "Hindu",
                        "caste": caste_value,
                        "subcaste": subcasteController.text.toString(),
                        "isnri" : isnri == false ? "0" : "1" ,
                        "nri_detail" : nriController.text.toString(),
                        "language_known": lang_known_value,
                        "mother_tongue": mother_tongue_value,
                        "Id": widget.list[15],
                      }
                  );


                  print(_response.body.toString()+"---"+dobController.text.toString());

                  if (_response.body["success"] == 1) {

                    EasyLoading.dismiss();
                    navService.goBack();

                  } else {

                    EasyLoading.dismiss();

                    DialogClass().showDialog2(context, "Basic Details Submit Alert!",
                        "Some problem occured Please try again", "Ok");

                  }
                }
              }
            }


          },)

        ],)),
        )));

  }


  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();

    int age = currentDate.year - birthDate.year;

    // Check if the birthdate has occurred this year
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }




}
