import 'dart:async';
import 'dart:ui';

import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/RichTextFieldWithIndividualOnTap.dart';
import 'package:community_matrimonial/app_utils/TextFieldWithImage.dart';
import 'package:community_matrimonial/network_utils/model/get_otp.dart';
import 'package:community_matrimonial/screens/OtpFields.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/ImageOverlayPainter.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:community_matrimonial/utils/data.dart';
import '../network_utils/service/api_service.dart';
import 'package:http/http.dart' as http;


class LoginVerifyApp extends StatelessWidget {

  final List mobile_number;
  LoginVerifyApp({required this.mobile_number});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginVerifyAppStateful(mobile_number: mobile_number,),
    );
  }


}


class LoginVerifyAppStateful extends StatefulWidget {

  final List mobile_number;

  LoginVerifyAppStateful( {required this.mobile_number});

  @override
  LoginScreenVerify createState() => LoginScreenVerify();

}


class LoginScreenVerify extends State<LoginVerifyAppStateful> {

  final TextEditingController _otpController = TextEditingController();
  final FocusNode _firstFocusNode = FocusNode();
  final FocusNode _secondFocusNode = FocusNode();
  final FocusNode _thirdFocusNode = FocusNode();
  final FocusNode _fourthFocusNode = FocusNode();
  final FocusNode _fifthFocusNode = FocusNode();
  final FocusNode _sixFocusNode = FocusNode();


   String otp_values = "" , otp_value = "";

   @override
  void initState() {
    super.initState();


    initGetOtp();
    startTimer();

  }

  initSendSms(String otp) async {


     print(widget.mobile_number[1]);

       if(widget.mobile_number[1] == "1") {

         print(widget.mobile_number[1]+"-=-=-=");

         final responseSendSms = await http.get(Uri.parse(
             "http://piosys.co.in/SendSMS.aspx?UserName=shah.shanni2010@gmail.com&Password=Shanni9898100385&SenderId=COMMSG&Message=Dear Member " +
                 otp +
                 " Verification Code For Community Matrimonial Mobile Application For Raval samaj  Use it to Proceed... PS&MobileNo=" +
                 widget.mobile_number[0] +
                 "&EntityId=1701158046859603415&TemplateId=1707162823932242380"));

         print(responseSendSms.body);

       }


  }

  initGetOtp() async {

    final _response = await Provider.of<ApiService>(
        context, listen: false).getOtp({
      "mobile_number": widget.mobile_number[0],
    });
    get_otp getotp = get_otp.fromJson(_response.body);

    setState(() {
     otp_values = getotp.message[0].otp.toString();
    });

    initSendSms(getotp.message[0].otp.toString());

   /* final res = await DialogClass().showDialogBeforesubmit(context, "OTP " , "Your OTP is "+getotp.message[0].otp.toString() , "Copy" , "1");

    if(res != null) {

      WidgetsBinding.instance.addPostFrameCallback((_) =>

      setState(() {
        otp_values = getotp.message[0].otp.toString();
      })

      );


    }*/

  }

  int _seconds = 60;            // countdown duration
  Timer? _timer;
  bool _canResend = false;


  void startTimer() {
    _canResend = false;
    _seconds = 60;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }


  void resend() {
    // TODO: Add your resend logic here
    print("Resend clicked");

    initGetOtp();

    startTimer(); // restart countdown after resend
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

    body:SingleChildScrollView(child:Container(color: Colors.white , height: MediaQuery.of(context).size.height  ,child:Stack(
    fit: StackFit.expand,
    alignment: Alignment.topCenter,
    children: [
    // Background Image
    Image.asset( 'assets/images/image_top_edit_two.png' ,
    height: MediaQuery.of(context).size.height*0.4,
    fit: BoxFit.contain,
    alignment: Alignment.topCenter,
    ),

      Positioned(top: MediaQuery.of(context).size.height*0.4 , left:MediaQuery.of(context).size.width*0.17 ,child: Text("VERIFY" , style: TextStyle(color: Colors.pink , fontSize:18 , fontWeight: FontWeight.w700 ),)),
      Positioned(top: MediaQuery.of(context).size.height*0.36 , left:MediaQuery.of(context).size.width*0.65 ,child: Image.asset("assets/images/heart.png" , width: 45 , height: 45, color: Colors.pink,),),
      Positioned(top: MediaQuery.of(context).size.height*0.45, left:MediaQuery.of(context).size.width*0.17 ,child: Text("" , style: TextStyle(color: Colors.black87 , fontSize:18 , fontWeight: FontWeight.w700 ),)),

      Positioned(top: MediaQuery.of(context).size.height*0.5 ,child: Card(
        elevation: 8.0, // Set the elevation for the embossed effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Set the border radius
          side: BorderSide(
            color: Colors.grey[300]!, // Set the border color
            width: 1.0, // Set the border width
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width*0.8,
          margin: EdgeInsets.only(left: 15 , right: 15),
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left:5 , top:15 , bottom: 5),

          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

          Text(
            Strings.verify_label ,
            style: TextStyle(
              fontSize: 16.0 ,
              fontWeight: FontWeight.bold ,
            ),
          ),
            Container(margin:EdgeInsets.only(top:10)   ,child: otp_values.isEmpty ? OtpFields(callback: (p0) {


              otp_value = p0;
              print(p0);


            }, otp: otp_values,) : OtpFields(callback: (p0) {


              otp_value = p0;
              print(p0);


            }, otp: otp_values,), ),

              Container(width: MediaQuery.of(context).size.width*0.8  ,child:Column(crossAxisAlignment: CrossAxisAlignment.center  ,children: [

                Text(
                  _canResend ? "You can resend now" : "Resend in $_seconds seconds", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: _canResend ? resend : null,
                  child: Text("Resend"),
                ),

                SizedBox(height: 5),

              ],),),



            Row(children: [

               Expanded(flex: 1 ,child: GestureDetector(onTap:() async {

                 SVProgressHUD.show(status: 'Verifying OTP Please Wait....');

                 final _response = await Provider.of<ApiService>(context, listen: false).verifyOtp(
                     {
                       "mobile": widget.mobile_number[0].toString(),
                       "otp":  otp_value
                     }
                 );

                 print(_response.body.toString()+"-=-="+otp_value);

                 if(_response.body["data"] == "success"){

                   SharedPreferences prefs = await SharedPreferences.getInstance();

                   print({
                     "userId" : prefs.getString(SharedPrefs.userId),
                     "communityId":prefs.getString(SharedPrefs.communityId),
                     "myuserId":prefs.getString(SharedPrefs.userId),
                     "Id":prefs.getString(SharedPrefs.userId),
                     "original": "en",
                     "translate": ["en"]
                   });

                   final _response2 = await Provider.of<ApiService>(context, listen: false).postProfileDetailsFetchValuelabel(
                       {
                         "userId" : prefs.getString(SharedPrefs.userId),
                         "communityId":prefs.getString(SharedPrefs.communityId),
                         "myuserId":prefs.getString(SharedPrefs.userId),
                         "Id":prefs.getString(SharedPrefs.userId),
                         "original": "en",
                         "translate": ["en"]
                       }
                   );


                   print(_response2.body);


                   double percent = 0.0;

                   var userData = _response2.body["data"][0][0]["0"];

                   await prefs.setString(SharedPrefs.translate, "en");

    if(_response2.body["data"][0][0].toString() != "{}") {
      await prefs.setString(
          SharedPrefs.basic_details_id, userData["Id"].toString());
      await prefs.setString(SharedPrefs.fullname, userData["fullname"]);
      await prefs.setString(SharedPrefs.createdBy, userData["created_by"] ?? "");
      await prefs.setString(SharedPrefs.dob, userData["dob"]);
      await prefs.setString(SharedPrefs.age, userData["age"]);
      await prefs.setString(
          SharedPrefs.maritalStatus, userData["marital_status"] ?? "");
      await prefs.setString(SharedPrefs.caste, userData["caste"] ?? '');
      await prefs.setString(SharedPrefs.subcaste, userData["subcaste"] ?? "");
      await prefs.setString(SharedPrefs.isnri, userData["isnri"] ?? "");
      await prefs.setString(SharedPrefs.nri_details, userData["nri_detail"] ?? "");
      await prefs.setString(
          SharedPrefs.languageKnown, userData["language_known"] ?? "");
      await prefs.setString(
          SharedPrefs.motherTongue, userData["mother_tongue"] ?? "");
      await prefs.setString(
          SharedPrefs.profileId, userData["profileId"] ?? "");

      percent = percent +  10;
    }

                   var contactInfo = _response2.body["data"][1][0]["0"];

    if(_response2.body["data"][1][0].toString() != "{}") {
      await prefs.setString(
          SharedPrefs.contact_details_id, contactInfo["Id"].toString());
      await prefs.setString(
          SharedPrefs.mobileNumber, contactInfo["mobile_number"]);
      await prefs.setString(
          SharedPrefs.whatsappNumber, contactInfo["whatsapp_number"]);
      await prefs.setString(
          SharedPrefs.permanentAddress, contactInfo["permanent_adddress"]);
      await prefs.setString(SharedPrefs.emailId, contactInfo["emailid"]);
      await prefs.setString(
          SharedPrefs.alternateMobile, contactInfo["alternate_mobile"] ?? "");
      await prefs.setString(
          SharedPrefs.alternateEmail, contactInfo["alternate_email"] ?? "");
      await prefs.setString(
          SharedPrefs.workingAddress, contactInfo["working_address"] ?? "");
      await prefs.setString(
          SharedPrefs.contactTime, contactInfo["contact_time"] ?? "");
      await prefs.setString(
          SharedPrefs.permCountry, contactInfo["perm_country"] ?? "");
      await prefs.setString(SharedPrefs.permState, contactInfo["perm_state"] ?? "");
      await prefs.setString(SharedPrefs.permCity, contactInfo["perm_city"] ?? "");
      await prefs.setString(SharedPrefs.workState, contactInfo["work_state"] ?? "");
      await prefs.setString(SharedPrefs.workCity, contactInfo["work_city"] ?? "");

      percent = percent +  15.5;
    }

                   var healthDetails = _response2.body["data"][2][0]["0"];

    if(_response2.body["data"][2][0].toString() != "{}") {
      await prefs.setString(
          SharedPrefs.lifestyle_details_id, healthDetails["Id"].toString());
      await prefs.setString(SharedPrefs.weight, healthDetails['weight'] ?? "");
      await prefs.setString(SharedPrefs.height, healthDetails['height'] ?? "");
      await prefs.setString(SharedPrefs.skinTone, healthDetails['skintone'] ?? "");
      await prefs.setString(
          SharedPrefs.bloodGroup, healthDetails['blood_group'] ?? "");
      await prefs.setString(SharedPrefs.fitness, healthDetails['fitness'] ?? "");
      await prefs.setString(SharedPrefs.bodyType, healthDetails['body_type'] ?? "");
      await prefs.setString(
          SharedPrefs.isHandicap, healthDetails['is_handicap'] ?? "");
      await prefs.setString(
          SharedPrefs.handicapDetail, healthDetails['handicap_detail'] ?? "");
      await prefs.setString(SharedPrefs.dietType, healthDetails['diet_type'] ?? "");
      await prefs.setString(SharedPrefs.drinkType, healthDetails['drink_type'] ?? "");
      await prefs.setString(SharedPrefs.smokeType, healthDetails['smoke_type'] ?? "");

      percent = percent +  12.5;

    }

                   var adminServiceDetails = _response2.body["data"][3][0]["0"];

    if(_response2.body["data"][3][0].toString() != "{}") {
      await prefs.setString(
          SharedPrefs.education_id, adminServiceDetails["Id"].toString());
      await prefs.setString(SharedPrefs.isFromAdminService,
          adminServiceDetails['is_from_admin_service'] ?? "");
      await prefs.setString(SharedPrefs.adminPositionName,
          adminServiceDetails['admin_position_name'] ?? "");
      await prefs.setString(SharedPrefs.isFromIITIIMNIT,
          adminServiceDetails['is_from_iit_iim_nit'] ?? "");
      await prefs.setString(
          SharedPrefs.instituteName, adminServiceDetails['institute_name'] ?? "");
      await prefs.setString(
          SharedPrefs.education, adminServiceDetails['education'] ?? "");
      await prefs.setString(
          SharedPrefs.educationDetail, adminServiceDetails['education_detail'] ?? "");

      percent = percent +  5;

    }

                   var occupationDetails = _response2.body["data"][4][0]["0"];

    if(_response2.body["data"][4][0].toString() != "{}") {
      await prefs.setString(
          SharedPrefs.occupation_id, occupationDetails["Id"].toString());
      await prefs.setString(
          SharedPrefs.occupation, occupationDetails['occupation'] ?? "");
      await prefs.setString(
          SharedPrefs.occupationDetail, occupationDetails['occupation_detail'] ?? "");
      await prefs.setString(
          SharedPrefs.annualIncome, occupationDetails['annual_income'] ?? "");
      await prefs.setString(
          SharedPrefs.employmentType, occupationDetails['employment_type'] ?? "");
      await prefs.setString(
          SharedPrefs.officeAddress, occupationDetails['office_address'] ?? "");

      percent = percent +  5.55;

    }

                   var familyDetails = _response2.body["data"][5][0]["0"];

    if(_response2.body["data"][5][0].toString() != "{}") {
      await prefs.setString(
          SharedPrefs.family_id, familyDetails["Id"].toString());
      await prefs.setString(
          SharedPrefs.familyStatus, familyDetails['family_status'] ?? "");
      await prefs.setString(
          SharedPrefs.familyType, familyDetails['family_type'] ??  "");
      await prefs.setString(
          SharedPrefs.familyValue, familyDetails['family_value'] ?? "");
      await prefs.setString(SharedPrefs.noBrother, familyDetails['no_brother'] ?? "");
      await prefs.setString(SharedPrefs.noSister, familyDetails['no_sister'] ?? "");
      await prefs.setString(
          SharedPrefs.marriedBrother, familyDetails['married_brother']);
      await prefs.setString(
          SharedPrefs.marriedSister, familyDetails['married_sister']);
      await prefs.setString(
          SharedPrefs.fatherName, familyDetails['father_name'] ?? "");
      await prefs.setString(
          SharedPrefs.motherName, familyDetails['mother_name'] ?? "");
      await prefs.setString(
          SharedPrefs.fatherOccupation, familyDetails['father_occupation'] ?? "");
      await prefs.setString(
          SharedPrefs.motherOccupation, familyDetails['mother_occupation'] ?? "");
      await prefs.setString(
          SharedPrefs.houseOwned, familyDetails['house_owned'] ?? "");
      await prefs.setString(SharedPrefs.houseType, familyDetails['house_type'] ?? "");
      await prefs.setString(SharedPrefs.parentsStayOptions,
          familyDetails['parents_stay_options'] ??   "");
      await prefs.setString(
          SharedPrefs.detailFamily, familyDetails['detail_family'] ?? "");

      percent = percent +  15.5;
    }


                   var astroDetails = _response2.body["data"][6][0]["0"];

    if(_response2.body["data"][6][0].toString() != "{}") {
      await prefs.setString(
          SharedPrefs.horoscope_id, astroDetails["Id"].toString());
     // await prefs.setString(
      //    SharedPrefs.astroRashi, astroDetails['astro_rashi']);
  //    await prefs.setString(SharedPrefs.birthStar, astroDetails['birth_star']);
      await prefs.setString(SharedPrefs.gotra, astroDetails['gotra']);
      await prefs.setString(
          SharedPrefs.believeHoroscope, astroDetails['believe_horoscope']);
      await prefs.setString(SharedPrefs.birthDate, astroDetails['birth_date']);
      await prefs.setString(
          SharedPrefs.birthPlace, astroDetails['birth_place']);
      await prefs.setString(SharedPrefs.birthTime, astroDetails['birth_time']);
      await prefs.setString(
          SharedPrefs.birthCountry, astroDetails['birth_country']);
      await prefs.setString(
          SharedPrefs.horoscopeDoc, astroDetails['horoscope_doc']);
      await prefs.setString(SharedPrefs.timezone, astroDetails['timezone']);
      await prefs.setString(
          SharedPrefs.isMangalik, astroDetails['is_mangalik']);

      percent = percent +  14;
    }



                   if(_response2.body["data"][7][0].toString() != "{}") {
                     var pictures = _response2.body["data"][7][0]["0"];

                     print(pictures['Id'].toString()+"----------------------++++++++");

                     await prefs.setString(
                         SharedPrefs.pic_id, pictures['Id'].toString() ?? '');
                     await prefs.setString(
                         SharedPrefs.pic1, pictures['pic1'] ?? '');
                     await prefs.setString(
                         SharedPrefs.pic1, pictures['pic1'] ?? '');
                     await prefs.setString(
                         SharedPrefs.pic2, pictures['pic2'] ?? '');
                     await prefs.setString(
                         SharedPrefs.pic3, pictures['pic3'] ?? '');
                     await prefs.setString(
                         SharedPrefs.pic4, pictures['pic4'] ?? '');
                     await prefs.setString(
                         SharedPrefs.pic5, pictures['pic5'] ?? '');
                     await prefs.setString(
                         SharedPrefs.pic6, pictures['pic6'] ?? '');
                     await prefs.setString(
                         SharedPrefs.pic7, pictures['pic7'] ?? '');
                     await prefs.setString(
                         SharedPrefs.pic8, pictures['pic8'] ?? '');
                     await prefs.setString(
                         SharedPrefs.pic9, pictures['pic9'] ?? '');
                     await prefs.setString(
                         SharedPrefs.pic10, pictures['pic10'] ?? '');
                     await prefs.setString(SharedPrefs.isVerifyPic1,
                         pictures['isverifypic1'] ?? '0');
                     await prefs.setString(SharedPrefs.isVerifyPic2,
                         pictures['isverifypic2'] ?? '0');
                     await prefs.setString(SharedPrefs.isVerifyPic3,
                         pictures['isverifypic3'] ?? '0');
                     await prefs.setString(SharedPrefs.isVerifyPic4,
                         pictures['isverifypic4'] ?? '0');
                     await prefs.setString(SharedPrefs.isVerifyPic5,
                         pictures['isverifypic5'] ?? '0');
                     await prefs.setString(SharedPrefs.isVerifyPic6,
                         pictures['isverifypic6'] ?? '0');
                     await prefs.setString(SharedPrefs.isVerifyPic7,
                         pictures['isverifypic7'] ?? '0');
                     await prefs.setString(SharedPrefs.isVerifyPic8,
                         pictures['isverifypic8'] ?? '0');
                     await prefs.setString(SharedPrefs.isVerifyPic9,
                         pictures['isverifypic9'] ?? '0');
                     await prefs.setString(SharedPrefs.isVerifyPic10,
                         pictures['isverifypic10'] ?? '0');

                     percent = percent +  4;

                   }

                   var userproofs = _response2.body["data"][9][0]["0"];

                 //  print(userproofs+"=================");

                   if(_response2.body["data"][9][0].toString() != "{}"){

                     await prefs.setString(SharedPrefs.id_proof, userproofs['id_proofs'].toString() ?? '');
                     await prefs.setString(SharedPrefs.education_proof, userproofs['education_proof'].toString() ?? '');
                     await prefs.setString(SharedPrefs.income_proof , userproofs['income_proof'].toString() ?? '');

                     percent = percent +  4;

                   }

                   var userDetails = _response2.body["data"][10][0]["0"];

    if(_response2.body["data"][10][0].toString() != "{}") {
      await prefs.setString(
          SharedPrefs.partner_prefs_id, userDetails['Id'].toString() ?? '');
      await prefs.setString(
          SharedPrefs.ageRange, userDetails['age_range'] ?? '');
      await prefs.setString(
          SharedPrefs.heightRange, userDetails['height_range'] ?? '');
      await prefs.setString(
          SharedPrefs.maritalStatus_prefs, userDetails['marital_status'] ?? '');
      await prefs.setString(
          SharedPrefs.caste_prefs, userDetails['caste'] ?? '');
      await prefs.setString(
          SharedPrefs.subcaste_prefs, userDetails['subcaste'] ?? '');
      await prefs.setString(
          SharedPrefs.state_prefs, userDetails['state'] ?? '');
      await prefs.setString(SharedPrefs.city_prefs, userDetails['city'] ?? '');
      await prefs.setString(
          SharedPrefs.skintoneprefs, userDetails['skintone'] ?? '');
      await prefs.setString(
          SharedPrefs.education_prefs, userDetails['education_list'] ?? '');
      await prefs.setString(
          SharedPrefs.occupation_prefs, userDetails['occupation'] ?? '');
      await prefs.setString(
          SharedPrefs.familyValue_prefs, userDetails['family_value'] ?? '');
      await prefs.setString(
          SharedPrefs.dietType_prefs, userDetails['diet_type'] ?? '');
      await prefs.setString(
          SharedPrefs.bodyType_prefs, userDetails['body_type'] ?? '');
      await prefs.setString(
          SharedPrefs.drinkType_prefs, userDetails['drink_type'] ?? '');
      await prefs.setString(
          SharedPrefs.smokeType_prefs, userDetails['smoke_type'] ?? '');
      await prefs.setString(
          SharedPrefs.annualIncome_prefs, userDetails['annual_income'] ?? '');
      await prefs.setString(
          SharedPrefs.partnerDetails, userDetails['partner_details'] ?? '');


      var userverify = _response2.body["data"][15][0]["0"];

      print(userverify.toString());

      if(_response2.body["data"][15][0].toString() != "{}"){

      String  user_verify =  userverify['user_verify'].toString() ?? '';
      String  email_verify = userverify['email_verify'].toString() ?? '';
      String   mobile_verify = userverify['mobile_verify'].toString() ?? '';

      prefs.setString(SharedPrefs.verify_email, email_verify);
      prefs.setString(SharedPrefs.user_verify, user_verify);
      prefs.setString(SharedPrefs.mobile_verify , mobile_verify);

      }




      var hobbyverify = _response2.body["data"][16][0]["0"];

      print(hobbyverify.toString());

      if(_response2.body["data"][16][0].toString() != "{}"){

        String  hobbies =  hobbyverify['hobbies'].toString() ?? '';
        prefs.setString(SharedPrefs.hobbies , hobbies);

      }


      String from_age = "" , to_age = "" , from_height = "" , to_height = "";
      /*if(userDetails['age_range'] ?? '' == ""){
        if (prefs.getString(SharedPrefs.gender).toString().toLowerCase() == "male") {

          from_age =   (int.parse(prefs.getString(SharedPrefs.age).toString()) - 3).toString();
          to_age   =   prefs.getString(SharedPrefs.age).toString();

        } else {

          from_age =    prefs.getString(SharedPrefs.age).toString();
          to_age   =   (int.parse(prefs.getString(SharedPrefs.age).toString()) + 3).toString();

        }
        await prefs.setString(SharedPrefs.ageRange, from_age+"-"+to_age ?? '');

      }*/

      percent = percent +  14;
    }

    print(percent.toString()+"-----------");

                   await prefs.setString(SharedPrefs.profile_percentage , percent.toString());
                   await prefs.setString(SharedPrefs.isLogin, "1" ?? '');

                   SVProgressHUD.dismiss();

                   navService.pushNamed("/main_screen" , args:-1);
                 }else{

                   SVProgressHUD.dismiss();
                   DialogClass().showDialog2(context, "OTP Verification Alert!", "No Such OPT exists", "Ok");

                 }


               },child:RoundedContainer(text: Strings.verify, color: ColorsPallete.blue_2),)),
                SizedBox(width: 10),
               Expanded(flex: 1 ,child: GestureDetector(onTap:(){



               },child:RoundedContainer(text: Strings.resend , color: ColorsPallete.Pink),))


             ],),
              SizedBox(height: 15),

          ],)


        ),
      )),



      ]))


    ));


  }


}