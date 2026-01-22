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








class BasicDetails extends StatelessWidget {

  final String type;
  BasicDetails({required this.type});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BasicDetailsStateful(type),
      builder: EasyLoading.init(),
    );
  }
}


class BasicDetailsStateful extends StatefulWidget {

  final String type;
  BasicDetailsStateful(this.type);


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

  String firtname = "" , lastname = ""  , dob = "";
  String created_value = "" , marital_value = "" , caste_value = "" , subcaste_value = "" , mother_tongue_value = "" , lang_known_value = "" , nri_detail = "";

  @override
  void initState() {
    super.initState();

    EasyLoading.dismiss();

    initView();

  }

  String passdate = "";

  initView() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();


    print(prefs.getString(SharedPrefs.birthdate).toString()+"====()()");

    firstnameController.text = utils().replaceNull(prefs.getString(SharedPrefs.firstName).toString());
    lastnameController.text = utils().replaceNull(prefs.getString(SharedPrefs.lastname).toString());
   // dobController.text =   utils().replaceNull(prefs.getString(SharedPrefs.dob).toString());

    if(utils().replaceNull(prefs.getString(SharedPrefs.birthdate).toString()) != ""){
      dobController.text =  utils().formatGivenDate(prefs.getString(SharedPrefs.birthdate).toString());
    }

    passdate = prefs.getString(SharedPrefs.birthdate).toString();

    print(passdate+"-=-=-=-=-=");


    profilecreatedController.text =  utils().replaceNull(prefs.getString(SharedPrefs.createdBy).toString().split(",")[0]);
    casteController.text =   utils().replaceNull(prefs.getString(SharedPrefs.caste).toString().split(",")[0]);
    subcasteController.text =  utils().replaceNull(prefs.getString(SharedPrefs.subcaste).toString().split(",")[0]);
    langController.text  =   utils().replaceNull(prefs.getString(SharedPrefs.languageKnown).toString().split("*")[0]);
    mothertongueController.text =   utils().replaceNull(prefs.getString(SharedPrefs.motherTongue).toString().split(",")[0]);
    maritalController.text = utils().replaceNull(prefs.getString(SharedPrefs.maritalStatus).toString().split(",")[0]);

    firtname = prefs.getString(SharedPrefs.firstName).toString();
    lastname = prefs.getString(SharedPrefs.lastname).toString();
    dob = prefs.getString(SharedPrefs.birthdate).toString();
    created_value = prefs.getString(SharedPrefs.createdBy).toString().split(",")[1];
    marital_value = prefs.getString(SharedPrefs.maritalStatus).toString().split(",")[1];
    caste_value  = prefs.getString(SharedPrefs.caste).toString().split(",")[1];
    subcaste_value  = prefs.getString(SharedPrefs.subcaste).toString().split(",")[1];
    lang_known_value = prefs.getString(SharedPrefs.languageKnown).toString().split("*")[1];
    mother_tongue_value = prefs.getString(SharedPrefs.motherTongue).toString().split(",")[1];

    print(prefs.getString(SharedPrefs.birthdate).toString()+"====()()");

    setState(() {

      if(prefs.getString(SharedPrefs.isnri).toString() ==  "1"){
        isnri = true;
        nriController.text = prefs.getString(SharedPrefs.nri_details).toString();
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
        Container(margin: EdgeInsets.only(top: 10) ,child:CustomTextField(icondata: Icons.person  ,controller: firstnameController , labelText: TranslationService.translate("firstnameHint"), enabled: firtname.isEmpty ? false : true ,),),
        SizedBox(height: 20,),
        CustomTextField(icondata: Icons.person , controller: lastnameController , labelText: TranslationService.translate("enter_surname"), enabled: lastname.isEmpty ? false : true,),
        SizedBox(height: 20,),
        GestureDetector(onTap: () async {

          if(dob.isEmpty){

        final date =  await showDatePickerDialog(
            context: context,
            initialDate: DateTime(int.parse(dobController.text.split("-")[2].toString()), int.parse(dobController.text.split("-")[1].toString()), int.parse(dobController.text.split("-")[0].toString())),
            minDate: DateTime(1960, 10, 10),
            maxDate: DateTime(2024, 10, 30),
            currentDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
            selectedDate: DateTime(int.parse(dobController.text.split("-")[2].toString()), int.parse(dobController.text.split("-")[1].toString()), int.parse(dobController.text.split("-")[0].toString())),
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
          subcaste_value, 'Sub Caste');
      String languageError = Validation.validateNotEmpty(
          lang_known_value, 'Language Known');
      String motherTongueError = Validation.validateNotEmpty(
          mother_tongue_value, 'Mother Tongue');
      String maritalStatusError = Validation.validateNotEmpty(
          marital_value, 'Marital Status');

      if (firstNameError == "null" ||
          lastNameError == "null" ||
          dobError == "null" ||
          profileCreatedError == "null" ||
          casteError == "null" ||
          subCasteError == "null" ||
          languageError == "null" ||
          motherTongueError == "null" ||
          maritalStatusError == "null") {
        DialogClass().showDialog2(
            context, "Basic Details Submit Alert!", "All fields are compulsory",
            "Ok");
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        //print(prefs.getString(SharedPrefs.fullname).toString()+"{}{}{}{}");

        if (prefs.getString(SharedPrefs.fullname) == null) {
          EasyLoading.show(status: 'Please wait...');


          final _response = await Provider.of<ApiService>(
              context, listen: false)
              .postBasicDetail(
              {
                "fullname": firstnameController.text.toString() + " " +
                    lastnameController.text.toString(),
                "created_by": created_value,
                "dob": dobController.text,
                "age": calculateAge(DateTime(int.parse(passdate.toString().split("-")[0]) , int.parse(passdate.toString().split("-")[1]) , int.parse(passdate.toString().split("-")[2]))).toString(),
                "marital_status": marital_value,
                "religion": "Hindu",
                "caste": caste_value,
                "subcaste": subcaste_value,
                "language_known": lang_known_value,
                "mother_tongue": mother_tongue_value,
                "isnri" : isnri == false ? "0" : "1" ,
                "nri_detail" : nriController.text.toString(),
                "userId": prefs.getString(SharedPrefs.userId),
                "communityId": prefs.getString(SharedPrefs.communityId),
                "profileId": prefs.getString(SharedPrefs.profileid)
              }
          );

          if (_response.body["data"]["affectedRows"] == 1) {
            await prefs.setString(
                SharedPrefs.firstName, firstnameController.text.toString());
            await prefs.setString(
                SharedPrefs.lastname, lastnameController.text.toString());
            await prefs.setString(SharedPrefs.fullname , firstnameController.text.toString()+" "+lastnameController.text.toString());
            await prefs.setString(SharedPrefs.age , calculateAge(DateTime(int.parse(passdate.toString().split("-")[0]) , int.parse(passdate.toString().split("-")[1]) , int.parse(passdate.toString().split("-")[2]))).toString());

            await prefs.setString(
                SharedPrefs.createdBy, profilecreatedController.text
                .toString() + "," + created_value);
            await prefs.setString(
                SharedPrefs.dob, passdate
                .toString());
            await prefs.setString(
                SharedPrefs.maritalStatus, maritalController.text
                .toString() + "," + marital_value);
            await prefs.setString(SharedPrefs.caste, casteController.text
                .toString() + "," + caste_value);
            await prefs.setString(SharedPrefs.subcaste, subcasteController
                .text.toString() + "," + subcaste_value);
            await prefs.setString(SharedPrefs.languageKnown, langController
                .text.toString() + "*" + lang_known_value);
            await prefs.setString(
                SharedPrefs.motherTongue, mothertongueController.text
                .toString() + "," + mother_tongue_value);
            await prefs.setString(SharedPrefs.isnri, isnri == true ? "1" : "0");
            await prefs.setString(SharedPrefs.nri_details, nriController.text.toString());
            await prefs.setString(SharedPrefs.basic_details_id, _response
                .body["data"]["insertId"].toString());

            EasyLoading.dismiss();

            if (widget.type == "insert") {
              navService.pushNamed("/lifestyle_details", args: "insert");
            } else {
              navService.goBack();
            }
          } else {
            DialogClass().showDialog2(
                context, "Basic Details Submit Alert!",
                "Some problem occured Please try again", "Ok");
          }
        } else {
          EasyLoading.show(status: 'Please wait...');

          final _response = await Provider.of<ApiService>(
              context, listen: false)
              .postBasicDetailUpdate(
              {
                "fullname": firstnameController.text.toString() + " " +
                    lastnameController.text.toString(),
                "created_by": created_value,
                "dob": passdate,
                "age": calculateAge(DateTime(int.parse(passdate.toString().split("-")[0]) , int.parse(passdate.toString().split("-")[1]) , int.parse(passdate.toString().split("-")[2]))).toString(),
                "marital_status": marital_value,
                "religion": "Hindu",
                "caste": caste_value,
                "subcaste": subcaste_value,
                "isnri" : isnri == false ? "0" : "1" ,
                "nri_detail" : nriController.text.toString(),
                "language_known": lang_known_value,
                "mother_tongue": mother_tongue_value,
                "Id": prefs.getString(SharedPrefs.basic_details_id),
              }
          );


          print(_response.body.toString()+"---"+dobController.text.toString());

          if (_response.body["success"] == 1) {
            await prefs.setString(
                SharedPrefs.firstName, firstnameController.text.toString());
            await prefs.setString(
                SharedPrefs.lastname, lastnameController.text.toString());
            await prefs.setString(SharedPrefs.fullname , firstnameController.text.toString()+" "+lastnameController.text.toString());
            await prefs.setString(SharedPrefs.age , calculateAge(DateTime(int.parse(passdate.toString().split("-")[0]) , int.parse(passdate.toString().split("-")[1]) , int.parse(passdate.toString().split("-")[2]))).toString());
            await prefs.setString(
                SharedPrefs.createdBy, profilecreatedController.text
                .toString() + "," + created_value);
            await prefs.setString(
                SharedPrefs.dob, passdate
                .toString());
            await prefs.setString(
                SharedPrefs.maritalStatus, maritalController.text
                .toString() + "," + marital_value);
            await prefs.setString(SharedPrefs.caste, casteController.text
                .toString() + "," + caste_value);
            await prefs.setString(SharedPrefs.subcaste, subcasteController
                .text.toString() + "," + subcaste_value);
            await prefs.setString(SharedPrefs.languageKnown, langController
                .text.toString() + "*" + lang_known_value);
            await prefs.setString(
                SharedPrefs.motherTongue, mothertongueController.text
                .toString() + "," + mother_tongue_value);
            await prefs.setString(SharedPrefs.isnri, isnri == true ? "1" : "0");
            await prefs.setString(SharedPrefs.nri_details, nriController.text.toString());

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
