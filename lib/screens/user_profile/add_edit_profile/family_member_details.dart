

import 'package:community_matrimonial/screens/user_profile/CustomTextField.dart';
import 'package:community_matrimonial/screens/user_profile/NumericFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_utils/Dialogs.dart';
import '../../../app_utils/SingleSelectDialog.dart';
import '../../../app_utils/Values.dart';
import '../../../locale/TranslationService.dart';
import '../../../network_utils/service/api_service.dart';
import '../../../utils/SharedPrefs.dart';
import '../../../utils/universalback_wrapper.dart';
import '../../../utils/utils.dart';
import '../ButtonSubmit.dart';
import '../CustomDropdown.dart';
import '../MultilineTextfield.dart';

class FamilyMemberDetails extends StatelessWidget {

  final String type;
  FamilyMemberDetails({required this.type});

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
  FamilyMemberDetailScreen createState() => FamilyMemberDetailScreen();

}

class FamilyMemberDetailScreen  extends State<FamilyDetailsStateful>{

  GlobalKey<ScaffoldState> _scaffoldKey7 = GlobalKey<ScaffoldState>();

  TextEditingController membername1 = new TextEditingController();
  TextEditingController relation1 = new TextEditingController();
  TextEditingController marital1 = new TextEditingController();
  TextEditingController age1 = new TextEditingController();
  TextEditingController education1 = new TextEditingController();
  TextEditingController occupation_income1 = new TextEditingController();

  TextEditingController membername2 = new TextEditingController();
  TextEditingController relation2 = new TextEditingController();
  TextEditingController marital2 = new TextEditingController();
  TextEditingController age2 = new TextEditingController();
  TextEditingController education2 = new TextEditingController();
  TextEditingController occupation_income2 = new TextEditingController();

  TextEditingController membername3 = new TextEditingController();
  TextEditingController relation3 = new TextEditingController();
  TextEditingController marital3 = new TextEditingController();
  TextEditingController age3 = new TextEditingController();
  TextEditingController education3 = new TextEditingController();
  TextEditingController occupation_income3 = new TextEditingController();

  TextEditingController membername4 = new TextEditingController();
  TextEditingController relation4 = new TextEditingController();
  TextEditingController marital4 = new TextEditingController();
  TextEditingController age4 = new TextEditingController();
  TextEditingController education4 = new TextEditingController();
  TextEditingController occupation_income4 = new TextEditingController();


  TextEditingController membername5 = new TextEditingController();
  TextEditingController relation5 = new TextEditingController();
  TextEditingController marital5 = new TextEditingController();
  TextEditingController age5 = new TextEditingController();
  TextEditingController education5 = new TextEditingController();
  TextEditingController occupation_income5 = new TextEditingController();

  TextEditingController membername6 = new TextEditingController();
  TextEditingController relation6 = new TextEditingController();
  TextEditingController marital6 = new TextEditingController();
  TextEditingController age6 = new TextEditingController();
  TextEditingController education6 = new TextEditingController();
  TextEditingController occupation_income6 = new TextEditingController();

  TextEditingController refmembername1 = new TextEditingController();
  TextEditingController refmemberadd1 = new TextEditingController();
  TextEditingController refmembermobile1 = new TextEditingController();
  TextEditingController refmembername2 = new TextEditingController();
  TextEditingController refmemberadd2 = new TextEditingController();
  TextEditingController refmembermobile2 = new TextEditingController();



  initViews() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // ----- FAMILY MEMBER 1 -----
    membername1.text = utils().replaceNull(prefs.getString(SharedPrefs.membername1).toString());
    relation1.text = utils().replaceNull(prefs.getString(SharedPrefs.relation1).toString());
    marital1.text = utils().replaceNull(prefs.getString(SharedPrefs.marital1).toString());
    age1.text = utils().replaceNull(prefs.getString(SharedPrefs.age1).toString());
    education1.text = utils().replaceNull(prefs.getString(SharedPrefs.education1).toString());
    occupation_income1.text = utils().replaceNull(prefs.getString(SharedPrefs.occupation_income1).toString());

    // ----- FAMILY MEMBER 2 -----
    membername2.text = utils().replaceNull(prefs.getString(SharedPrefs.membername2).toString());
    relation2.text = utils().replaceNull(prefs.getString(SharedPrefs.relation2).toString());
    marital2.text = utils().replaceNull(prefs.getString(SharedPrefs.marital2).toString());
    age2.text = utils().replaceNull(prefs.getString(SharedPrefs.age2).toString());
    education2.text = utils().replaceNull(prefs.getString(SharedPrefs.education2).toString());
    occupation_income2.text = utils().replaceNull(prefs.getString(SharedPrefs.occupation_income2).toString());

    // ----- FAMILY MEMBER 3 -----
    membername3.text = utils().replaceNull(prefs.getString(SharedPrefs.membername3).toString());
    relation3.text = utils().replaceNull(prefs.getString(SharedPrefs.relation3).toString());
    marital3.text = utils().replaceNull(prefs.getString(SharedPrefs.marital3).toString());
    age3.text = utils().replaceNull(prefs.getString(SharedPrefs.age3).toString());
    education3.text = utils().replaceNull(prefs.getString(SharedPrefs.education3).toString());
    occupation_income3.text = utils().replaceNull(prefs.getString(SharedPrefs.occupation_income3).toString());

    // ----- FAMILY MEMBER 4 -----
    membername4.text = utils().replaceNull(prefs.getString(SharedPrefs.membername4).toString());
    relation4.text = utils().replaceNull(prefs.getString(SharedPrefs.relation4).toString());
    marital4.text = utils().replaceNull(prefs.getString(SharedPrefs.marital4).toString());
    age4.text = utils().replaceNull(prefs.getString(SharedPrefs.age4).toString());
    education4.text = utils().replaceNull(prefs.getString(SharedPrefs.education4).toString());
    occupation_income4.text = utils().replaceNull(prefs.getString(SharedPrefs.occupation_income4).toString());

    // ----- FAMILY MEMBER 5 -----
    membername5.text = utils().replaceNull(prefs.getString(SharedPrefs.membername5).toString());
    relation5.text = utils().replaceNull(prefs.getString(SharedPrefs.relation5).toString());
    marital5.text = utils().replaceNull(prefs.getString(SharedPrefs.marital5).toString());
    age5.text = utils().replaceNull(prefs.getString(SharedPrefs.age5).toString());
    education5.text = utils().replaceNull(prefs.getString(SharedPrefs.education5).toString());
    occupation_income5.text = utils().replaceNull(prefs.getString(SharedPrefs.occupation_income5).toString());

    // ----- FAMILY MEMBER 6 -----
    membername6.text = utils().replaceNull(prefs.getString(SharedPrefs.membername6).toString());
    relation6.text = utils().replaceNull(prefs.getString(SharedPrefs.relation6).toString());
    marital6.text = utils().replaceNull(prefs.getString(SharedPrefs.marital6).toString());
    age6.text = utils().replaceNull(prefs.getString(SharedPrefs.age6).toString());
    education6.text = utils().replaceNull(prefs.getString(SharedPrefs.education6).toString());
    occupation_income6.text = utils().replaceNull(prefs.getString(SharedPrefs.occupation_income6).toString());

    // ----- REFERENCE MEMBER 1 -----
    refmembername1.text = utils().replaceNull(prefs.getString(SharedPrefs.refmembername1).toString());
    refmemberadd1.text = utils().replaceNull(prefs.getString(SharedPrefs.refmemberadd1).toString());
    refmembermobile1.text = utils().replaceNull(prefs.getString(SharedPrefs.refmembermobile1).toString());

    // ----- REFERENCE MEMBER 2 -----
    refmembername2.text = utils().replaceNull(prefs.getString(SharedPrefs.refmembername2).toString());
    refmemberadd2.text = utils().replaceNull(prefs.getString(SharedPrefs.refmemberadd2).toString());
    refmembermobile2.text = utils().replaceNull(prefs.getString(SharedPrefs.refmembermobile2).toString());
  }

  @override
  void initState() {
    super.initState();

    EasyLoading.dismiss();

    initViews();

  }


  @override
  Widget build(BuildContext context) {


    return UniversalBackWrapper(
        isRoot: false

        ,child:Scaffold(key: _scaffoldKey7,

    appBar: AppBar(
    title: Text('Family Member Details\nRavaldev Matrimony' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
    toolbarOpacity: 1,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: IconButton(
    icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
    onPressed: () {

    navService.goBack();

    },
    )),
    body: SafeArea(child: SingleChildScrollView(

      child: Container( padding: EdgeInsets.all(10)  ,child: Column(crossAxisAlignment: CrossAxisAlignment.start ,children: [

        Text(
        "Family Member Details1", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.red),),
        Divider(),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: membername1, labelText: TranslationService.translate("member_name")+"*", enabled: false),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.family_restroom_sharp, controller: relation1, labelText: TranslationService.translate("relation_with_can")+"*", onButtonPressed: () async {

         final value = await SingleSelectDialog().showBottomSheetSingle(context,  Values.relationwithcandidate() , TranslationService.translate("relation_with_can"));
         relation1.text =  value;

        },),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.family_restroom_sharp, controller: marital1, labelText: TranslationService.translate("marital_status_members")+"*", onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheetSingle(context,  Values.maritalStatus() , TranslationService.translate("marital_status_members"));
          marital1.text =  value;

        },),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: age1, labelText: TranslationService.translate("age")+"*", enabled: false),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: education1, labelText: TranslationService.translate("education"), enabled: false),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: occupation_income1 , labelText: TranslationService.translate("occupation_annual_income"), enabled: false),

        SizedBox(height: 30,),


        Text(
          "Family Member Details2", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red),),
        Divider(),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: membername2, labelText: TranslationService.translate("member_name")+"*", enabled: false),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.family_restroom_sharp, controller: relation2, labelText: TranslationService.translate("relation_with_can")+"*", onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheetSingle(context,  Values.relationwithcandidate() , TranslationService.translate("relation_with_can"));
          relation2.text =  value;

        },),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.family_restroom_sharp, controller: marital2, labelText: TranslationService.translate("marital_status_members")+"*", onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheetSingle(context,  Values.maritalStatus() , TranslationService.translate("marital_status_members"));
          marital2.text =  value;

        },),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: age2, labelText: TranslationService.translate("age")+"*", enabled: false),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: education2, labelText: TranslationService.translate("education"), enabled: false),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: occupation_income2 , labelText: TranslationService.translate("occupation_annual_income"), enabled: false),

        SizedBox(height: 30,),

        Text(
          "Family Member Details3", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red),),
        Divider(),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: membername3, labelText: TranslationService.translate("member_name"), enabled: false),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.family_restroom_sharp, controller: relation3, labelText: TranslationService.translate("relation_with_can"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheetSingle(context,  Values.relationwithcandidate() , TranslationService.translate("relation_with_can"));
          relation3.text =  value;

        },),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.family_restroom_sharp, controller: marital3, labelText: TranslationService.translate("marital_status_members"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheetSingle(context,  Values.maritalStatus() , TranslationService.translate("marital_status_members"));
          marital3.text =  value;

        },),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: age3, labelText: TranslationService.translate("age"), enabled: false),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: education3, labelText: TranslationService.translate("education"), enabled: false),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: occupation_income3 , labelText: TranslationService.translate("occupation_annual_income"), enabled: false),

        SizedBox(height: 30,),

        Text(
          "Family Member Details4", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red),),
        Divider(),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: membername4, labelText: TranslationService.translate("member_name"), enabled: false),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.family_restroom_sharp, controller: relation4, labelText: TranslationService.translate("relation_with_can"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheetSingle(context,  Values.relationwithcandidate() , TranslationService.translate("relation_with_can"));
          relation4.text =  value;

        },),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.family_restroom_sharp, controller: marital4, labelText: TranslationService.translate("marital_status_members"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheetSingle(context,  Values.maritalStatus() , TranslationService.translate("marital_status_members"));
          marital4.text =  value;

        },),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: age4, labelText: TranslationService.translate("age"), enabled: false),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: education4, labelText: TranslationService.translate("education"), enabled: false),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: occupation_income4 , labelText: TranslationService.translate("occupation_annual_income"), enabled: false),

        SizedBox(height: 30,),

        Text(
          "Family Member Details5", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red),),
        Divider(),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: membername5, labelText: TranslationService.translate("member_name"), enabled: false),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.family_restroom_sharp, controller: relation5, labelText: TranslationService.translate("relation_with_can"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheetSingle(context,  Values.relationwithcandidate() , TranslationService.translate("relation_with_can"));
          relation5.text =  value;

        },),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.family_restroom_sharp, controller: marital5, labelText: TranslationService.translate("marital_status_members"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheetSingle(context,  Values.maritalStatus() , TranslationService.translate("marital_status_members"));
          marital5.text =  value;

        },),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: age5, labelText: TranslationService.translate("age"), enabled: false),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: education5, labelText: TranslationService.translate("education"), enabled: false),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: occupation_income5 , labelText: TranslationService.translate("occupation_annual_income"), enabled: false),

        SizedBox(height: 30,),


        Text(
          "Family Member Details6", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red),),
        Divider(),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: membername6, labelText: TranslationService.translate("member_name"), enabled: false),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.family_restroom_sharp, controller: relation6, labelText: TranslationService.translate("relation_with_can"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheetSingle(context,  Values.relationwithcandidate() , TranslationService.translate("relation_with_can"));
          relation6.text =  value;

        },),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.family_restroom_sharp, controller: marital6, labelText: TranslationService.translate("marital_status_members"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheetSingle(context,  Values.maritalStatus() , TranslationService.translate("marital_status_members"));
          marital6.text =  value;

        },),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: age6, labelText: TranslationService.translate("age"), enabled: false),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: education6, labelText: TranslationService.translate("education"), enabled: false),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.family_restroom_sharp, controller: occupation_income6 , labelText: TranslationService.translate("occupation_annual_income"), enabled: false),

        SizedBox(height: 30,),
        Text(
          "References1", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red),),
        Divider(),

        CustomTextField(icondata: Icons.family_restroom_sharp, controller: refmembername1, labelText: TranslationService.translate("member_name"), enabled: false),
        SizedBox(height: 15,),
        MultilineTextfield(icondata: Icons.family_restroom_sharp, controller: refmemberadd1, labelText: TranslationService.translate("address"), enabled: false, minlines: 2, maxlines: 5),
        SizedBox(height: 15,),
        NumericTextField(icondata: Icons.family_restroom_sharp, controller: refmembermobile1, labelText: TranslationService.translate("mobile") , enabled: false),


        SizedBox(height: 30,),
        Text(
          "References2", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red),),
        Divider(),

        CustomTextField(icondata: Icons.family_restroom_sharp, controller: refmembername2, labelText: TranslationService.translate("member_name"), enabled: false),
        SizedBox(height: 15,),
        MultilineTextfield(icondata: Icons.family_restroom_sharp, controller: refmemberadd2, labelText: TranslationService.translate("address"), enabled: false, minlines: 2, maxlines: 5),
        SizedBox(height: 15,),
        NumericTextField(icondata: Icons.family_restroom_sharp, controller: refmembermobile2, labelText: TranslationService.translate("mobile") , enabled: false),

        SizedBox(height: 30,),
        ButtonSubmit(text: 'Submit Family Details', onButtonPressed: () async {

          if(membername1.text.toString().length == 0 || membername2.text.toString().length == 0 || relation1.text.toString().length == 0 ||
          relation2.text.toString().length == 0 || marital1.text.toString().length == 0 || marital2.text.toString().length == 0 ||
              age1.text.toString().length == 0 || age2.text.toString().length == 0){

            DialogClass().showDialog2(context, "Family Member Details Submit Alert!",
                "All fields with * mark are compulsory", "Ok");

          }else{

            SVProgressHUD.show();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString(SharedPrefs.membername1) == null) {

      String member_details1 = membername1.text.toString()+","+relation1.text.toString()+","+marital1.text.toString()+","+age1.text.toString()+","+education1.text.toString()+","+occupation_income1.text.toString();
      String member_details2 = membername2.text.toString()+","+relation2.text.toString()+","+marital2.text.toString()+","+age2.text.toString()+","+education2.text.toString()+","+occupation_income2.text.toString();
      String member_details3 = membername3.text.toString()+","+relation3.text.toString()+","+marital3.text.toString()+","+age3.text.toString()+","+education3.text.toString()+","+occupation_income3.text.toString();
      String member_details4 = membername4.text.toString()+","+relation4.text.toString()+","+marital4.text.toString()+","+age4.text.toString()+","+education4.text.toString()+","+occupation_income4.text.toString();
      String member_details5 = membername5.text.toString()+","+relation5.text.toString()+","+marital5.text.toString()+","+age5.text.toString()+","+education5.text.toString()+","+occupation_income5.text.toString();
      String member_details6 = membername6.text.toString()+","+relation6.text.toString()+","+marital6.text.toString()+","+age6.text.toString()+","+education6.text.toString()+","+occupation_income6.text.toString();


      final _response = await Provider.of<ApiService>(
          context, listen: false).insert_family_member_details({
        "member_details1": member_details1 ,
        "member_details2": member_details2 ,
        "member_details3": member_details3 ,
        "member_details4": member_details4,
        "member_details5": member_details5,
        "member_details6": member_details6,
        "ref_membername1": refmembername1.text.toString(),
        "ref_memberadd1": refmemberadd1.text.toString() ,
        "ref_membermobile1": refmembermobile1.text.toString() ,
        "ref_membername2": refmembername2.text.toString(),
        "ref_memberadd2":  refmemberadd2.text.toString(),
        "ref_membermobile2": refmembermobile2.text.toString(),
        "userId": prefs.getString(SharedPrefs.userId),
        "communityId": prefs.getString(SharedPrefs.communityId),
        "profileId": prefs.getString(SharedPrefs.profileid)
      });

    if (_response.body["data"]["affectedRows"] == 1) {



      await prefs.setString(SharedPrefs.fml_details_id , _response.body["data"]["insertId"].toString());
      await prefs.setString(SharedPrefs.membername1, membername1.text.toString());
      await prefs.setString(SharedPrefs.relation1, relation1.text.toString());
      await prefs.setString(SharedPrefs.marital1, marital1.text.toString());
      await prefs.setString(SharedPrefs.age1, age1.text.toString());
      await prefs.setString(SharedPrefs.education1, education1.text.toString());
      await prefs.setString(SharedPrefs.occupation_income1, occupation_income1.text.toString());

      await prefs.setString(SharedPrefs.membername2, membername2.text.toString());
      await prefs.setString(SharedPrefs.relation2, relation2.text.toString());
      await prefs.setString(SharedPrefs.marital2, marital2.text.toString());
      await prefs.setString(SharedPrefs.age2, age2.text.toString());
      await prefs.setString(SharedPrefs.education2, education2.text.toString());
      await prefs.setString(SharedPrefs.occupation_income2, occupation_income2.text.toString());

      await prefs.setString(SharedPrefs.membername3, membername3.text.toString());
      await prefs.setString(SharedPrefs.relation3, relation3.text.toString());
      await prefs.setString(SharedPrefs.marital3, marital3.text.toString());
      await prefs.setString(SharedPrefs.age3, age3.text.toString());
      await prefs.setString(SharedPrefs.education3, education3.text.toString());
      await prefs.setString(SharedPrefs.occupation_income3, occupation_income3.text.toString());

      await prefs.setString(SharedPrefs.membername4, membername4.text.toString());
      await prefs.setString(SharedPrefs.relation4, relation4.text.toString());
      await prefs.setString(SharedPrefs.marital4, marital4.text.toString());
      await prefs.setString(SharedPrefs.age4, age4.text.toString());
      await prefs.setString(SharedPrefs.education4, education4.text.toString());
      await prefs.setString(SharedPrefs.occupation_income4, occupation_income4.text.toString());

      await prefs.setString(SharedPrefs.membername5, membername5.text.toString());
      await prefs.setString(SharedPrefs.relation5, relation5.text.toString());
      await prefs.setString(SharedPrefs.marital5, marital5.text.toString());
      await prefs.setString(SharedPrefs.age5, age5.text.toString());
      await prefs.setString(SharedPrefs.education5, education5.text.toString());
      await prefs.setString(SharedPrefs.occupation_income5, occupation_income5.text.toString());

      await prefs.setString(SharedPrefs.membername6, membername6.text.toString());
      await prefs.setString(SharedPrefs.relation6, relation6.text.toString());
      await prefs.setString(SharedPrefs.marital6, marital6.text.toString());
      await prefs.setString(SharedPrefs.age6, age6.text.toString());
      await prefs.setString(SharedPrefs.education6, education6.text.toString());
      await prefs.setString(SharedPrefs.occupation_income6, occupation_income6.text.toString());

      await prefs.setString(SharedPrefs.refmembername1, refmembername1.text.toString());
      await prefs.setString(SharedPrefs.refmemberadd1, refmemberadd1.text.toString());
      await prefs.setString(SharedPrefs.refmembermobile1, refmembermobile1.text.toString());

      await prefs.setString(SharedPrefs.refmembername2, refmembername2.text.toString());
      await prefs.setString(SharedPrefs.refmemberadd2, refmemberadd2.text.toString());
      await prefs.setString(SharedPrefs.refmembermobile2, refmembermobile2.text.toString());

      SVProgressHUD.dismiss();

      navService.goBack();

    }else{

      SVProgressHUD.dismiss();

    }

    }else{


      String member_details1 = membername1.text.toString()+","+relation1.text.toString()+","+marital1.text.toString()+","+age1.text.toString()+","+education1.text.toString()+","+occupation_income1.text.toString();
      String member_details2 = membername2.text.toString()+","+relation2.text.toString()+","+marital2.text.toString()+","+age2.text.toString()+","+education2.text.toString()+","+occupation_income2.text.toString();
      String member_details3 = membername3.text.toString()+","+relation3.text.toString()+","+marital3.text.toString()+","+age3.text.toString()+","+education3.text.toString()+","+occupation_income3.text.toString();
      String member_details4 = membername4.text.toString()+","+relation4.text.toString()+","+marital4.text.toString()+","+age4.text.toString()+","+education4.text.toString()+","+occupation_income4.text.toString();
      String member_details5 = membername5.text.toString()+","+relation5.text.toString()+","+marital5.text.toString()+","+age5.text.toString()+","+education5.text.toString()+","+occupation_income5.text.toString();
      String member_details6 = membername6.text.toString()+","+relation6.text.toString()+","+marital6.text.toString()+","+age6.text.toString()+","+education6.text.toString()+","+occupation_income6.text.toString();

      SVProgressHUD.show();


      print({
        "member_details1": member_details1 ,
        "member_details2": member_details2 ,
        "member_details3": member_details3 ,
        "member_details4": member_details4,
        "member_details5": member_details5,
        "member_details6": member_details6,
        "ref_membername1": refmembername1.text.toString(),
        "ref_memberadd1": refmemberadd1.text.toString() ,
        "ref_membermobile1": refmembermobile1.text.toString() ,
        "ref_membername2": refmembername2.text.toString(),
        "ref_memberadd2":  refmemberadd2.text.toString(),
        "ref_membermobile2": refmembermobile2.text.toString(),
        "Id": prefs.getString(SharedPrefs.fml_details_id),
      });

      final _response = await Provider.of<ApiService>(
          context, listen: false).update_family_member_details({
        "member_details1": member_details1 ,
        "member_details2": member_details2 ,
        "member_details3": member_details3 ,
        "member_details4": member_details4,
        "member_details5": member_details5,
        "member_details6": member_details6,
        "ref_membername1": refmembername1.text.toString(),
        "ref_memberadd1": refmemberadd1.text.toString() ,
        "ref_membermobile1": refmembermobile1.text.toString() ,
        "ref_membername2": refmembername2.text.toString(),
        "ref_memberadd2":  refmemberadd2.text.toString(),
        "ref_membermobile2": refmembermobile2.text.toString(),
        "Id": prefs.getString(SharedPrefs.fml_details_id),
      });


      if (_response.body["data"]["affectedRows"] == 1) {
        await prefs.setString(
            SharedPrefs.membername1, membername1.text.toString());
        await prefs.setString(SharedPrefs.relation1, relation1.text.toString());
        await prefs.setString(SharedPrefs.marital1, marital1.text.toString());
        await prefs.setString(SharedPrefs.age1, age1.text.toString());
        await prefs.setString(
            SharedPrefs.education1, education1.text.toString());
        await prefs.setString(
            SharedPrefs.occupation_income1, occupation_income1.text.toString());

        await prefs.setString(
            SharedPrefs.membername2, membername2.text.toString());
        await prefs.setString(SharedPrefs.relation2, relation2.text.toString());
        await prefs.setString(SharedPrefs.marital2, marital2.text.toString());
        await prefs.setString(SharedPrefs.age2, age2.text.toString());
        await prefs.setString(
            SharedPrefs.education2, education2.text.toString());
        await prefs.setString(
            SharedPrefs.occupation_income2, occupation_income2.text.toString());

        await prefs.setString(
            SharedPrefs.membername3, membername3.text.toString());
        await prefs.setString(SharedPrefs.relation3, relation3.text.toString());
        await prefs.setString(SharedPrefs.marital3, marital3.text.toString());
        await prefs.setString(SharedPrefs.age3, age3.text.toString());
        await prefs.setString(
            SharedPrefs.education3, education3.text.toString());
        await prefs.setString(
            SharedPrefs.occupation_income3, occupation_income3.text.toString());

        await prefs.setString(
            SharedPrefs.membername4, membername4.text.toString());
        await prefs.setString(SharedPrefs.relation4, relation4.text.toString());
        await prefs.setString(SharedPrefs.marital4, marital4.text.toString());
        await prefs.setString(SharedPrefs.age4, age4.text.toString());
        await prefs.setString(
            SharedPrefs.education4, education4.text.toString());
        await prefs.setString(
            SharedPrefs.occupation_income4, occupation_income4.text.toString());

        await prefs.setString(
            SharedPrefs.membername5, membername5.text.toString());
        await prefs.setString(SharedPrefs.relation5, relation5.text.toString());
        await prefs.setString(SharedPrefs.marital5, marital5.text.toString());
        await prefs.setString(SharedPrefs.age5, age5.text.toString());
        await prefs.setString(
            SharedPrefs.education5, education5.text.toString());
        await prefs.setString(
            SharedPrefs.occupation_income5, occupation_income5.text.toString());

        await prefs.setString(
            SharedPrefs.membername6, membername6.text.toString());
        await prefs.setString(SharedPrefs.relation6, relation6.text.toString());
        await prefs.setString(SharedPrefs.marital6, marital6.text.toString());
        await prefs.setString(SharedPrefs.age6, age6.text.toString());
        await prefs.setString(
            SharedPrefs.education6, education6.text.toString());
        await prefs.setString(
            SharedPrefs.occupation_income6, occupation_income6.text.toString());

        await prefs.setString(
            SharedPrefs.refmembername1, refmembername1.text.toString());
        await prefs.setString(
            SharedPrefs.refmemberadd1, refmemberadd1.text.toString());
        await prefs.setString(
            SharedPrefs.refmembermobile1, refmembermobile1.text.toString());

        await prefs.setString(
            SharedPrefs.refmembername2, refmembername2.text.toString());
        await prefs.setString(
            SharedPrefs.refmemberadd2, refmemberadd2.text.toString());
        await prefs.setString(
            SharedPrefs.refmembermobile2, refmembermobile2.text.toString());

        SVProgressHUD.dismiss();

        navService.goBack();

      }else{

        SVProgressHUD.dismiss();

      }

    }

   }

        }),

      ],),),

    )),

    ));


  }



}