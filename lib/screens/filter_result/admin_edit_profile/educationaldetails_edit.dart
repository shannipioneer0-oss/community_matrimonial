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



class EducationalDetails_Edit extends StatelessWidget {

  final List list;
  EducationalDetails_Edit( this.list);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EducationalDetailStateful(list),
      builder: EasyLoading.init(),
    );
  }
}


class EducationalDetailStateful extends StatefulWidget {

  final List list;
  EducationalDetailStateful(this.list);

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

     initViews();

  }

  initViews() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _isCheckedadminstraive =   widget.list[0] == "0" || widget.list[0] == null ? false : true;
      _isCheckedreputed =   widget.list[2] == "0" || widget.list[2] == null  ? false : true;
    });

    admiistrativeController.text = widget.list[1];

    highesteducationController.text =  widget.list[4];
    edudetailsController.text =   widget.list[5];
    raputedController.text =  widget.list[3];


    reputed_edu_value =  widget.list[6];
    highest_edu_value =  widget.list[7];



  }

  late ConnectivityResult _connectivityResult;

  @override
  Widget build(BuildContext context) {

    return Scaffold(key: _scaffoldKey,
    appBar: AppBar(
    title: Text('Educational Details' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
    toolbarOpacity: 1,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: IconButton(
    icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
    onPressed: () {

      navService.goBack();

    },
    )),


    body:  SafeArea(child: SingleChildScrollView(child:Container(margin: EdgeInsets.only(left: 15 ,right: 15) ,child:Column(children: [

        Divider(),
        Container(margin: EdgeInsets.only(top: 10) ,child:Row(
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

      },),
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

          EasyLoading.show(status: 'Please wait...');

          final _response = await Provider.of<ApiService>(
              context, listen: false)
              .postEducationUpdate(
              {
                "is_from_admin_service": _isCheckedadminstraive == false
                    ? 0
                    : 1,
                "admin_position_name": admiistrativeController.text.toString(),
                "is_from_iit_iim_nit": _isCheckedreputed == false ? 0 : 1,
                "college_name": reputed_edu_value,
                "education_list": highest_edu_value,
                "education_detail": edudetailsController.text.toString(),
                "Id": widget.list[8]
              }
          );



          if (_response.body["success"] == 1) {


            EasyLoading.dismiss();
            navService.goBack();
          } else {
            EasyLoading.dismiss();
          }

      } else {
        DialogClass().showDialog2(context, "Education Details Submit Alert!",
            "All fields are compulsory", "Ok");
      }
    }
    },)

    ])))));


  }





}
