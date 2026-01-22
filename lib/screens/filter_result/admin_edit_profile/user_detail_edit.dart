



import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/StylishDrawer.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/user_profile/ProfileDetailItem.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailOtherEdit extends StatelessWidget {

   final String userId;
   UserDetailOtherEdit(this.userId);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserDetailStateful(userId : userId),
      builder: EasyLoading.init(),

    );
  }
}


class UserDetailStateful extends StatefulWidget {

  final String userId;
  UserDetailStateful({ required this.userId});

  @override
  UserDetailScreen createState() => UserDetailScreen();

}

class UserDetailScreen  extends State<UserDetailStateful>{

  GlobalKey<ScaffoldState> _scaffoldKeyglobal = GlobalKey<ScaffoldState>();

  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);


  @override
  void initState() {
    super.initState();

    _checkConnectivity();

    initdata();

  }


  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  Future<void> _checkConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = result;
    });
    if (_connectivityResult == ConnectivityResult.none) {
      DialogClass().showNoInternetAlert(context);
    }
  }



  String fullname = "" , dob = ""  , age = "" , createdby = "" , marital = "" , caste = "" , subcaste = "" , lang_known = "", mother_tongue = "" , profileId = "" ,basic_details_id = "" ,createdby_id = "" ,marital_id = "" ,caste_id = "" ,subcaste_id = "" , lang_known_id = "" , mother_tonuge_id = "" , nri_details = "" ,isnri = "";
  String height = "" , wieght = "" , skintone = "" ,bld_group = "" , body_type ="" ,diet_type = "" ,drink_type = "" ,smoke_type = "" ,fitness ="", handicap = "" ,handicap_details ="" , overall_health_details= "" , contact_details_id = "" ,skintone_id = "" ,diet_type_id = "" ,drink_type_id = "" ,smoke_type_id = "" ,body_type_id = "";
  String mobile= "" ,alt_mobile = "" , email ="" ,alt_email = "", country = "" , perm_state = "" , perm_city = "" , work_state = "" ,work_city = "" , work_address = "" , perm_address = "" , contact_time = "" , lifestyles_id = "" , country_id = "" ,perm_state_id = "" , perm_city_id ="" , work_state_id = "" ,work_city_id = "";
  String education = "" , edu_details = "" , is_reputed = "" , institute_name = "" , is_administrative = "" , admin_position= "" ,education_id = "" ,highest_education_id = "" ,institute_name_id = "" ;
  String occuapation = "" , occupation_details = "" , annual_income = "" , employment_type = "" , office_address = ""  , occuapation_id = "" , occuapation_details_id = "";
  String rashi = "" , birth_star = "" , gotra = "" ,bdate = "" ,bcity ="" ,btime = "" , magalik = "" , belive_horoscope = "" , location_coords = "" , time_zone = "" , horoscope_id = "" , rashi_id = "" ,birthstar_id ="";
  String fml_value = "" , fml_status = "" , fml_type = "" , num_brother  ="" , num_sister = "" ,num_married_bro = "" ,num_married_sister = "" , father_name = "" , mother_name = "" , father_coccup = "" ,mother_occup = "" ,house_owned = "" ,house_type = "" , family_slogan = "" , parent_stay = "" , family_details = "" , family_id = "" , fml_status_id = "" , fml_type_id = "" ,fml_value_id ="" , house_type_id = "";
  String age_range = "" , height_range = "" , marital_prefs = "" , caste_prefs ="" , subcaste_prefs ="" , skintone_prefs = "" ,state_prefs = "" ,city_prefs = "" , edu_prefs = "" , ocupation_prefs = "" ,body_prefs = ""  , partner_prefs_id = "";
  String diet_prefs = "" ,drink_prefs= "" , smoke_prefs = "" ,   fml_value_prefs = "" , annual_income_prefs = "" , partner_details = "";
  String pic1= "" ,pic2= "" ,pic3= "",pic4= "",pic5= "",pic6= "",pic7= "",pic8= "",pic9= "",pic10= "" , pic_id = "";
  String verifypic1= "" ,verifypic2= "" ,verifypic3= "",verifypic4= "",verifypic5= "",verifypic6= "",verifypic7= "",verifypic8= "",verifypic9= "",verifypic10= "";
  String Idproof = "" ,eduproof = "" ,incomeproof = "" ;
  String user_verify = "" , email_verify = "" ,mobile_verify = "";
  String communityName = "" , hobbies = "";
  String communityId = "";
  bool isload =  false;

  late SharedPreferences prefs;

   initdata() async {

     EasyLoading.show(status: 'Please wait...');

    await Future.delayed(Duration(milliseconds: 250));

     prefs = await SharedPreferences.getInstance();



    print({
      "userId": widget.userId,
      "communityId": prefs.getString(SharedPrefs.communityId),
      "myuserId": widget.userId,
      "Id": widget.userId ,
      "original": "en",
      "translate": ["en"]
    });

       final _response = await Provider.of<ApiService>(context, listen: false)
           .postProfileDetailsFetchValuelabel(
           {
             "userId": widget.userId,
             "communityId": prefs.getString(SharedPrefs.communityId),
             "myuserId": widget.userId,
             "Id": widget.userId ,
             "original": "en",
             "translate": ["en"]
           }
       );

       setState(() {

       communityName = prefs.getString(SharedPrefs.communityName).toString();

       var userData = _response.body["data"][0][0]["0"];

        fullname =  userData["fullname"] ?? "";
        dob = userData["dob"] ?? "";
        createdby = userData["created_by"] != null ?  userData["created_by"].split(",")[0] : "";
        age =  utils().calculateAge(userData["dob"]).toString();
        marital = userData["marital_status"].split(",")[0];
        caste = userData["caste"] != null ? userData["caste"].split(",")[0] : "";
        subcaste = userData["subcaste"] != null ?  userData["subcaste"].split(",")[0] : "";
        lang_known   = userData["language_known"].split("*")[0];
        mother_tongue =  userData["mother_tongue"].split(",")[0];
        isnri = userData["isnri"] ?? "";
        nri_details = userData["nri_detail"] ?? "";
        profileId = userData["profileId"];
        basic_details_id = userData["Id"].toString();

        createdby_id = userData["created_by"] != null ?  userData["created_by"].split(",")[1] : "";
        marital_id = userData["marital_status"].split(",")[1];
        caste_id = userData["caste"] != null ? userData["caste"].split(",")[1] : "";
        subcaste_id  = userData["subcaste"] != null ?  userData["subcaste"].split(",")[1] : "";
        lang_known_id = userData["language_known"].split("*")[1];
        mother_tonuge_id = userData["mother_tongue"].split(",")[1];



       var contactInfo = _response.body["data"][1][0]["0"];

       // Setting values in shared preferences
       mobile = contactInfo["mobile_number"];
       perm_address  = contactInfo["permanent_adddress"];
       email = contactInfo["emailid"] ?? "";
       alt_mobile =  contactInfo["alternate_mobile"] ?? "";
       alt_email = contactInfo["alternate_email"] ?? "";
       work_address  =  contactInfo["working_address"] ?? "";
       contact_time = contactInfo["contact_time"] ?? "";
       country = contactInfo["perm_country"].split(",")[0];
       perm_state = contactInfo["perm_state"] != null ? contactInfo["perm_state"].split(",")[0] : "";
       perm_city =  contactInfo["perm_city"] != null ? contactInfo["perm_city"].split(",")[0] : "";
       work_state  = contactInfo["work_state"] != null ? contactInfo["work_state"].split(",")[0] : "";
       work_city=  contactInfo["work_city"] != null ? contactInfo["work_city"].split(",")[0] : "";

         country_id = contactInfo["perm_country"].split(",")[1];
         perm_state_id = contactInfo["perm_state"] != null ? contactInfo["perm_state"].split(",")[1] : "";
         perm_city_id =  contactInfo["perm_city"] != null ? contactInfo["perm_city"].split(",")[1] : "";
         work_state_id  = contactInfo["work_state"] != null ? contactInfo["work_state"].split(",")[1] : "";
         work_city_id =  contactInfo["work_city"] != null ? contactInfo["work_city"].split(",")[1] : "";
         contact_details_id = contactInfo["Id"].toString();

       var healthDetails = _response.body["data"][2][0]["0"];


       if(healthDetails != null) {

         wieght = healthDetails['weight'] ?? "";
         height = healthDetails['height'] ?? "";
         skintone =
         healthDetails['skintone'] != null ? healthDetails['skintone'].split(
             ",")[0] : "";
         bld_group = healthDetails['blood_group'] ?? "";
         fitness = healthDetails['fitness'] ?? "";
         body_type =
         healthDetails['body_type'] != null ? healthDetails['body_type'].split(
             ",")[0] : "";
         handicap = healthDetails['is_handicap'] ?? "";
         handicap_details = healthDetails['handicap_detail'] ?? "";
         diet_type =
         healthDetails['diet_type'] != null ? healthDetails['diet_type'].split(
             ",")[0] : "";
         drink_type =
         healthDetails['drink_type'] != null ? healthDetails['drink_type']
             .split(",")[0] : "";
         smoke_type =
         healthDetails['smoke_type'] != null ? healthDetails['smoke_type']
             .split(",")[0] : "";

         skintone_id =
         healthDetails['skintone'] != null ? healthDetails['skintone'].split(
             ",")[1] : "";
         body_type_id =
         healthDetails['body_type'] != null ? healthDetails['body_type'].split(
             ",")[1] : "";
         diet_type_id =
         healthDetails['diet_type'] != null ? healthDetails['diet_type'].split(
             ",")[1] : "";
         drink_type_id =
         healthDetails['drink_type'] != null ? healthDetails['drink_type']
             .split(",")[1] : "";
         smoke_type_id =
         healthDetails['smoke_type'] != null ? healthDetails['smoke_type']
             .split(",")[0] : "";

         lifestyles_id = healthDetails["Id"].toString();
       }



       var adminServiceDetails = _response.body["data"][3][0]["0"];


       if(adminServiceDetails != null) {
         is_administrative = adminServiceDetails['is_from_admin_service'] ?? "";
         admin_position = adminServiceDetails['admin_position_name'] ?? "";
         is_reputed = adminServiceDetails['is_from_iit_iim_nit'] ?? "";
         institute_name = adminServiceDetails['institute_name'] != null
             ? adminServiceDetails['institute_name'].split(",")[0] ?? ""
             : "";
         education = adminServiceDetails['education'] != null
             ? adminServiceDetails['education'].split(",")[0]
             : "";
         edu_details = adminServiceDetails['education_detail'] != null
             ? adminServiceDetails['education_detail']
             : "";

         institute_name_id = adminServiceDetails['institute_name'] != null
             ? adminServiceDetails['institute_name'].split(",")[1] ?? ""
             : "";
         highest_education_id = adminServiceDetails['education'] != null
             ? adminServiceDetails['education'].split(",")[1]
             : "";
         education_id = adminServiceDetails["Id"].toString();
       }


       var occupationDetails = _response.body["data"][4][0]["0"];

       if(occupationDetails != null) {
         occuapation = occupationDetails['occupation'] != null
             ? occupationDetails['occupation'].split(",")[0]
             : "";
         occupation_details = occupationDetails['occupation_detail'] ?? "";
         annual_income = occupationDetails['annual_income'] ?? "";
         employment_type = occupationDetails['employment_type'] ?? "";
         office_address = occupationDetails['office_address'] ?? "";
         occuapation_id = occupationDetails['occupation'] != null
             ? occupationDetails['occupation'].split(",")[1]
             : "";
         occuapation_details_id = occupationDetails['Id'].toString();
       }

       var familyDetails = _response.body["data"][5][0]["0"];

       if(familyDetails != null) {
         fml_status =
         familyDetails['family_status'] != null ? familyDetails['family_status']
             .split(",")[0] : "";
         fml_type =
         familyDetails['family_type'] != null ? familyDetails['family_type']
             .split(",")[0] : "";
         fml_value =
         familyDetails['family_value'] != null ? familyDetails['family_value']
             .split(",")[0] : "";
         num_brother = familyDetails['no_brother'];
         num_sister = familyDetails['no_sister'];
         num_married_bro = familyDetails['married_brother'];
         num_married_sister = familyDetails['married_sister'];
         father_name = familyDetails['father_name'] ?? "";
         mother_name = familyDetails['mother_name'] ?? "";
         father_coccup = familyDetails['father_occupation'] ?? "";
         mother_occup = familyDetails['mother_occupation'] ?? "";
         house_owned = familyDetails['house_owned'] ?? "";
         house_type =
         familyDetails['house_type'] != null ? familyDetails['house_type']
             .split(",")[0] : "";
         // parent_stay = familyDetails['parents_stay_options'];
         family_slogan = familyDetails['detail_family'] ?? "";

         fml_status_id =
         familyDetails['family_status'] != null ? familyDetails['family_status']
             .split(",")[1] : "";
         fml_type_id =
         familyDetails['family_type'] != null ? familyDetails['family_type']
             .split(",")[1] : "";
         fml_value_id =
         familyDetails['family_value'] != null ? familyDetails['family_value']
             .split(",")[0] : "";
         house_type_id =
         familyDetails['house_type'] != null ? familyDetails['house_type']
             .split(",")[0] : "";

         family_id = familyDetails["Id"].toString();
       }


       var astroDetails = _response.body["data"][6][0]["0"];

       print(astroDetails);

       if(astroDetails != null) {
         rashi =
         astroDetails['astro_rashi'] != null ? astroDetails['astro_rashi'].split(",")[0] : "";
         birth_star =
         astroDetails['birth_star'] != null ? astroDetails['birth_star'].split(",")[0] : "";
         gotra = astroDetails['gotra'] ?? "";
         belive_horoscope = astroDetails['believe_horoscope'] == "-1" ? "" :  astroDetails['believe_horoscope'] == "1" ? "Yes" : "No";
         bdate = astroDetails['birth_date'] ?? "";
         bcity = astroDetails['birth_place'] ?? "";
         btime = astroDetails['birth_time'] ?? "";
         time_zone = astroDetails['timezone'] ?? "";
         magalik = astroDetails['is_mangalik'] == "-1" ?  "" :  astroDetails['is_mangalik'] == "1" ? "Yes" : "No";

         rashi_id = astroDetails['astro_rashi'] != null ? astroDetails['astro_rashi'].split(",")[1] : "";
         birthstar_id = astroDetails['birth_star'] != null ? astroDetails['birth_star'].split(",")[1] : "";
         horoscope_id = astroDetails["Id"].toString();

       }

       var pictures = _response.body["data"][7][0]["0"];



       if(pictures != null) {

         pic1 = pictures['pic1'] ?? '';
         pic2 = pictures['pic2'] ?? '';
         pic3 = pictures['pic3'] ?? '';
         pic4 = pictures['pic4'] ?? '';
         pic5 = pictures['pic5'] ?? '';
         pic6 = pictures['pic6'] ?? '';
         pic7 = pictures['pic7'] ?? '';
         pic8 = pictures['pic8'] ?? '';
         pic9 = pictures['pic9'] ?? '';
         pic10 = pictures['pic10'] ?? '';

         print(pic1 + "-----++++=======" + pic2);

         verifypic1 = pictures['isverifypic1'] ?? '0';
         verifypic2 = pictures['isverifypic2'] ?? '0';
         verifypic3 = pictures['isverifypic3'] ?? '0';
         verifypic4 = pictures['isverifypic4'] ?? '0';
         verifypic5 = pictures['isverifypic5'] ?? '0';
         verifypic6 = pictures['isverifypic6'] ?? '0';
         verifypic7 = pictures['isverifypic7'] ?? '0';
         verifypic8 = pictures['isverifypic8'] ?? '0';
         verifypic9 = pictures['isverifypic9'] ?? '0';
         verifypic10 = pictures['isverifypic10'] ?? '0';

       }


       var userDetails = _response.body["data"][10][0]["0"];

       if(userDetails != null) {

         age_range = userDetails['age_range'] ?? '';
         height_range = userDetails['height_range'] ?? '';
         marital_prefs =
         userDetails['marital_status'] != null ? userDetails['marital_status']
             .split("*")[0] ?? '' : "";
         caste_prefs = userDetails['caste'] != null
             ? userDetails['caste'].split("*")[0] ?? ''
             : "";
         subcaste_prefs =
         userDetails['subcaste'] != null ? userDetails['subcaste'].split(
             "*")[0] ?? '' : "";
         state_prefs = userDetails['state'] != null
             ? userDetails['state'].split("*")[0] ?? ''
             : "";
         city_prefs = userDetails['city'] != null
             ? userDetails['city'].split("*")[0] ?? ''
             : "";
         skintone_prefs =
         userDetails['skintone'] != null ? userDetails['skintone'].split(
             "*")[0] ?? '' : "";
         edu_prefs =
         userDetails['education_list'] != null ? userDetails['education_list']
             .split("*")[0] ?? '' : "";
         ocupation_prefs =
         userDetails['occupation'] != null ? userDetails['occupation'].split(
             "*")[0] ?? '' : "";
         fml_value_prefs = userDetails['family_value'].toString().contains("*")
             ? userDetails['family_value'].split("*")[0] ?? ''
             : "";
         diet_prefs =
         userDetails['diet_type'] != null ? userDetails['diet_type'].split(
             "*")[0] ?? '' : "";
         body_prefs =
         userDetails['body_type'] != null ? userDetails['body_type'].split(
             "*")[0] ?? '' : "";
         drink_prefs =
         userDetails['drink_type'] != null ? userDetails['drink_type'].split(
             "*")[0] ?? '' : "";
         smoke_prefs =
         userDetails['smoke_type'] != null ? userDetails['smoke_type'].split(
             "*")[0] ?? '' : "";
         annual_income_prefs = userDetails['annual_income'] ?? '';
         partner_details = userDetails['partner_details'] ?? '';

       }

       isload = true;

       });


     var userproofs = _response.body["data"][9][0]["0"];

     if(_response.body["data"][9][0].toString() != "{}"){

       Idproof =  userproofs['id_proofs'].toString() ?? '';
       eduproof = userproofs['education_proof'].toString() ?? '';
       incomeproof = userproofs['income_proof'].toString() ?? '';

     }


     var userverify = _response.body["data"][15][0]["0"];

     print(userverify.toString());

     if(_response.body["data"][15][0].toString() != "{}"){

       user_verify =  userverify['user_verify'].toString() ?? '';
       email_verify = userverify['email_verify'].toString() ?? '';
       mobile_verify = userverify['mobile_verify'].toString() ?? '';

       print(user_verify+"========________++++++++"+email_verify);

     }



     var hobbyDetails = _response.body["data"][16][0]["0"];

     if(hobbyDetails != null) {
       hobbies = hobbyDetails['hobbies'];
     }


       EasyLoading.dismiss();

      // Navigator.of(context , rootNavigator: true).pop();

     }








  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKeyglobal,
      appBar: AppBar(
          title: Column(crossAxisAlignment: CrossAxisAlignment.start  ,children: [  Text('Profile of '+fullname , style: TextStyle(color: Colors.black87 , fontSize: 14),),   Text(communityName , style: TextStyle(color: Colors.black54 , fontSize: 14),)],),
          toolbarOpacity: 1,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Image.asset("assets/images/menu_img.png" , width: 50, height: 40,),
            onPressed: () {
              _scaffoldKeyglobal.currentState?.openDrawer();
            },
          )),
      drawer: StylishDrawer(),
      body: SafeArea(child: SingleChildScrollView(child:Container( margin: EdgeInsets.only(bottom: 20)  ,child:Column(children: [

        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150.0,
                height: 150.0,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+pic1,
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(child: Image.asset("assets/images/user_image.png"),);
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(child: Text(fullname , textAlign: TextAlign.center, style: TextStyle(fontSize: 18 ,color: ColorsPallete.blue_2 ,fontWeight: FontWeight.bold),),),
              SizedBox(height: 5),
              Container(child: Text("Profile ID : "+profileId , textAlign: TextAlign.center, style: TextStyle(fontSize: 16 ,color: ColorsPallete.purple ,fontWeight: FontWeight.bold),),),

              ElevatedButton(
                onPressed: () {

                  navService.pushNamed("/image_gallery_other_edit" , args: [pic1 ,pic2 ,pic3 ,pic4 ,pic5 ,pic6 ,pic7 ,pic8 ,profileId , widget.userId]);

                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Change Profile Picture',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(onPressed: () async {

                if(user_verify != "1"){

                final res = await DialogClass().showDialogBeforesubmit(context, "Verify User", "Have seen the user details watchfully if yes then verify this user", "Ok" , "1");

                if(res == "1"){

                  SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context, listen: false)
        .postUpdateVerifyUser(
        {
          "userId": widget.userId,
          "communityId": prefs.getString(SharedPrefs.communityId),
        });


                  if (_response.body["data"]["affectedRows"] == 1) {


                    setState(() {
                      user_verify = "1";
                    });


                  }


                }

                }else{


                }


              }, style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white54, // Set the background color to grey
                 foregroundColor: Colors.white, // Set the text color to white
              ),  child: Text(user_verify == "1" ? "User Is Verified" : "Verify User" , style: TextStyle(color:  user_verify == "1" ? Colors.green : Colors.red , ),))

            ],
          ),
        ),

       isload == true ? IgnorePointer(ignoring: false, child:Accordion(
            headerBorderColor: Colors.blueGrey,
            headerBorderColorOpened: Colors.transparent,
            headerBackgroundColorOpened: Colors.pink,
            headerBackgroundColor: ColorsPallete.blue_2,
            contentBackgroundColor: Colors.white,
            contentBorderColor: ColorsPallete.Pink,
            contentBorderWidth: 3,
            contentHorizontalPadding: 20,
            scaleWhenAnimating: true,
            openAndCloseAnimation: true,
            maxOpenSections: 8,
            disableScrolling: true,
            headerPadding:
            const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
            sectionClosingHapticFeedback: SectionHapticFeedback.light,
            children: [
              AccordionSection(
                isOpen: false,
                leftIcon:  GestureDetector(onTap: () async {

              final res =  await navService.pushNamed("/basic_details_edit" ,args:[fullname.split(" ")[0] ,
                fullname.split(" ")[1],
              dob,
              createdby ,
                  marital ,
                  caste ,
                  subcaste ,
                  lang_known  ,
                  mother_tongue ,
                createdby_id,
                marital_id ,caste_id ,subcaste_id , lang_known_id , mother_tonuge_id,
                basic_details_id ,isnri ,nri_details]);

              initdata();

                }  ,child:Icon(Icons.edit, color: Colors.white),),
                header:  Text( "Basic Details", style: headerStyle),
                contentHorizontalPadding: 10,
                contentVerticalPadding: 10,
                content: Container(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileDetailItem(label: TranslationService.translate("full_name_key"), value: fullname),
                      ProfileDetailItem(label: TranslationService.translate("dob_key"), value: dob),
                      ProfileDetailItem(label: TranslationService.translate("age_key"), value: age),
                      ProfileDetailItem(label: TranslationService.translate("created_by_key"), value: createdby),
                      ProfileDetailItem(label: TranslationService.translate("marital_status_key"), value: marital),
                      ProfileDetailItem(label: TranslationService.translate("caste_key"), value: caste),
                      ProfileDetailItem(label: TranslationService.translate("subcaste_key"), value: subcaste),
                      ProfileDetailItem(label:TranslationService.translate("language_known_key"), value: lang_known),
                      ProfileDetailItem(label: TranslationService.translate("mother_tongue_key"), value: mother_tongue),
                      ProfileDetailItem(label: TranslationService.translate("is_nri") , value: isnri == "1" ? "Yes"  : "No"),
                      isnri == "1" ? ProfileDetailItem(label: TranslationService.translate("nri_details"), value: nri_details) : Container(),
                    ],
                  ),
                ),),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector(onTap: () async {

                  final res =  await navService.pushNamed("/lifestyle_details_edit" , args:[height , wieght , skintone , bld_group , body_type , diet_type ,  handicap ,handicap_details , fitness ,drink_type ,smoke_type , overall_health_details , skintone_id ,body_type_id , diet_type_id ,drink_type_id ,smoke_type_id ,lifestyles_id]);
                  initdata();

                } , child: Icon(Icons.edit, color: Colors.white),),
                header:  Text(TranslationService.translate("physical_lifestyle_details_key"), style: headerStyle),
                contentHorizontalPadding: 10,
                contentVerticalPadding: 10,
                content: Container(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileDetailItem(label: TranslationService.translate("height_key"), value: height),
                      ProfileDetailItem(label: TranslationService.translate("weight_key"), value: wieght),
                      ProfileDetailItem(label: TranslationService.translate("skintone_key"), value: skintone),
                      ProfileDetailItem(label: TranslationService.translate("bld_group_key"), value: bld_group),
                      ProfileDetailItem(label: TranslationService.translate("body_type_key"), value: body_type),
                      ProfileDetailItem(label: TranslationService.translate("diet_type_key"), value: diet_type),
                      ProfileDetailItem(label: TranslationService.translate("fitness_key"), value: fitness),
                      ProfileDetailItem(label: TranslationService.translate("drink_type_key"), value: drink_type),
                      ProfileDetailItem(label: TranslationService.translate("smoke_type_key"), value: smoke_type),
                      ProfileDetailItem(label: TranslationService.translate("handicap_key"), value: handicap),
                      ProfileDetailItem(label: TranslationService.translate("handicap_details_key"), value: handicap_details),
                      ProfileDetailItem(label: TranslationService.translate("overall_health_details_key"), value: overall_health_details),
                    ],
                  ),
                ),),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector( onTap: () async {

                  final res =  await navService.pushNamed("/contact_details_edit" , args: [mobile , alt_mobile ,email ,alt_email ,country , perm_state ,perm_city , work_state ,work_city ,perm_address ,work_address ,contact_time , country_id ,perm_state_id ,perm_city_id ,work_state_id ,work_city_id ,contact_details_id]);
                  initdata();

                } ,child: Icon(Icons.edit, color: Colors.white),),
                header:  Text(TranslationService.translate("contact_details_key"), style: headerStyle),
                contentHorizontalPadding: 10,
                contentVerticalPadding: 10,
                content: Container(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileDetailItem(label: TranslationService.translate("mobile_key"), value: mobile),
                      ProfileDetailItem(label: TranslationService.translate("alt_mobile_key"), value: alt_mobile),
                      ProfileDetailItem(label: TranslationService.translate("email_key"), value: email ,verify_email:  email_verify),
                      ProfileDetailItem(label: TranslationService.translate("alt_email_key") , value: alt_email),
                      ProfileDetailItem(label: TranslationService.translate("country_key"), value: country),
                      ProfileDetailItem(label: TranslationService.translate("perm_state_key"), value: perm_state),
                      ProfileDetailItem(label: TranslationService.translate("perm_city_key"), value: perm_city),
                      ProfileDetailItem(label: TranslationService.translate("perm_address_key"), value: perm_address),
                      ProfileDetailItem(label: TranslationService.translate("work_state_key"), value: work_state),
                      ProfileDetailItem(label: TranslationService.translate("work_city_key"), value: work_city),
                      ProfileDetailItem(label: TranslationService.translate("work_address_key"), value: work_address),
                      ProfileDetailItem(label: TranslationService.translate("contact_time_key"), value: contact_time),
                    ],
                  ),
                ),),
              ),AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector(onTap: () async {

                  final res =  await navService.pushNamed("/education_details_edit" ,args:[is_administrative , admin_position , is_reputed , institute_name , education ,edu_details , institute_name_id , highest_education_id , education_id]);
                  initdata();


                }  ,child:Icon(Icons.edit, color: Colors.white),),
                header:  Text(TranslationService.translate("educational_details_key"), style: headerStyle),
                contentHorizontalPadding: 10,
                contentVerticalPadding: 10,
                content: Container(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileDetailItem(label: TranslationService.translate("education_key"), value: education),
                      ProfileDetailItem(label: TranslationService.translate("edu_details_key"), value: edu_details),
                      ProfileDetailItem(label: TranslationService.translate("is_reputed_key"), value: is_reputed == "0" ? "No" : "Yes"),
                      ProfileDetailItem(label: TranslationService.translate("institute_name_key"), value: institute_name),
                      ProfileDetailItem(label: TranslationService.translate("is_administrative_key") , value: is_administrative == "0" ? "No" : "Yes"),
                      ProfileDetailItem(label: TranslationService.translate("admin_position_key"), value: admin_position),
                    ],
                  ),
                ),),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector(onTap: () async {

                  final res =  await  navService.pushNamed("/occuaptional_details_edit" ,args:[occuapation , occupation_details , annual_income ,employment_type ,office_address ,occuapation_id ,occuapation_details_id ,widget.userId , profileId]);
                  initdata();

                }  ,child: Icon(Icons.edit, color: Colors.white),),
                header:  Text(TranslationService.translate("occuaptional_details_key"), style: headerStyle),
                contentHorizontalPadding: 10,
                contentVerticalPadding: 10,
                content: Container(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileDetailItem(label: TranslationService.translate("occupation_key"), value: occuapation),
                      ProfileDetailItem(label: TranslationService.translate("occupation_details_key"), value: occupation_details),
                      ProfileDetailItem(label: TranslationService.translate("annual_income_key"), value: annual_income),
                      ProfileDetailItem(label: TranslationService.translate("employment_type_key"), value: employment_type),
                      ProfileDetailItem(label: TranslationService.translate("office_address_key"), value: office_address),
                    ],
                  ),
                ),),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector( onTap: () async {

                  final res =  await navService.pushNamed("/horoscope_details_edit" ,args:[rashi ,birth_star ,gotra , bdate , bcity ,btime ,magalik , belive_horoscope , rashi_id ,birthstar_id , horoscope_id ,widget.userId , profileId]);
                  initdata();

                } ,child: Icon(Icons.edit, color: Colors.white),),
                header:  Text(TranslationService.translate("horoscope_details_key"), style: headerStyle),
                contentHorizontalPadding: 10,
                contentVerticalPadding: 10,
                content: Container(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileDetailItem(label: TranslationService.translate("rashi_key"), value: rashi),
                      ProfileDetailItem(label: TranslationService.translate("birth_star_key"), value: birth_star),
                      ProfileDetailItem(label: TranslationService.translate("gotra_key"), value: gotra),
                      ProfileDetailItem(label: TranslationService.translate("bdate_key"), value: bdate),
                      ProfileDetailItem(label: TranslationService.translate("bcity_key"), value: bcity),
                      ProfileDetailItem(label: TranslationService.translate("btime_key"), value: btime),
                      ProfileDetailItem(label: TranslationService.translate("mangalik_key"), value: magalik),
                      ProfileDetailItem(label: TranslationService.translate("believe_horoscope_key"), value: belive_horoscope),
                      ProfileDetailItem(label: TranslationService.translate("location_coords_key"), value: location_coords),
                      ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'View Your Birth Chart',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector( onTap: () async {

                  final res =  await navService.pushNamed("/fml_details_edit" ,args:[fml_value , fml_type ,num_brother ,num_sister, num_married_bro ,num_married_sister ,father_name ,mother_name ,father_coccup ,mother_occup , house_owned ,fml_status , house_type ,family_slogan , fml_value_id , fml_type_id , fml_status_id ,house_type_id , family_id ,widget.userId ,profileId]);
                  initdata();


                } ,child: Icon(Icons.edit, color: Colors.white),),
                header:  Text(TranslationService.translate("family_details_key"), style: headerStyle),
                contentHorizontalPadding: 10,
                contentVerticalPadding: 10,
                content: Container(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileDetailItem(label: TranslationService.translate("fml_value_key"), value: fml_value),
                      ProfileDetailItem(label: TranslationService.translate("fml_type_key"), value: fml_type),
                      ProfileDetailItem(label: TranslationService.translate("num_brother_key"), value: num_brother),
                      ProfileDetailItem(label: TranslationService.translate("num_sister_key"), value: num_sister),
                      ProfileDetailItem(label: TranslationService.translate("num_married_bro_key"), value: num_married_bro),
                      ProfileDetailItem(label: TranslationService.translate("num_married_sister_key"), value: num_married_sister),
                      ProfileDetailItem(label: TranslationService.translate("father_name_key"), value: father_name),
                      ProfileDetailItem(label: TranslationService.translate("mother_name_key"), value: mother_name),
                      ProfileDetailItem(label: TranslationService.translate("father_coccup_key"), value: father_coccup),
                      ProfileDetailItem(label: TranslationService.translate("mother_occup_key"), value: mother_occup),
                      ProfileDetailItem(label: TranslationService.translate("house_owned_key"), value: house_owned),
                      ProfileDetailItem(label: TranslationService.translate("fml_status_key"), value: fml_status),
                      ProfileDetailItem(label: TranslationService.translate("house_type_key"), value: house_type),
                      ProfileDetailItem(label: TranslationService.translate("family_slogan_key"), value: family_slogan),
                    ],
                  ),
                ),),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector(onTap: () async {

                 // final res =  await navService.pushNamed("/partner_details" ,args:"edit");
                 // initdata();


                }   ,child:Icon(Icons.edit, color: Colors.white),),
                header:  Text(TranslationService.translate("partner_prefs_key") , style: headerStyle),
                contentHorizontalPadding: 10,
                contentVerticalPadding: 10,
                content: Container(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileDetailItem(label: TranslationService.translate("age_range_key"), value: age_range),
                      ProfileDetailItem(label: TranslationService.translate("height_range_key"), value: height_range),
                      ProfileDetailItem(label: TranslationService.translate("marital_prefs_key"), value: marital_prefs),
                      ProfileDetailItem(label: TranslationService.translate("caste_prefs_key"), value: caste_prefs),
                      ProfileDetailItem(label: TranslationService.translate("subcaste_prefs_key"), value: subcaste_prefs),
                      ProfileDetailItem(label: TranslationService.translate("skintone_prefs_key"), value: skintone_prefs),
                      ProfileDetailItem(label: TranslationService.translate("state_prefs_key"), value: state_prefs),
                      ProfileDetailItem(label: TranslationService.translate("city_prefs_key"), value:  city_prefs),
                      ProfileDetailItem(label: TranslationService.translate("edu_prefs_key"), value: edu_prefs),
                      ProfileDetailItem(label: TranslationService.translate("ocupation_prefs_key"), value: ocupation_prefs),
                      ProfileDetailItem(label: TranslationService.translate("body_prefs_key"), value: body_prefs),
                      ProfileDetailItem(label: TranslationService.translate("diet_prefs_key"), value: diet_prefs),
                      ProfileDetailItem(label: TranslationService.translate("drink_prefs_key"), value: drink_prefs),
                      ProfileDetailItem(label: TranslationService.translate("smoke_prefs_key"), value: smoke_prefs),
                      ProfileDetailItem(label: TranslationService.translate("fml_value_key"), value: fml_value),
                      ProfileDetailItem(label: TranslationService.translate("annual_income_prefs_key"), value: annual_income_prefs),
                    ],
                  ),
                ),),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector(onTap: () async {

                //  final res =  await  navService.pushNamed("/preference_filter" ,args:"edit");
                //  initdata();

                } ,child:Icon(Icons.edit, color: Colors.white),),
                header:  Text(TranslationService.translate("partner_prefs_filter_key") , style: headerStyle),
                contentHorizontalPadding: 10,
                contentVerticalPadding: 10,
                content: Container(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child:Text(
                        TranslationService.translate("partner_prefs_details"),
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: ColorsPallete.blue_2,
                        ),
                      ),)
                    ],
                  ),
                ),),
              ),

              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector(onTap: () async {

                  final res =  await  navService.pushNamed("/hobbies_edit" ,args: [hobbies , widget.userId , profileId]);
                  initdata();

                } ,child:Icon(Icons.edit, color: Colors.white),),
                header:  Text(TranslationService.translate("select_hobby"), style: headerStyle),
                contentHorizontalPadding: 10,
                contentVerticalPadding: 10,
                content: Container(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child:Text(
                        hobbies,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: ColorsPallete.blue_2,
                        ),
                      ),)
                    ],
                  ),
                ),),
              ),


              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector(onTap: () async {

                  final res =  await  navService.pushNamed("/documents_edit" ,args: [ Idproof ,eduproof ,incomeproof ,  widget.userId ,profileId]);
                  initdata();

                } ,child:Icon(Icons.edit, color: Colors.white),),
                header:  Text(TranslationService.translate("upload_documents"), style: headerStyle),
                contentHorizontalPadding: 10,
                contentVerticalPadding: 10,
                content: Container(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Container(child:Text(
                         TranslationService.translate("3_documents"),
                         style: TextStyle(
                           fontSize: 16.0,
                           fontWeight: FontWeight.bold,
                           color: ColorsPallete.blue_2,
                         ),
                       ),)
                    ],
                  ),
                ),),
              ),

            ]) ,



        ): Container()
      ],)



    ))));


  }



}