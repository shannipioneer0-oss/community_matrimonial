

import 'package:flutter/material.dart';


class SearchDataFilter with ChangeNotifier{

  String profileId = '0';
  String gender = '0';
  String age_from = '18';
  String age_to = '70';
  String height_from = '4ft 0inch';
  String height_to = '7ft 5inch';
  String marital_status = '0';
  String search_name = '0';
  String search_fathername = '0';
  String mother_tongue = '0';
  String location = '0';
  String education = '0';
  String occupation = '0';
  String rashi = '0';
  String birth_star = '0';
  String income = '0';
  String mangalik = '0';
  String handicap = '0';
  String institute_wise = '0';
  String profile_image = '0';


  TextEditingController profileidController = new TextEditingController();
  TextEditingController maritalController = new TextEditingController();

  TextEditingController search_name_controller = new TextEditingController();
  TextEditingController search_fathername_controller = new TextEditingController();
  TextEditingController search_location_controller = new TextEditingController();

  TextEditingController Income_controller = new TextEditingController();


  TextEditingController mothertongueController = new TextEditingController();
  TextEditingController highesteducationController =new TextEditingController();
  TextEditingController occupationController =new TextEditingController();
  TextEditingController rashiController =new TextEditingController();
  TextEditingController birthstarController =new TextEditingController();

  TextEditingController raputedController = new TextEditingController();
  TextEditingController profileImageController = new TextEditingController();


  void clearAllFields() {

    profileidController.text = "";
    maritalController.text = "";
    search_name_controller.text = "";
    search_fathername_controller.text  = "";
    mothertongueController.text = "";
    search_location_controller.text = "";
    highesteducationController.text = "";
    occupationController.text = "";
    rashiController.text = "";
    birthstarController.text = "";
    Income_controller.text = "";
    raputedController.text = "";
    profileImageController.text = "";

    age_from = "18";
    age_to = "70";
    height_from = "4ft 0inch";
    height_to = "7ft 5inch";
    profileId = "0";
    gender = "All";
    marital_status = "0";
    search_name = "0";
    search_fathername = "0";
    mother_tongue = "0";
    location = "0";
    education = "0";
    occupation = "0";
    rashi = "0";
    birth_star = "0";
    income = "0";
    mangalik = "0";
    handicap = "0";
    institute_wise = "0";
    profile_image = "0";


    notifyListeners();
  }


  setvalue(){

    age_from = "20";
    age_to = "0";
    height_from = "0";
    height_to = "0";
    profileId = "0";
    gender = "0";
    marital_status = "0";
    search_name = "0";
    search_fathername = "0";
    mother_tongue = "0";
    location = "0";
    education = "0";
    occupation = "0";
    rashi = "0";
    birth_star = "0";
    income = "0";
    mangalik = "0";
    handicap = "0";
    institute_wise = "0";
    profile_image = "0";

    notifyListeners();

  }




}