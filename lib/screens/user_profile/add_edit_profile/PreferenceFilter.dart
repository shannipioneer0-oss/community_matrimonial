

import 'dart:convert';

import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/universalback_wrapper.dart';

class PreferenceFilter extends StatefulWidget {
  @override
  PreferenceFilterState createState() => PreferenceFilterState();
}

class PreferenceFilterState extends State<PreferenceFilter> {


  Map<String, bool> switchValues = {
    'Age': true,
    'Height': true,
    'MaritalStatus': true,
    'Shakh': false,
    'SkinTone': true,
    'State': false,
    'City': true,
    'Education': false,
    'Occupation': true,
    'BodyType': false,
   /* 'DietType': true,
    'DrinkType': false,
    'SmokeType': true,
    'FamilyValue': false,*/
    'AnnualIncome': true,
  };

  @override
  void initState() {
    super.initState();

    EasyLoading.dismiss();

    initPrefrence();

  }

  initPrefrence() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {

      switchValues['Age'] = prefs.getString(SharedPrefs.ageRange_filter) == null  || prefs.getString(SharedPrefs.ageRange_filter) == "false"  ? false : true;
      switchValues['Height'] = prefs.getString(SharedPrefs.heightRange_filter) == null  || prefs.getString(SharedPrefs.heightRange_filter) == "false" ? false : true;
      switchValues['MaritalStatus'] = prefs.getString(SharedPrefs.maritalStatus_prefs_filter) == null || prefs.getString(SharedPrefs.maritalStatus_prefs_filter) == "false" ? false : true;
      switchValues['Shakh'] = prefs.getString(SharedPrefs.subcaste_prefs_filter) == null || prefs.getString(SharedPrefs.subcaste_prefs_filter) == "false" ?  false : true;
      switchValues['SkinTone'] = prefs.getString(SharedPrefs.skintoneprefs_filter) == null || prefs.getString(SharedPrefs.skintoneprefs_filter) == "false" ? false : true;
      switchValues['State'] = prefs.getString(SharedPrefs.state_prefs_filter) == null || prefs.getString(SharedPrefs.state_prefs_filter) == "false" ? false : true;
      switchValues['City'] = prefs.getString(SharedPrefs.city_prefs_filter) == null || prefs.getString(SharedPrefs.city_prefs_filter) == "false"  ? false : true;
      switchValues['Education'] = prefs.getString(SharedPrefs.education_prefs_filter) == null || prefs.getString(SharedPrefs.education_prefs_filter) == "false" ? false : true;
      switchValues['Occupation'] = prefs.getString(SharedPrefs.occupation_prefs_filter) == null || prefs.getString(SharedPrefs.occupation_prefs_filter) == "false" ? false : true;
      switchValues['BodyType'] = prefs.getString(SharedPrefs.bodyType_prefs_filter) == null || prefs.getString(SharedPrefs.bodyType_prefs_filter) == "false" ? false : true;
      /*switchValues['DietType'] = prefs.getString(SharedPrefs.dietType_prefs_filter) == null || prefs.getString(SharedPrefs.dietType_prefs_filter) == "false" ? false : true;
      switchValues['DrinkType'] = prefs.getString(SharedPrefs.drinkType_prefs_filter) == null || prefs.getString(SharedPrefs.drinkType_prefs_filter) == "false" ? false : true;
      switchValues['SmokeType'] = prefs.getString(SharedPrefs.smokeType_prefs_filter) == null || prefs.getString(SharedPrefs.smokeType_prefs_filter) == "false" ? false : true;
      switchValues['FamilyValue'] = prefs.getString(SharedPrefs.familyValue_prefs_filter) == null || prefs.getString(SharedPrefs.familyValue_prefs_filter) == "false"  ? false : true;
  */    switchValues['AnnualIncome'] = prefs.getString(SharedPrefs.annualIncome_prefs_filter) == null || prefs.getString(SharedPrefs.annualIncome_prefs_filter) == "false" ? false : true;


      print(switchValues['Height'] );

    });



  }

  @override
  Widget build(BuildContext context) {
    return UniversalBackWrapper(
      isRoot: false

      ,child: Scaffold(
      appBar: AppBar(
          title: Text('Partner Preference Filter\nRavaldev Matrimony' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
          toolbarOpacity: 1,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
            onPressed: () {

              navService.goBack();

            },
          )),
      body: SafeArea(child: Container (margin: EdgeInsets.only(bottom: 20)  ,child:ListView(
        padding: EdgeInsets.all(16.0),
        children: switchValues.keys.map((String label) {
          return SwitchListTile(
            title: Text(label , style: TextStyle(color: Colors.black87 , fontSize: 16 , fontWeight: FontWeight.bold),),
            subtitle: Text('Your $label preference'),
            value: switchValues[label]!,
            onChanged: (bool value) async {

              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                switchValues[label] = value;
              });

              if(label == "Age"){
                await prefs.setString(SharedPrefs.ageRange_filter, value.toString());
              }
              if(label == "Height"){
                await prefs.setString(SharedPrefs.heightRange_filter , value.toString());
              }
              if(label == "MaritalStatus"){
                await prefs.setString(SharedPrefs.maritalStatus_prefs_filter , value.toString());
              }
              if(label == "Shakh"){
                await prefs.setString(SharedPrefs.subcaste_prefs_filter, value.toString());
              }
              if(label == "SkinTone"){
                await prefs.setString(SharedPrefs.skintoneprefs_filter, value.toString());
              }
              if(label == "State"){
                await prefs.setString(SharedPrefs.state_prefs_filter, value.toString());
              }
              if(label == "City"){
                await prefs.setString(SharedPrefs.city_prefs_filter, value.toString());
              }
              if(label == "Education"){
                await prefs.setString(SharedPrefs.education_prefs_filter, value.toString());
              }
              if(label == "Occupation"){
                await prefs.setString(SharedPrefs.occupation_prefs_filter, value.toString());
              }
              if(label == "BodyType"){
                await prefs.setString(SharedPrefs.bodyType_prefs_filter, value.toString());
              }
              if(label == "DietType"){
                await prefs.setString(SharedPrefs.dietType_prefs_filter, value.toString());
              }
              if(label == "DrinkType"){
                await prefs.setString(SharedPrefs.drinkType_prefs_filter, value.toString());
              }
              if(label == "SmokeType"){
                await prefs.setString(SharedPrefs.smokeType_prefs_filter, value.toString());
              }
              if(label == "FamilyValue"){
                await prefs.setString(SharedPrefs.familyValue_prefs_filter, value.toString());
              }
              if(label == "AnnualIncome"){
                await prefs.setString(SharedPrefs.annualIncome_prefs_filter, value.toString());
              }


            },
          );
        }).toList(),
      ),),),
    ));
  }
}

