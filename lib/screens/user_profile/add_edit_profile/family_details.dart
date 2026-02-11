import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/SingleSelectDialog.dart';
import 'package:community_matrimonial/app_utils/Values.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/user_profile/ButtonSubmit.dart';
import 'package:community_matrimonial/screens/user_profile/CustomDropdown.dart';
import 'package:community_matrimonial/screens/user_profile/CustomTextField.dart';
import 'package:community_matrimonial/screens/user_profile/MultilineTextfield.dart';
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
import '../../../utils/data.dart';
import '../../../utils/universalback_wrapper.dart';



class FamilyDetails extends StatelessWidget {

  final String type;
  FamilyDetails({required this.type});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FamilyDetailsStateful(type),
      builder: EasyLoading.init(),
    );
  }
}


class FamilyDetailsStateful extends StatefulWidget {

  final String type;
  FamilyDetailsStateful(this.type);

  @override
  FamilyDetailScreen createState() => FamilyDetailScreen();

}

class FamilyDetailScreen  extends State<FamilyDetailsStateful>{

  GlobalKey<ScaffoldState> _scaffoldKey7 = GlobalKey<ScaffoldState>();

  TextEditingController familyvalueController =new TextEditingController();
  TextEditingController familytypeController =new TextEditingController();
  TextEditingController no_brother =new TextEditingController();
  TextEditingController no_sister = new TextEditingController();
  TextEditingController no_married_bro = new TextEditingController();
  TextEditingController no_married_sister = new TextEditingController();
  TextEditingController father_name = new TextEditingController();
  TextEditingController mother_name = new TextEditingController();
  TextEditingController father_occupation = new TextEditingController();
  TextEditingController mother_occupation = new TextEditingController();
  TextEditingController house_owned = new TextEditingController();
  TextEditingController family_status = new TextEditingController();
  TextEditingController house_type = new TextEditingController();
  TextEditingController family_slogan = new TextEditingController();

  TextEditingController shakhController = new TextEditingController();
  TextEditingController nativeController = new TextEditingController();
  TextEditingController native_address = new TextEditingController();
  TextEditingController moshal_sakh = new TextEditingController();
  TextEditingController moshal_native = new TextEditingController();



  String fml_value = "" , fml_type = "" , fml_status = "",  house_type_value = "", house_owned_value = "";

  late ConnectivityResult _connectivityResult;
  @override
  void initState() {
    super.initState();

    EasyLoading.dismiss();

    initViews();

  }

  initViews() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    familyvalueController.text =  utils().replaceNull(prefs.getString(SharedPrefs.familyValue).toString().split(",")[0]);
    familytypeController.text = utils().replaceNull(prefs.getString(SharedPrefs.familyType).toString().split(",")[0]);
    family_status.text = utils().replaceNull(prefs.getString(SharedPrefs.familyStatus).toString().split(",")[0]);
    house_owned.text = utils().replaceNull(prefs.getString(SharedPrefs.houseOwned).toString().split(",")[0]);
    house_type.text = utils().replaceNull(prefs.getString(SharedPrefs.houseType).toString().split(",")[0]);
    no_brother.text = utils().replaceNull(prefs.getString(SharedPrefs.noBrother).toString());
    no_sister.text = utils().replaceNull(prefs.getString(SharedPrefs.noSister).toString());
    no_married_bro.text = utils().replaceNull(prefs.getString(SharedPrefs.marriedBrother).toString());
    no_married_sister.text =  utils().replaceNull(prefs.getString(SharedPrefs.marriedSister).toString());
    father_name.text = utils().replaceNull(prefs.getString(SharedPrefs.fatherName).toString());
    mother_name.text = utils().replaceNull(prefs.getString(SharedPrefs.motherName).toString());
    father_occupation.text = utils().replaceNull(prefs.getString(SharedPrefs.fatherOccupation).toString());
    mother_occupation.text = utils().replaceNull(prefs.getString(SharedPrefs.motherOccupation).toString());
   // family_slogan.text = utils().replaceNull(prefs.getString(SharedPrefs.detailFamily).toString());

    shakhController.text = utils().replaceNull(prefs.getString(SharedPrefs.sakh).toString());
    nativeController.text = utils().replaceNull(prefs.getString(SharedPrefs.native).toString());
    native_address.text = utils().replaceNull(prefs.getString(SharedPrefs.native_address).toString());
    moshal_sakh.text = utils().replaceNull(prefs.getString(SharedPrefs.moshal_sakh).toString());
    moshal_native.text = utils().replaceNull(prefs.getString(SharedPrefs.moshal_native).toString());

    fml_value = prefs.getString(SharedPrefs.familyValue).toString().split(",")[1];
    fml_type = prefs.getString(SharedPrefs.familyType).toString().split(",")[1];
    fml_status = prefs.getString(SharedPrefs.familyStatus).toString().split(",")[1];
    house_type_value = prefs.getString(SharedPrefs.houseType).toString().split(",")[1];
    house_owned_value = prefs.getString(SharedPrefs.houseOwned).toString();


  }


  @override
  Widget build(BuildContext context) {

    return UniversalBackWrapper(
        isRoot: false

        ,child:Scaffold(key: _scaffoldKey7,
        appBar: AppBar(
            title: Text('Family Details\nRavaldev Matrimony' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
            toolbarOpacity: 1,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
              onPressed: () {

                navService.goBack();

              },
            )),


        body:SafeArea(child:SingleChildScrollView(child:Container(margin: EdgeInsets.only(left: 15 ,right: 15) ,child:Column(children: [

          Divider(),
         /* Container(margin: EdgeInsets.only(top: 10) ,child:CustomDropdown(icondata: Icons.family_restroom, controller: familyvalueController, labelText: TranslationService.translate("family_values"), onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "fml_value" , "") , "Select Family Value");
            familyvalueController.text = value.label;
            fml_value = value.value;

          },),),
          SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.family_restroom, controller: familytypeController, labelText: TranslationService.translate("family_type"), onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "fml_type" , "") , "Select Family Type");
            familytypeController.text = value.label;
            fml_type = value.value;

          },),
          SizedBox(height: 20,),*/
          CustomTextField(icondata: Icons.family_restroom_sharp, controller: no_brother, labelText: TranslationService.translate("no_brother"), enabled: false),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.family_restroom_sharp, controller: no_sister, labelText: TranslationService.translate("no_sister"), enabled: false),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.family_restroom_sharp, controller: no_married_bro, labelText: TranslationService.translate("no_married_bro") , enabled: false),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.family_restroom_sharp, controller: no_married_sister, labelText: TranslationService.translate("no_married_sister"), enabled: false),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.family_restroom_sharp, controller: father_name, labelText: "* "+TranslationService.translate("father_name"), enabled: false),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.family_restroom_sharp, controller: mother_name, labelText: "* "+TranslationService.translate("mother_name"), enabled: false),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.family_restroom_sharp, controller: father_occupation, labelText: "* "+TranslationService.translate("father_occuaption"), enabled: false),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.family_restroom_sharp, controller: mother_occupation, labelText: "* "+TranslationService.translate("mother_occupation"), enabled: false),
          SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.family_restroom, controller: house_owned, labelText: "* "+TranslationService.translate("house_owned"), onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheetSingle(context, Data().getHouseOwned() , TranslationService.translate("house_owned"));
            house_owned.text = value;
            house_owned_value =  value;

          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.family_restroom_sharp, controller: house_type, labelText: "* "+TranslationService.translate("house_type"), onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "house_type" , "") , "Select House Type");
            house_type.text = value.label;
            house_type_value = value.value;

          },),
          /*SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.family_restroom_sharp, controller: family_status, labelText: TranslationService.translate("family_status") , onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "fml_status" , "") , "Select Family Status");
            family_status.text = value.label;
            fml_status = value.value;

          },),*/
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.family_restroom_sharp, controller: shakhController, labelText: TranslationService.translate("shakh"), enabled: false),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.family_restroom_sharp, controller: nativeController, labelText: TranslationService.translate("native"), enabled: false),
          SizedBox(height: 20,),
          MultilineTextfield(icondata: Icons.family_restroom_sharp, controller: native_address, labelText: TranslationService.translate("native_address"), enabled: false, minlines: 2, maxlines: 5),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.family_restroom_sharp, controller: moshal_sakh, labelText: TranslationService.translate("moshal_sakh"), enabled: false),
          SizedBox(height: 20,),
         /* CustomTextField(icondata: Icons.family_restroom_sharp, controller: moshal_native, labelText: TranslationService.translate("moshal_native"), enabled: false),
          SizedBox(height: 20,),
          MultilineTextfield(icondata: Icons.family_restroom_sharp, controller: family_slogan, labelText: TranslationService.translate("family_slogan"), enabled: false, minlines: 2, maxlines: 5),
          SizedBox(height: 20,),*/
          ButtonSubmit(text: 'Submit Family Details', onButtonPressed: () async {


   ConnectivityResult result = await Connectivity().checkConnectivity();
            setState(() {
              _connectivityResult = result;
            });
    if (_connectivityResult == ConnectivityResult.none) {
    DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");
    }else {
      if (  house_owned.text
          .toString()
          .length == 0
          || house_type.text
              .toString()
              .length == 0  || father_name.text
          .toString()
          .length == 0 || mother_name.text
          .toString()
          .length == 0 || father_occupation.text
          .toString()
          .length == 0
          || mother_occupation.text
              .toString()
              .length == 0 ) {
        DialogClass().showDialog2(context, "Family Details Submit Alert!",
            "All fields with * mark are compulsory", "Ok");
      } else {

        SharedPreferences prefs = await SharedPreferences.getInstance();

        if (prefs
            .getString(SharedPrefs.familyValue)
            == null) {
          EasyLoading.show(status: 'Please wait...');

          print({
            "family_value": fml_value,
            "family_type": fml_type,
            "family_status": fml_status,
            "no_brother": no_brother.text.toString(),
            "no_sister": no_sister.text.toString(),
            "married_brother": no_married_bro.text.toString(),
            "married_sister": no_married_sister.text.toString(),
            "father_name": father_name.text.toString(),
            "mother_name": mother_name.text.toString(),
            "father_occupation": father_occupation.text.toString(),
            "mother_occupation": mother_occupation.text.toString(),
            "house_owned": house_owned.text.toString(),
            "house_type": house_type_value,
            "parents_stay_options": "Yes",
            "detail_family": family_slogan.text.toString(),
            "userId": prefs.getString(SharedPrefs.userId),
            "communityId": prefs.getString(SharedPrefs.communityId),
            "profileId": prefs.getString(SharedPrefs.profileid),
          });

          final _response = await Provider.of<ApiService>(
              context, listen: false).postFamilyInsert({
            "family_value": "",
            "family_type": "",
            "family_status": "",
            "no_brother": no_brother.text.toString(),
            "no_sister": no_sister.text.toString(),
            "married_brother": no_married_bro.text.toString(),
            "married_sister": no_married_sister.text.toString(),
            "father_name": father_name.text.toString(),
            "mother_name": mother_name.text.toString(),
            "father_occupation": father_occupation.text.toString(),
            "mother_occupation": mother_occupation.text.toString(),
            "house_owned": house_owned.text.toString(),
            "house_type": house_type_value,
            "parents_stay_options": "Yes",
            "detail_family": family_slogan.text.toString(),
            "sakh": shakhController.text.toString(),
            "native" : nativeController.text.toString(),
            "native_address":native_address.text.toString(),
            "moshal_sakh":moshal_sakh.text.toString(),
            "moshal_native":"",
            "userId": prefs.getString(SharedPrefs.userId),
            "communityId": prefs.getString(SharedPrefs.communityId),
            "profileId": prefs.getString(SharedPrefs.profileid),
          });

          if (_response.body["data"]["affectedRows"] == 1) {
            await prefs.setString(SharedPrefs.family_id, _response
                .body["data"]["insertId"].toString());
            await prefs.setString(SharedPrefs.familyStatus, family_status.text
                .toString() + "," + fml_status);
            await prefs.setString(SharedPrefs.familyType, familytypeController
                .text.toString() + "," + fml_type);
            await prefs.setString(SharedPrefs.familyValue, familyvalueController
                .text.toString() + "," + fml_value);
            await prefs.setString(SharedPrefs.noBrother, no_brother.text
                .toString());
            await prefs.setString(SharedPrefs.noSister, no_sister.text
                .toString());
            await prefs.setString(SharedPrefs.marriedBrother, no_married_bro
                .text.toString());
            await prefs.setString(SharedPrefs.marriedSister, no_married_sister
                .text.toString());
            await prefs.setString(SharedPrefs.fatherName, father_name.text
                .toString());
            await prefs.setString(SharedPrefs.motherName, mother_name.text
                .toString());
            await prefs.setString(SharedPrefs.fatherOccupation,
                father_occupation.text.toString());
            await prefs.setString(SharedPrefs.motherOccupation,
                mother_occupation.text.toString());
            await prefs.setString(SharedPrefs.houseOwned, house_owned.text
                .toString());
            await prefs.setString(SharedPrefs.houseType, house_type.text
                .toString() + "," + house_type_value);
            await prefs.setString(SharedPrefs.parentsStayOptions, "Yes");
            await prefs.setString(SharedPrefs.detailFamily, family_slogan.text
                .toString());
            await prefs.setString(SharedPrefs.sakh, shakhController.text.toString());
            await prefs.setString(SharedPrefs.native, nativeController.text.toString());
            await prefs.setString(SharedPrefs.native_address, native_address.text.toString());
            await prefs.setString(SharedPrefs.moshal_sakh, moshal_sakh.text.toString());
            await prefs.setString(SharedPrefs.moshal_native, moshal_native.text.toString());

            EasyLoading.dismiss();

            if (widget.type == "insert") {
              navService.pushNamed("/partner_details", args: "insert");
            } else {
              navService.goBack();
            }
          }
        } else {
          EasyLoading.show(status: 'Please wait...');

          final _response = await Provider.of<ApiService>(
              context, listen: false).postFamilyUpdate({
            "family_value": "",
            "family_type": "",
            "family_status": "",
            "no_brother": no_brother.text.toString(),
            "no_sister": no_sister.text.toString(),
            "married_brother": no_married_bro.text.toString(),
            "married_sister": no_married_sister.text.toString(),
            "father_name": father_name.text.toString(),
            "mother_name": mother_name.text.toString(),
            "father_occupation": father_occupation.text.toString(),
            "mother_occupation": mother_occupation.text.toString(),
            "house_owned": house_owned_value,
            "house_type": house_type_value,
            "parents_stay_options": "Yes",
            "detail_family": family_slogan.text.toString(),
            "shakh": shakhController.text.toString(),
            "native" : nativeController.text.toString(),
            "native_address":native_address.text.toString(),
            "moshal_sakh":moshal_sakh.text.toString(),
            "moshal_native":"",
            "Id": prefs.getString(SharedPrefs.family_id)
          });


          print(_response.body);

          if (_response.body["success"] == 1) {

            await prefs.setString(SharedPrefs.familyStatus, family_status.text.toString() + "," + fml_status);
            await prefs.setString(SharedPrefs.familyType, familytypeController.text.toString() + "," + fml_type);
            await prefs.setString(SharedPrefs.familyValue, familyvalueController.text.toString() + "," + fml_value);
            await prefs.setString(SharedPrefs.noBrother, no_brother.text.toString());
            await prefs.setString(SharedPrefs.noSister, no_sister.text.toString());
            await prefs.setString(SharedPrefs.marriedBrother, no_married_bro.text.toString());
            await prefs.setString(SharedPrefs.marriedSister, no_married_sister.text.toString());
            await prefs.setString(SharedPrefs.fatherName, father_name.text.toString());
            await prefs.setString(SharedPrefs.motherName, mother_name.text.toString());
            await prefs.setString(SharedPrefs.fatherOccupation, father_occupation.text.toString());
            await prefs.setString(SharedPrefs.motherOccupation, mother_occupation.text.toString());
            await prefs.setString(SharedPrefs.houseOwned, house_owned.text.toString());
            await prefs.setString(SharedPrefs.houseType, house_type.text.toString() + "," + house_type_value);
            await prefs.setString(SharedPrefs.parentsStayOptions, "Yes");
            await prefs.setString(SharedPrefs.detailFamily, family_slogan.text.toString());
            await prefs.setString(SharedPrefs.sakh, shakhController.text.toString());
            await prefs.setString(SharedPrefs.native, nativeController.text.toString());
            await prefs.setString(SharedPrefs.native_address, native_address.text.toString());
            await prefs.setString(SharedPrefs.moshal_sakh, moshal_sakh.text.toString());
            await prefs.setString(SharedPrefs.moshal_native, moshal_native.text.toString());

            EasyLoading.dismiss();

            navService.goBack();
          }
        }
      }
    }
            },)

        ],)),
        ))));

  }




}