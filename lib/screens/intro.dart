import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class IntroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroAppStateful(),
      builder: EasyLoading.init(),
    );
  }
}


class IntroAppStateful extends StatefulWidget {


  @override
  IntroScreen createState() => IntroScreen();

}


class IntroScreen extends State<IntroAppStateful> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SVProgressHUD.dismiss();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Stack(
        fit: StackFit.expand,
        children: [

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/raval_launcher.png'), // Replace with your background image
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Opacity(
              opacity: 0.8,

              child: Container(
                color: Colors.black,
                // Adjust the color based on your design
              ),
            ),
          ),

          Positioned(
            bottom: MediaQuery.of(context).size.height*0.05,
            child: Column(

              children: <Widget>[

                Container(width: MediaQuery.of(context).size.width*0.95 , margin: EdgeInsets.only(left: 10 , right: 15 , bottom: 25)   ,child:Row(children: [
                  Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.asset("assets/images/doubleheart.png" ,  width: 50, height: 50,)
                  ),
                ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Image.asset("assets/images/heart_one.png" ,  width: 42, height: 42,)
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        child: Image.asset("assets/images/heart_two.png" ,  width: 42, height: 42,)
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        child: Image.asset("assets/images/heart_three.png" ,  width: 42, height: 42,)
                    ),
                  ),

                ],)),

                        Container(child:Container(child:RoundedButton(text: "CLICK TO SIGNUP"))),
                        ArrowDownIcon(),
                        RoundedButton(text: 'CONNECT'),
                        ArrowDownIcon(),
                        RoundedButton(text: 'INTERACT'),


               GestureDetector( onTap: () async {

                 SharedPreferences prefs = await SharedPreferences.getInstance();

                 print(prefs.getString(SharedPrefs.isLogin));

                 if(prefs.getString(SharedPrefs.isLogin) == "1") {



    SVProgressHUD.show(status: 'Please Wait....');

    SharedPreferences prefs = await SharedPreferences.getInstance();

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

    print({
      "userId" : prefs.getString(SharedPrefs.userId),
      "communityId":prefs.getString(SharedPrefs.communityId),
      "myuserId":prefs.getString(SharedPrefs.userId),
      "Id":prefs.getString(SharedPrefs.userId),
      "original": "en",
      "translate": ["en"]
    });



    double percent = 0.0;

    var userData = _response2.body["data"][0][0]["0"];

    await prefs.setString(SharedPrefs.translate, "en");

    if(_response2.body["data"][0][0].toString() != "{}") {

      print(userData["dob"]+"()()===()()");

    await prefs.setString(
    SharedPrefs.basic_details_id, userData["Id"].toString());
    await prefs.setString(SharedPrefs.fullname, userData["fullname"]);
    await prefs.setString(SharedPrefs.createdBy, userData["created_by"] ?? "");
    await prefs.setString(SharedPrefs.dob, userData["dob"]);
    await prefs.setString(SharedPrefs.age, userData["age"]);
    await prefs.setString(
    SharedPrefs.maritalStatus, userData["marital_status"] ?? "");
    await prefs.setString(SharedPrefs.caste, userData["caste"] ?? "");
    await prefs.setString(SharedPrefs.subcaste, userData["subcaste"] ?? "");
    await prefs.setString(
    SharedPrefs.languageKnown, userData["language_known"] ?? "");
    await prefs.setString(
    SharedPrefs.motherTongue, userData["mother_tongue"] ?? "");
    await prefs.setString(SharedPrefs.isnri, userData["isnri"] ?? "");
    await prefs.setString(SharedPrefs.nri_details, userData["nri_detail"] ?? "");
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
    SharedPrefs.isHandicap, healthDetails['is_handicap']);
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
    SharedPrefs.educationDetail, adminServiceDetails['education_detail']);

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
    SharedPrefs.annualIncome, occupationDetails['annual_income']);
    await prefs.setString(
    SharedPrefs.employmentType, occupationDetails['employment_type'] ?? "");
    await prefs.setString(
    SharedPrefs.officeAddress, occupationDetails['office_address']);

    percent = percent +  5.55;

    }

    var familyDetails = _response2.body["data"][5][0]["0"];

    if(_response2.body["data"][5][0].toString() != "{}") {
    await prefs.setString(
    SharedPrefs.family_id, familyDetails["Id"].toString());
    await prefs.setString(
    SharedPrefs.familyStatus, familyDetails['family_status'] ?? "");
    await prefs.setString(
    SharedPrefs.familyType, familyDetails['family_type'] ?? "");
    await prefs.setString(
    SharedPrefs.familyValue, familyDetails['family_value'] ?? "");
    await prefs.setString(SharedPrefs.noBrother, familyDetails['no_brother']);
    await prefs.setString(SharedPrefs.noSister, familyDetails['no_sister']);
    await prefs.setString(
    SharedPrefs.marriedBrother, familyDetails['married_brother']);
    await prefs.setString(
    SharedPrefs.marriedSister, familyDetails['married_sister']);
    await prefs.setString(
    SharedPrefs.fatherName, familyDetails['father_name'] ?? "");
    await prefs.setString(
    SharedPrefs.motherName, familyDetails['mother_name'] ?? "");
    await prefs.setString(
    SharedPrefs.fatherOccupation, familyDetails['father_occupation']);
    await prefs.setString(
    SharedPrefs.motherOccupation, familyDetails['mother_occupation']);
    await prefs.setString(
    SharedPrefs.houseOwned, familyDetails['house_owned'] ?? "");
    await prefs.setString(SharedPrefs.houseType, familyDetails['house_type'] ?? "");
    await prefs.setString(SharedPrefs.parentsStayOptions,
    familyDetails['parents_stay_options'] ?? "");
    await prefs.setString(
    SharedPrefs.detailFamily, familyDetails['detail_family']);

    percent = percent +  15.5;
    }


    var astroDetails = _response2.body["data"][6][0]["0"];

    if(_response2.body["data"][6][0].toString() != "{}") {
    await prefs.setString(
    SharedPrefs.horoscope_id, astroDetails["Id"].toString());
  //  await prefs.setString(
   // SharedPrefs.astroRashi, astroDetails['astro_rashi']);
   // await prefs.setString(SharedPrefs.birthStar, astroDetails['birth_star']);
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

    int valincre = 0;

    String value = pictures['pic1'] ?? '';
    String value2 = pictures['pic2'] ?? '';
    String value3 = pictures['pic3'] ?? '';

    value != '' ? valincre = valincre +2 : 0;
    value2 != '' ? valincre = valincre +1 : 0;
    value3 != '' ? valincre = valincre +1 : 0;

    percent = percent +  valincre;

    }

    var userproofs = _response2.body["data"][9][0]["0"];

   // print(userproofs+"=================");

    if(_response2.body["data"][9][0].toString() != "{}"){

    await prefs.setString(SharedPrefs.id_proof, userproofs['id_proofs'].toString() ?? '');
    await prefs.setString(SharedPrefs.education_proof, userproofs['education_proof'].toString() ?? '');
    await prefs.setString(SharedPrefs.income_proof , userproofs['income_proof'].toString() ?? '');

    print(userproofs['id_proofs'].toString()+"---====");

    String value = userproofs['id_proofs'].toString() ?? '';
    String value2 = userproofs['education_proof'].toString() ?? '';
    String value3 = userproofs['income_proof'].toString() ?? '';

    int valincre = 0;

    value != '' ? valincre = valincre +2 : 0;
    value2 != '' ? valincre = valincre +1 : 0;
    value3 != '' ? valincre = valincre +1 : 0;

    percent = percent +  valincre;

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


    String from_age = "" , to_age = "" , from_height = "" , to_height = "";
    /*if(userDetails['age_range'] ?? '' == ""){
      if (prefs.getString(SharedPrefs.gender).toString().toLowerCase() == "male") {

        from_age =   (int.parse(prefs.getString(SharedPrefs.age).toString()) - 3).toString();
        to_age   =   prefs.getString(SharedPrefs.age).toString();

      } else {

        from_age =    prefs.getString(SharedPrefs.age).toString();
        to_age   =   (int.parse(prefs.getString(SharedPrefs.age).toString()) + 3).toString();

      }

      await prefs.setString(SharedPrefs.ageRange , from_age+"-"+to_age ?? '');

    }*/



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

    print(userverify.toString());

    if(_response2.body["data"][16][0].toString() != "{}"){

      String  hobbies =  hobbyverify['hobbies'].toString() ?? '';
      prefs.setString(SharedPrefs.hobbies, hobbies);

    }




    percent = percent +  14;
    }

    print(percent.toString()+"-----------");

    await prefs.setString(SharedPrefs.profile_percentage , percent.toString());

    SVProgressHUD.dismiss();

                   navService.pushNamed("/main_screen" , args: -1);

                 }else{

                   navService.pushNamed("/login");

                 }


               }  ,child:Container(margin: EdgeInsets.only(top: 30)  ,child:Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularButton(),
                    Positioned(

                      child: ArrowUpIcon(),
                    ),
                  ],
                ),),),


              ],

            ),
          ),





        ],
      ),
    ));
  }
}






class RoundedButton extends StatelessWidget {

  final String text;
  const RoundedButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.6,
      height: 45,
      margin: EdgeInsets.only(left: 10 , right: 10),
      child: TextButton(
        onPressed: () async {

          if(text == "CLICK TO SIGNUP"){
            navService.pushNamed("/signup");
          }


        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.pink, // Change the button color as needed
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Adjust the border radius
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),

          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ArrowDownIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        Icons.arrow_downward,
        size: 30,
        color: Colors.pink,
      ),
    );
  }
}






class CircularButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.pink.shade600, // Change the color as needed
      ),
      child: Center(
        child: Text(
          '',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class ArrowUpIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [ Text("NEXT" , style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 15 ,color: Colors.white),) , SizedBox(width: 10,)  , Icon(
      Icons.arrow_right,
      size: 30,
      color: Colors.white, // Change the color as needed
    )],);
  }
}