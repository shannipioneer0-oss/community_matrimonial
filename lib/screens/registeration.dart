

import 'dart:math';

import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/Values.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/user_profile/ButtonSubmit.dart';
import 'package:community_matrimonial/screens/user_profile/CustomDropdown.dart';
import 'package:community_matrimonial/screens/user_profile/CustomTextField.dart';
import 'package:community_matrimonial/screens/user_profile/NumericFields.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';

import '../app_utils/SingleSelectDialog.dart';

class Registeration extends StatefulWidget{


  RegisterationState createState() => RegisterationState();

}


class RegisterationState extends State<Registeration>{

  TextEditingController controllerfirstName = TextEditingController();
  TextEditingController controllerlastName = TextEditingController();
  TextEditingController controllergender = TextEditingController();

  TextEditingController controllerbirthdate = TextEditingController();
  TextEditingController controllerbirthmonth = TextEditingController();
  TextEditingController controllerbirthyear = TextEditingController();

  TextEditingController controlleremailid = TextEditingController();
  TextEditingController controllermobile = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();

  List<DataFetchParams> items_gender = [DataFetchParams(label: "Male", value: "Male", value2: "Male") , DataFetchParams(label: "Female", value: "Female", value2: "Female")];

  List<DataFetchParams> items_date = [];
  List<DataFetchParams> items_month = [];
  List<DataFetchParams> items_year = [];

  List monthname = ["January" ,"February" , "March" ,"April" , "May" ,"June" , "July" , "August" , "September" , "October" , "November", "December"];

   @override
  void initState() {
    super.initState();

    print(FlavorConfig.instance.name);

    for(int i=1; i<=31 ; i++){
      items_date.add(DataFetchParams(label: i.toString(), value: i.toString(), value2: i.toString()));
    }

    for(int i=1; i<=12 ;i++){
      items_month.add(DataFetchParams(label: monthname[i-1], value: i.toString(), value2: ""));
    }

    for(int i=2008; i>=1901 ; i--){
      items_year.add(DataFetchParams(label: i.toString(), value: i.toString(), value2: i.toString()));
    }

     Future.delayed(Duration(milliseconds: 500), (){

       DialogClass().showPremiumInfoDialog2(context , "Who Can Register?" , "Only Members of Raval Yogi Samaj Can Register. \n (Father should be from Raval Yogi Samaj)" , "Got It!");

     });


  }

  String month = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Registeration") , backgroundColor: Colors.pinkAccent,),
      body: SafeArea(child:SingleChildScrollView(child:Container(padding: EdgeInsets.all(15)   ,child:Column(children: [

        CustomTextField(icondata: Icons.supervised_user_circle, controller: controllerfirstName, labelText: "Enter First Name", enabled: false),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.supervised_user_circle, controller: controllerlastName, labelText: "Enter Surname", enabled: false),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.supervised_user_circle, controller: controllergender, labelText: "Select Gender", onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheet3(context, items_gender);
          controllergender.text = value.label;

        }),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.date_range, controller: controllerbirthdate, labelText: "Select Birthdate", onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheet3(context, items_date);
          controllerbirthdate.text = value.label;

        }),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.date_range, controller: controllerbirthmonth, labelText: "Select Birth Month", onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheet3(context, items_month);
          controllerbirthmonth.text = value.label;
          month = value.value;

        }),
        SizedBox(height: 15,),
        CustomDropdown(icondata: Icons.date_range, controller: controllerbirthyear, labelText: "Select Birth Year", onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheet3(context, items_year);
          controllerbirthyear.text = value.label;

        }),
        SizedBox(height: 15,),
        CustomTextField(icondata: Icons.email, controller: controlleremailid, labelText: " Enter EmailID ", enabled: false),
        SizedBox(height: 15,),
        NumericTextField(icondata: Icons.mobile_screen_share_sharp, controller: controllermobile, labelText: " Enter Mobile Number ", enabled: false , type: "mobile",),
        /*SizedBox(height: 15,),
        CustomTextField(icondata: Icons.password, controller: controllerpassword, labelText: " Enter Password ", enabled: false),*/
        SizedBox(height: 30,),
        ButtonSubmit(text: "Register Here", onButtonPressed: () async {

          if(controllerfirstName.text.isEmpty || controllerlastName.text.isEmpty || controllermobile.text.isEmpty
          || controllermobile.text.isEmpty  || controllerbirthdate.text.isEmpty || controllerbirthmonth.text.isEmpty
          || controllerbirthyear.text.isEmpty || controllergender.text.isEmpty){

            DialogClass().showDialog2(context, "Mandatory Fields", "All Fields are compulsory", "OK");

          }else{

            final flavor = FlavorConfig.instance.name;
            String communityId = flavor == "appA" ? "20" : "2";

              final res = await ApiService.create().postMobileExists({"mobile":controllermobile.text.toString() ,  "community_id":communityId});

            if(res.body["data"].toString() == "[]"){

              navService.pushNamed("/signup_verify" , args: [controllermobile.text.toString() , controllerfirstName.text.toString() ,
                controllerlastName.text.toString() , controllerbirthdate.text ,
                month , controllerbirthyear.text ,
                controllergender.text , controlleremailid.text.toString() , generateOtp() ]);

            }else{

              DialogClass().showDialog2(context, "Already Exists Alert!", "Mobile Number Already Exists", "OK");

            }



          }


        })



      ],)),),
    ));

  }


  String generateOtp() {
    final random = Random();
    const min = 100000; // Smallest 6-digit number
    const max = 999999; // Largest 6-digit number

    int otp = min + random.nextInt(max - min + 1);
    return otp.toString();
  }






}