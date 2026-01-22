import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/SingleSelectDialog.dart';
import 'package:community_matrimonial/app_utils/Values.dart';
import 'package:community_matrimonial/screens/filter/StylishCheckbox.dart';
import 'package:community_matrimonial/screens/user_profile/ButtonSubmit.dart';
import 'package:community_matrimonial/screens/user_profile/CustomDropdown.dart';
import 'package:community_matrimonial/screens/user_profile/CustomTextField.dart';
import 'package:community_matrimonial/screens/user_profile/MultilineTextfield.dart';
import 'package:community_matrimonial/screens/user_profile/NumericFields.dart';
import 'package:community_matrimonial/utils/Designs.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../locale/TranslationService.dart';
import '../../../network_utils/service/api_service.dart';



class EducationalDetails extends StatelessWidget {

  final String type;
  EducationalDetails({required this.type});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EducationalDetailStateful(type),
      builder: EasyLoading.init(),
    );
  }
}


class EducationalDetailStateful extends StatefulWidget {

  final String type;
  EducationalDetailStateful(this.type);

  @override
  EducationalDetailScreen createState() => EducationalDetailScreen();

}

class EducationalDetailScreen  extends State<EducationalDetailStateful>{

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController  admiistrativeController =new TextEditingController();
  TextEditingController raputedController =new TextEditingController();
  TextEditingController highesteducationController =new TextEditingController();
  TextEditingController edudetailsController = new TextEditingController();

  bool _isCheckedadminstraive = false , _isCheckedreputed = false;
  String highest_edu_value = "" ,    reputed_edu_value = "" ;

  @override
  void initState() {
    super.initState();

    EasyLoading.dismiss();

     initViews();

  }

  initViews() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    highesteducationController.text =  utils().replaceNull(prefs.getString(SharedPrefs.education).toString().split(",")[0]);
    edudetailsController.text =   utils().replaceNull(prefs.getString(SharedPrefs.educationDetail).toString());
    raputedController.text =  utils().replaceNull(prefs.getString(SharedPrefs.instituteName).toString().split(",")[0]);
    admiistrativeController.text =   utils().replaceNull(prefs.getString(SharedPrefs.adminPositionName).toString());

    setState(() {
      _isCheckedreputed =   prefs.getString(SharedPrefs.isFromIITIIMNIT).toString() == "0" || prefs.getString(SharedPrefs.isFromIITIIMNIT) == null  ? false : true;
      _isCheckedadminstraive =   prefs.getString(SharedPrefs.isFromAdminService).toString() == "0" || prefs.getString(SharedPrefs.isFromAdminService) == null ? false : true;
    });

    highest_edu_value = prefs.getString(SharedPrefs.education).toString().split(",")[1];
    reputed_edu_value =  prefs.getString(SharedPrefs.instituteName).toString().split(",")[1];


  }

  late ConnectivityResult _connectivityResult;

  @override
  Widget build(BuildContext context) {

    return Scaffold(key: _scaffoldKey,
    appBar: AppBar(
    title: Text('Educational Details\nRavaldev Matrimony' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
    toolbarOpacity: 1,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: IconButton(
    icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
    onPressed: () {

      navService.goBack();

    },
    )),


    body:SingleChildScrollView(child:Container(margin: EdgeInsets.only(left: 15 ,right: 15) ,child:Column(children: [

        Divider(),
      /*Container(margin: EdgeInsets.only(top: 10) ,child:Row(
          children: [
            StylishCheckbox(
              value: _isCheckedadminstraive,
              onChanged: (bool value) {
                setState(() {
                  _isCheckedadminstraive = value;
                });
              },
            ),
            SizedBox(width: 10.0),
            Text(
              TranslationService.translate("is_administrative"),
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),),
      SizedBox(height: 20,),
      CustomTextField(icondata: Icons.admin_panel_settings , controller: admiistrativeController , labelText: Strings.admin_position_name, enabled: false,),
      SizedBox(height: 20,),
      Row(
        children: [
          StylishCheckbox(
            value: _isCheckedreputed,
            onChanged: (bool value) {
              setState(() {
                _isCheckedreputed = value;
              });
            },
          ),
          SizedBox(width: 10.0),
          Text(
            TranslationService.translate("is_reputed_university"),
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
      SizedBox(height: 20,),
      CustomDropdown(icondata: MdiIcons.bookEducation  ,controller: raputedController , labelText: TranslationService.translate("reputed_university"), onButtonPressed: () async {

        final value = await SingleSelectDialog().showBottomSheetInstitute(context, await Values.getReputedUniveristy(context , "education" , ""));
        raputedController.text = value.institute_name;
        reputed_edu_value = value.Id;

      },),*/
      SizedBox(height: 20,),
      CustomDropdown(icondata: MdiIcons.bookEducation  ,controller: highesteducationController , labelText: TranslationService.translate("highest_education"), onButtonPressed: () async {


        final value = await SingleSelectDialog().showBottomSheetEducation(context, await Values.getEducationList(context , "education" , ""));
        highesteducationController.text = value.degree_name;
        highest_edu_value = value.Id;

        if(value.degree_name.toLowerCase() == "other"){

          String education = "";
          DialogClass().showDailogwithTextField(context , "Enter Your EDucation" , "Submit Education" , "Enter Education" , Icons.history_edu , (p0) async {

            education = p0;



            final _response = await Provider.of<ApiService>(
                context, listen: false).postInsertEducationOther({"degree_name": p0});

            if (_response.body["data"]["affectedRows"] == 1) {

              highesteducationController.text = education;
              highest_edu_value = _response.body["data"]["insertId"];

            }

          },);


        }


      },),
      SizedBox(height: 20,),
      MultilineTextfield(icondata: Icons.history_edu, controller: edudetailsController, labelText: TranslationService.translate("educational_details"), enabled: false, minlines: 3, maxlines: 7),
      SizedBox(height: 20,),
      ButtonSubmit(text: 'Submit Educational Details', onButtonPressed: () async {


   ConnectivityResult result = await Connectivity().checkConnectivity();
            setState(() {
              _connectivityResult = result;
            });
    if (_connectivityResult == ConnectivityResult.none) {
    DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");
    }else {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (highesteducationController.text
          .toString()
          .length > 0) {
        if (prefs
            .getString(SharedPrefs.education) == null) {
          EasyLoading.show(status: 'Please wait...');

          final _response = await Provider.of<ApiService>(
              context, listen: false)
              .postInserteducation(
              {
                "is_from_admin_service": _isCheckedadminstraive == false
                    ? 0
                    : 1,
                "admin_position_name": "",
                "is_from_iit_iim_nit": _isCheckedreputed == false ? 0 : 1,
                "college_name": "",
                "education_list": highest_edu_value,
                "education_detail": edudetailsController.text.toString(),
                "userId": prefs.getString(SharedPrefs.userId),
                "communityId": prefs.getString(SharedPrefs.communityId),
                "profileId": prefs.getString(SharedPrefs.profileid)
              }
          );

          if (_response.body["data"]["affectedRows"] == 1) {
            await prefs.setString(SharedPrefs.isFromAdminService,
                _isCheckedadminstraive == false ? "0" : "1");
            await prefs.setString(SharedPrefs.adminPositionName,
                admiistrativeController.text.toString());
            await prefs.setString(SharedPrefs.isFromIITIIMNIT,
                _isCheckedreputed == false ? "0" : "1");
            await prefs.setString(SharedPrefs.instituteName, raputedController
                .text.toString());
            await prefs.setString(SharedPrefs.education,
                highesteducationController.text.toString());
            await prefs.setString(SharedPrefs.educationDetail,
                edudetailsController.text.toString());
            await prefs.setString(SharedPrefs.education_id,
                _response
                    .body["data"]["insertId"].toString());


            EasyLoading.dismiss();

            if (widget.type == "insert") {
              navService.pushNamed("/occuaptional_details", args: "insert");
            } else {
              navService.goBack();
            }
          } else {
            DialogClass().showDialog2(
                context, "Educational Details Submit Alert!",
                "All fields are compulsory", "Ok");
          }
        } else {
          EasyLoading.show(status: 'Please wait...');

          final _response = await Provider.of<ApiService>(
              context, listen: false)
              .postEducationUpdate(
              {
                "is_from_admin_service": _isCheckedadminstraive == false
                    ? 0
                    : 1,
                "admin_position_name": "",
                "is_from_iit_iim_nit": _isCheckedreputed == false ? 0 : 1,
                "college_name": "",
                "education_list": highest_edu_value,
                "education_detail": edudetailsController.text.toString(),
                "Id": prefs.getString(SharedPrefs.education_id),
              }
          );

          print({
            "is_from_admin_service": _isCheckedadminstraive == false ? 0 : 1,
            "admin_position_name": admiistrativeController.text.toString(),
            "is_from_iit_iim_nit": _isCheckedreputed == false ? 0 : 1,
            "college_name": reputed_edu_value,
            "education_list": highest_edu_value,
            "education_detail": edudetailsController.text.toString(),
            "Id": prefs.getString(SharedPrefs.education_id),
          }.toString() + "  ----- " + _response.body.toString());

          if (_response.body["success"] == 1) {
            await prefs.setString(SharedPrefs.isFromAdminService,
                _isCheckedadminstraive == false ? "0" : "1");
            await prefs.setString(SharedPrefs.adminPositionName,
                admiistrativeController.text.toString());
            await prefs.setString(SharedPrefs.isFromIITIIMNIT,
                _isCheckedreputed == false ? "0" : "1");
            await prefs.setString(SharedPrefs.instituteName, raputedController
                .text.toString() + "," + reputed_edu_value);
            await prefs.setString(SharedPrefs.education,
                highesteducationController.text.toString() + "," +
                    highest_edu_value);
            await prefs.setString(SharedPrefs.educationDetail,
                edudetailsController.text.toString());


            EasyLoading.dismiss();
            navService.goBack();
          } else {
            EasyLoading.dismiss();
          }
        }
      } else {
        DialogClass().showDialog2(context, "Education Details Submit Alert!",
            "All fields are compulsory", "Ok");
      }
    }
    },)

    ]))));


  }





}
