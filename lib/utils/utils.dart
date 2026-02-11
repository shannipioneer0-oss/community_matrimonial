

import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_utils/Dialogs.dart';
import '../locale/TranslationService.dart';
import 'SharedPrefs.dart';


class utils{


  bool isValidDate(String rawDate) {
    try {
      final parts = rawDate.split('-');
      if (parts.length != 3) return false;

      int year = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int day = int.parse(parts[2]);

      // Check if the date is valid
      DateTime date = DateTime(year, month, day);

      return date.year == year && date.month == month && date.day == day;
    } catch (e) {
      return false;
    }
  }


  bool isValidDateDDMMYYYY(String input) {
    try {
      final DateFormat format = DateFormat('dd/MM/yyyy');
      final DateTime date = format.parseStrict(input);
      return true;
    } catch (e) {
      return false;
    }
  }



  int calculateAge(String dob) {



    DateTime currentDate = DateTime.now();
    DateTime? birthDate;

    if (isValidDate(dob)) {
      birthDate = DateTime.parse(
          dob.split('-').map((e) => e.padLeft(2 , '0')).join('-')
      );

    }else{

     // print(dob.split('-').map((e) => e.padLeft(2 , '0')).join('-')+"=-()()");

      try{

        birthDate =  DateTime.parse(dob.split('-').map((e) => e.padLeft(2 , '0')).join('-'));

      }catch(ex){

      }

    }

    int age = -1;

    if(birthDate != null) {
      age = currentDate.year - birthDate!.year;

      // Adjust age if the birthday hasn't occurred yet this year
      if (currentDate.month < birthDate.month ||
          (currentDate.month == birthDate.month &&
              currentDate.day < birthDate.day)) {
        age--;
      }
    }



    return age;
  }


  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


  final _chars2 = '1234567890';
  Random _rnd2 = Random();
  String getRandomString2(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars2.codeUnitAt(_rnd2.nextInt(_chars2.length))));


  String getTodayDate(){
    DateTime today = DateTime.now();
    return '${today.year}-${today.month}-${today.day}';
   }


  String getTodayDateInSeq(){
    DateTime today = DateTime.now();
    return '${today.day}-${today.month}-${today.year}';
  }



  String marathiToEnglish(String input) {
    // Map Marathi digits to English digits
    Map<String, String> digitMap = {
      '०': '0',
      '१': '1',
      '२': '2',
      '३': '3',
      '४': '4',
      '५': '5',
      '६': '6',
      '७': '7',
      '८': '8',
      '९': '9',
    };

    // Replace Marathi digits with English digits
    String output = input.replaceAllMapped(
      RegExp(r'[०-९]'),
          (match) => digitMap[match.group(0)] ?? match.group(0).toString(),
    );

    return output;
  }


   String convertMarathiDateToEnglish(String marathiDate) {
    // Split the Marathi date by '-'

    // print(marathiDate+"====");

    /* var inputFormat = DateFormat('dd-MM-yyyy');
     var date1 = inputFormat.parse(marathiDate);

     print(date1.toString()+"[][][]");*/
     String year = "" ,month = "" ,day = "";

     try {
       var outputFormat = DateFormat('yyyy-MM-dd');
       var date2 = outputFormat.parse(marathiDate);


       List<String> parts = date2.toString().split('-');


       // Convert each part from Marathi digits to English digits
        year = _convertMarathiDigitsToEnglish(parts[0]);
        month = _convertMarathiDigitsToEnglish(parts[1]);
        day = _convertMarathiDigitsToEnglish(parts[2]);
     }catch(ex){

       return '$year-$month-$day';

     }

    // Return the formatted English date

     return '$year-$month-$day';
  }

  String _convertMarathiDigitsToEnglish(String marathiDigits) {
    // Define a mapping for Marathi digits to English digits
    Map<String, String> marathiToEnglishDigits = {
      '०': '0',
      '१': '1',
      '२': '2',
      '३': '3',
      '४': '4',
      '५': '5',
      '६': '6',
      '७': '7',
      '८': '8',
      '९': '9',
    };

    // Convert each Marathi digit to English digit
    String englishDigits = '';
    for (int i = 0; i < marathiDigits.length; i++) {
      String marathiDigit = marathiDigits[i];
      if (marathiToEnglishDigits.containsKey(marathiDigit)) {
        englishDigits += marathiToEnglishDigits[marathiDigit].toString();
      } else {
        // If the digit is not found in the mapping, keep it unchanged
        englishDigits += marathiDigit;
      }
    }

    return englishDigits;
  }

  bool containsEnglishDigits(String text) {
    // Regular expression to match English digits
    RegExp regex = RegExp(r'\d');

    // Check if the text contains English digits
    return regex.hasMatch(text);
  }


  Future<bool> isconnected() async {

    ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {

        return false;
    }else{

      return true;
    }

   }


  String formatGivenDate(String givenDate) {
    DateTime parsedDate;

    // Try to parse using the format that handles both single and zero-padded months/days
    try {
      // Attempt to parse with the first format (e.g., "yyyy-MM-dd" for zero-padded)
      parsedDate = DateFormat('yyyy-MM-dd').parse(givenDate);
    } catch (e) {
      // If the first format fails, try the second format (e.g., "yyyy-M-d" for single digits)
      parsedDate = DateFormat('yyyy-M-d').parse(givenDate);
    }

    // Format the parsed date in dd-MM-yyyy format
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

    return formattedDate;
  }

  String convertDateYYYYMMDD(String input) {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');

    final date = inputFormat.parseStrict(input);
    return outputFormat.format(date);
  }


  String replaceNull(String input) {
    return input == "null" ? "" : input;
  }

  String imagePath(String communityId){

      return "matrimonial_photo/"+communityId+"/";
  }



  Future<String> getMobileNumber(String numberWithCode) async {
    try {
      // Parse the phone number
      PhoneNumber phoneNumber = await PhoneNumber.fromCompleteNumber(completeNumber: numberWithCode);



      // Get only the national number (without country code)
      return numberWithCode.isNotEmpty ? phoneNumber.number+"_"+phoneNumber.countryISOCode  :  "";
    } catch (e) {
      return 'Invalid number: $e';
    }
  }



  void dialPhoneNumber(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }



   Future<bool> validationalerts(BuildContext context) async {

    String fullname = "" , dob = ""  ,createdby = "" , marital = "" , caste = "" , subcaste = "";
    String height = "" , wieght = "" , skintone = "" ,body_type = "" , handicap ="" , mobile = "" , country = "" ;
    String perm_state = "" ,perm_city = ""  ,education = "" , occuapation = "" ,father_name = "" , mother_name = "";
    String father_coccup = "" , mother_occup = ""  , house_owned = "" , house_type = ""  ;
    String membername1 = "" ,membername2 ="" ,relation1 = "" ,relation2 = "" ,marital1 = "" ,marital2 = "" , age1 = "" ,age2 ="" ;

    SharedPreferences prefs = await SharedPreferences.getInstance();

     fullname =
         prefs.getString(SharedPrefs.firstName).toString() + " " +
             prefs.getString(SharedPrefs.lastname).toString();
     dob = prefs.getString(SharedPrefs.dob).toString();
    createdby = prefs.getString(SharedPrefs.createdBy).toString();
    marital = prefs.getString(SharedPrefs.maritalStatus).toString();
    caste = prefs.getString(SharedPrefs.caste).toString();
    subcaste = prefs.getString(SharedPrefs.subcaste_shakh).toString();

    height = prefs.getString(SharedPrefs.height).toString();
    wieght = prefs.getString(SharedPrefs.weight).toString();
    skintone = prefs.getString(SharedPrefs.skinTone).toString();
    body_type = prefs.getString(SharedPrefs.bodyType).toString();
    handicap = prefs.getString(SharedPrefs.isHandicap).toString();

    mobile = prefs.getString(SharedPrefs.mobileNumber).toString();
     country = prefs.getString(SharedPrefs.permCountry).toString();
     perm_state =prefs.getString(SharedPrefs.permState).toString();
    perm_city =  prefs.getString(SharedPrefs.permCity).toString();

    education = prefs.getString(SharedPrefs.education).toString();
    occuapation = prefs.getString(SharedPrefs.occupation).toString();

     father_name = prefs.getString(SharedPrefs.fatherName).toString();
             mother_name = prefs.getString(SharedPrefs.motherName).toString();
             father_coccup =prefs.getString(SharedPrefs.fatherOccupation).toString();
             mother_occup = prefs.getString(SharedPrefs.motherOccupation).toString();
             house_owned = prefs.getString(SharedPrefs.houseOwned).toString();
             house_type =prefs.getString(SharedPrefs.houseType).toString();


  membername1 = prefs.getString(SharedPrefs.membername1).toString();
  relation1 = prefs.getString(SharedPrefs.relation1).toString();
  marital1 = prefs.getString(SharedPrefs.marital1).toString();
   age1 = prefs.getString(SharedPrefs.age1).toString();

    membername2 = prefs.getString(SharedPrefs.membername1).toString();
    relation2 = prefs.getString(SharedPrefs.relation1).toString();
    marital2 = prefs.getString(SharedPrefs.marital1).toString();
     age2 = prefs.getString(SharedPrefs.age1).toString();




    if(fullname.trim() == "null" || dob == "null" || createdby == "null" || marital == "null" || caste == "null" || subcaste == "null" ||
         height == "null" || wieght == "null" || skintone == "null" || body_type == "null" || handicap == "null" || mobile == "null" || country == "null"
         || perm_state == "null" || perm_city == "null" || education == "null" || father_name == "null" || mother_name == "null"
         || father_coccup == "null" || mother_occup == "null" || house_owned == "null" || house_type == "null" || membername1 == "null" || membername2 == "null"
         || relation1 == "null" || relation2 == "null" || marital1 == "null" || marital2 == "null" || age1 == "null" || age2 == "null"){

       final result =   await DialogClass().showPremiumInfoDialog(context, TranslationService.translate("incomplete_alert_title") , TranslationService.translate("incomplete_alert_message") , TranslationService.translate("ok_button"));


       return false;

     }else if(prefs.getString(SharedPrefs.user_verify).toString() == "0") {

      DialogClass().showPremiumInfoDialog(
          context, TranslationService.translate("verification_alert_title") ,
          TranslationService.translate("verification_alert_message") ,
          TranslationService.translate("ok_button"));

      return false;
    }



    return true;

   }


}