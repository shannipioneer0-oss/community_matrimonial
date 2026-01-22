import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/SingleSelectDialog.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/user_profile/ButtonSubmit.dart';
import 'package:community_matrimonial/screens/user_profile/CustomDropdown.dart';
import 'package:community_matrimonial/screens/user_profile/CustomTextField.dart';
import 'package:community_matrimonial/screens/user_profile/MultilineTextfield.dart';
import 'package:community_matrimonial/utils/Designs.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/data.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_utils/Values.dart';



class OccupationalDetail_Edit extends StatelessWidget {

  final List list;
  OccupationalDetail_Edit( this.list);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OccupationalDetailStateful(list),
      builder: EasyLoading.init(),
    );
  }
}


class OccupationalDetailStateful extends StatefulWidget {

  final List list;
  OccupationalDetailStateful(this.list);

  @override
  OccupationalDetailScreen createState() => OccupationalDetailScreen();

}

class OccupationalDetailScreen  extends State<OccupationalDetailStateful>{

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController occupationController =new TextEditingController();
  TextEditingController occupdetailsController =new TextEditingController();
  TextEditingController annualincomeController =new TextEditingController();
  TextEditingController employmenttypeController = new TextEditingController();
  TextEditingController officeaddressController = new TextEditingController();
  String  occupation_value = "" , annual_inconme = "" , employment_value = "" , occu_details = "" , office_address = "";

  late ConnectivityResult _connectivityResult;

  @override
  void initState() {
    super.initState();

   initView();

  }

  initView() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    occupationController.text =  widget.list[0] ;
    occupdetailsController.text = widget.list[1] ;
    annualincomeController.text =   widget.list[2] ;
    employmenttypeController.text =  widget.list[3] ;
    officeaddressController.text =   widget.list[4] ;

    occupation_value = widget.list[5] ;
    occu_details = widget.list[1] ;
    annual_inconme = widget.list[2] ;
    employment_value = widget.list[3] ;
    office_address = widget.list[4] ;


  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(key: _scaffoldKey,
    appBar: AppBar(
    title: Text('Occupational Details' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
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
    Container(margin: EdgeInsets.only(top: 10) ,child:CustomDropdown(icondata: Icons.sell  ,controller: occupationController , labelText: TranslationService.translate("occupation"), onButtonPressed: () async {

      final value = await SingleSelectDialog().showBottomSheetOccupation(context, await Values.getOccupationList(context , "education" , ""));
      occupationController.text = value.occupation;
      occupation_value = value.Id;

      if(value.occupation.toLowerCase() == "other"){

        String occupation = "";
        DialogClass().showDailogwithTextField(context , "Enter Your Occupation" , "Submit Occupation" , "Enter Occupation" , Icons.history_edu , (p0) async {

          occupation = p0;

          final _response = await Provider.of<ApiService>(
              context, listen: false).postInsertOccupationOther({"occupation": p0});

          if (_response.body["data"]["affectedRows"] == 1) {

            occupationController.text = occupation;
            occupation_value = _response.body["data"]["insertId"];

          }

        },);


      }


    },)),
    SizedBox(height: 20,),
    MultilineTextfield(icondata: Icons.details, controller: occupdetailsController, labelText: TranslationService.translate("occup_details"), enabled: false, minlines: 3, maxlines: 7),
    SizedBox(height: 20,),
      CustomTextField(icondata: Icons.sell  ,controller: annualincomeController , labelText: TranslationService.translate("annual_income"), enabled: false,),
      SizedBox(height: 20,),
      CustomDropdown(icondata: Icons.sell  ,controller: employmenttypeController , labelText: TranslationService.translate("employment_type"), onButtonPressed: () async {

        final value = await SingleSelectDialog().showBottomSheetSingle(context , Data().getEmploymnetType() , TranslationService.translate("employment_type"));
        employmenttypeController.text = value;
        employment_value =  value;

      },),
      SizedBox(height: 20,),
      MultilineTextfield(icondata: Icons.location_city, controller: officeaddressController, labelText: TranslationService.translate("office_address"), enabled: false, minlines: 3, maxlines: 7),
      SizedBox(height: 20,),
      ButtonSubmit(text: 'Submit Occupational Details', onButtonPressed: () async {


   ConnectivityResult result = await Connectivity().checkConnectivity();
            setState(() {
              _connectivityResult = result;
            });
    if (_connectivityResult == ConnectivityResult.none) {
    DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");
    }else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (widget.list[0] == null) {
        EasyLoading.show(status: 'Please wait...');

        final _response = await Provider.of<ApiService>(
            context, listen: false)
            .postOccupationInsert(
            {
              "occupation_list": occupation_value,
              "occupation_detail": occupdetailsController.text.toString(),
              "annual_income": annualincomeController.text.toString(),
              "employment_type": employmenttypeController.text.toString(),
              "office_address": officeaddressController.text.toString(),
              "userId": widget.list[7],
              "communityId": prefs.getString(SharedPrefs.communityId),
              "profileId": widget.list[8],
            }
        );

        if (_response.body["data"]["affectedRows"] == 1) {

          EasyLoading.dismiss();
            navService.goBack();

        } else {
          EasyLoading.dismiss();

          DialogClass().showDialog2(
              context, "Occupational Details Submit Alert!",
              "Some problem occured Please try again", "Ok");
        }
      } else {
        EasyLoading.show(status: 'Please wait...');

        final _response = await Provider.of<ApiService>(
            context, listen: false)
            .postOccupationUpdate(
            {
              "occupation_list": occupation_value,
              "occupation_detail": occupationController.text.toString(),
              "annual_income": annualincomeController.text.toString(),
              "employment_type": employmenttypeController.text.toString(),
              "office_address": officeaddressController.text.toString(),
              "Id": widget.list[6],
            }
        );

        if (_response.body["success"] == 1) {

          EasyLoading.dismiss();
          navService.goBack();
        } else {
          EasyLoading.dismiss();


          DialogClass().showDialog2(
              context, "Occupational Details Submit Alert!",
              "Some problem occured Please try again", "Ok");
        }
      }
    }

      },)
    ])))));

  }


}