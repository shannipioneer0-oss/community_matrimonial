
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


class UserDetail extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: UserDetailStateful(),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: null,              // Ensure system default is used
      ),
      builder: (context, child) {
        // MediaQuery + RepaintBoundary + Directionality
        final mq = MediaQuery.of(context);

        Widget appContent = MediaQuery(
          data: mq.copyWith(
            textScaleFactor: 1.0, // Stops distorted text
            boldText: false,      // Avoid OEM forcing bold fonts
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: RepaintBoundary( // Added RepaintBoundary globally
              child: child!,
            ),
          ),
        );

        // Initialize EasyLoading on top
        return EasyLoading.init()(context, appContent);
      },
    );

  }


}


class UserDetailStateful extends StatefulWidget {

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



  String fullname = "" , fullnameabove = "" , dob = ""  , age = "" , createdby = "" , marital = "" , caste = "" , subcaste = "" , lang_known = "", mother_tongue = "" ,isnri = "" , nri_details = "" , profileId = "";
  String height = "" , wieght = "" , skintone = "" ,bld_group = "" , body_type ="" ,diet_type = "" ,drink_type = "" ,smoke_type = "" ,fitness ="", handicap = "" ,handicap_details ="" , overall_health_details= "" ;
  String mobile= "" ,alt_mobile = "" , email ="" ,alt_email = "", country = "" , perm_state = "" , perm_city = "" , work_state = "" ,work_city = "" , work_address = "" , perm_address = "" , contact_time = "" ;
  String education = "" , edu_details = "" , is_reputed = "" , institute_name = "" , is_administrative = "" , admin_position= "" ;
  String occuapation = "" , occupation_details = "" , annual_income = "" , employment_type = "" , office_address = "";
  String rashi = "" , birth_star = "" , gotra = "" ,bdate = "" ,bcity ="" ,btime = "" , magalik = "" , belive_horoscope = "" , location_coords = "" , time_zone = "";
  String fml_value = "" , fml_status = "" , fml_type = "" , num_brother  ="" , num_sister = "" ,num_married_bro = "" ,num_married_sister = "" , father_name = "" , mother_name = "" , father_coccup = "" ,mother_occup = "" ,house_owned = "" ,house_type = "" , family_slogan = "" , parent_stay = "" , family_details = "";
  String shakh = "" , native = "" , native_address = "" , moshal_sakh = "" , moshal_native = "";
  String age_range = "" , height_range = "" , marital_prefs = "" , caste_prefs ="" , subcaste_prefs ="" , skintone_prefs = "" ,state_prefs = "" ,city_prefs = "" , edu_prefs = "" , ocupation_prefs = "" ,body_prefs = "" ;
  String diet_prefs = "" ,drink_prefs= "" , smoke_prefs = "" ,   fml_value_prefs = "" , annual_income_prefs = "" , partner_details = "";
  String pic1= "" ,pic2= "" ,pic3= "",pic4= "",pic5= "",pic6= "",pic7= "",pic8= "",pic9= "",pic10= "";
  String verifypic1= "" ,verifypic2= "" ,verifypic3= "",verifypic4= "",verifypic5= "",verifypic6= "",verifypic7= "",verifypic8= "",verifypic9= "",verifypic10= "";
  String communityName = "";
  String hobbies = "";
  bool isload =  false , initialload = false;

  String membername1 = "";
  String relation1 = "";
  String marital1 = "";
  String age1 = "";
  String education1 = "";
  String occupation_income1 = "";

  String membername2 = "";
  String relation2 = "";
  String marital2 = "";
  String age2 = "";
  String education2 = "";
  String occupation_income2 = "";

  String membername3 = "";
  String relation3 = "";
  String marital3 = "";
  String age3 = "";
  String education3 = "";
  String occupation_income3 = "";

  String membername4 = "";
  String relation4 = "";
  String marital4 = "";
  String age4 = "";
  String education4 = "";
  String occupation_income4 = "";

  String membername5 = "";
  String relation5 = "";
  String marital5 = "";
  String age5 = "";
  String education5 = "";
  String occupation_income5 = "";

  String membername6 = "";
  String relation6 = "";
  String marital6 = "";
  String age6 = "";
  String education6 = "";
  String occupation_income6 = "";

  String refmembername1 = "";
  String refmemberadd1 = "";
  String refmembermobile1 = "";

  String refmembername2 = "";
  String refmemberadd2 = "";
  String refmembermobile2 = "";


  late SharedPreferences prefs;
   initdata() async {

     EasyLoading.show(status: 'Please wait...');

    await Future.delayed(Duration(milliseconds: 250));

    prefs = await SharedPreferences.getInstance();

     initialload = true;

    print(prefs.getString(SharedPrefs.userId));

     if(prefs.getString(SharedPrefs.translate) != "en") {

       final _response = await Provider.of<ApiService>(context, listen: false)
           .postProfileDetailsFetchValuelabel(
           {
             "userId": prefs.getString(SharedPrefs.userId),
             "communityId": prefs.getString(SharedPrefs.communityId),
             "myuserId": prefs.getString(SharedPrefs.userId),
             "Id": prefs.getString(SharedPrefs.userId),
             "original": "en",
             "translate": [prefs.getString(SharedPrefs.translate)]
           }
       );

       setState(() {

         communityName = prefs.getString(SharedPrefs.communityName).toString();
         fullnameabove = prefs.getString(SharedPrefs.firstName).toString()+" "+prefs.getString(SharedPrefs.lastname).toString();

        var userData = _response.body["data"][0][0]["0"];

        if(userData != null) {
          fullname = userData["fullname"] ??
              prefs.getString(SharedPrefs.firstName).toString() + " " +
                  prefs.getString(SharedPrefs.lastname).toString();
          dob = utils().formatGivenDate(userData["dob"]) ?? "";
          createdby = userData["created_by"] != null
              ? userData["created_by"].split(",")[0]
              : "";
          age = utils().calculateAge(userData["dob"]).toString() ?? "";
          marital = userData["marital_status"].split(",")[0] ?? "";
          caste = userData["caste"].split(",")[0] ?? "";
          subcaste = userData["subcaste"] != null
              ? userData["subcaste"].split(",")[0]
              : "";
          lang_known = userData["language_known"].split("*")[0] ?? "";
          mother_tongue = userData["mother_tongue"].split(",")[0] ?? "";
          isnri = userData["isnri"] ?? "";
          nri_details = userData["nri_detail"] ?? "";
          profileId = prefs.getString(SharedPrefs.profileid).toString() ?? "";
        }

       var contactInfo = _response.body["data"][1][0]["0"];

       // Setting values in shared preferences
         if(contactInfo != null) {
           mobile = contactInfo["mobile_number"] ?? "";
           perm_address = contactInfo["permanent_adddress"] ?? "";
           email = contactInfo["emailid"] ?? "";
           alt_mobile = contactInfo["alternate_mobile"] ?? "";
           alt_email = contactInfo["alternate_email"] ?? "";
           work_address = contactInfo["working_address"] ?? "";
           contact_time = contactInfo["contact_time"] ?? "";
           country = contactInfo["perm_country"].split(",")[0] ?? "";
           perm_state =
           contactInfo["perm_state"] != null ? contactInfo["perm_state"].split(
               ",")[0] : "";
           perm_city =
           contactInfo["perm_city"] != null ? contactInfo["perm_city"].split(
               ",")[0] : "";
           work_state =
           contactInfo["work_state"] != null ? contactInfo["work_state"].split(
               ",")[0] : "";
           work_city =
           contactInfo["work_city"] != null ? contactInfo["work_city"].split(
               ",")[0] : "";
         }


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
           healthDetails['body_type'] != null ? healthDetails['body_type']
               .split(",")[0] : "";
           handicap = healthDetails['is_handicap'] == "No"
               ? "Normal"
               : healthDetails['is_handicap'] == "Yes" ?  "Physically Disabled" : "" ;
           handicap_details = healthDetails['handicap_detail'] ?? "";
           diet_type =
           healthDetails['diet_type'] != null ? healthDetails['diet_type']
               .split(",")[0] : "";
           drink_type =
           healthDetails['drink_type'] != null ? healthDetails['drink_type']
               .split(",")[0] : "";
           smoke_type =
           healthDetails['smoke_type'] != null ? healthDetails['smoke_type']
               .split(",")[0] : "";
         }

       var adminServiceDetails = _response.body["data"][3][0]["0"];


         if(adminServiceDetails != null) {
           is_administrative =
               adminServiceDetails['is_from_admin_service'] ?? "";
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
         }

       var familyDetails = _response.body["data"][5][0]["0"];

         print(familyDetails);

         if(familyDetails != null) {

           fml_status = familyDetails['family_status'] != null
               ? familyDetails['family_status'].split(",")[0]
               : "";
           fml_type =
           familyDetails['family_type'] != null ? familyDetails['family_type']
               .split(",")[0] : "";
           fml_value =
           familyDetails['family_value'] != null ? familyDetails['family_value']
               .split(",")[0] : "";
           num_brother = familyDetails['no_brother'] ?? "";
           num_sister = familyDetails['no_sister'] ?? "";
           num_married_bro = familyDetails['married_brother'] ?? "";
           num_married_sister = familyDetails['married_sister'] ?? "";
           father_name = familyDetails['father_name'] ?? "";
           mother_name = familyDetails['mother_name'] ?? "";
           father_coccup = familyDetails['father_occupation'] ?? "";
           mother_occup = familyDetails['mother_occupation'] ?? "";
           house_owned = familyDetails['house_owned'] ?? "";
           house_type = familyDetails['house_type'] != null ? familyDetails['house_type'].split(",")[0] : "";
           // parent_stay = familyDetails['parents_stay_options'];
           family_slogan = familyDetails['detail_family'] ?? "";
           shakh =  familyDetails["shakh"] ?? "";
           native =  familyDetails["native"] ?? "";
           native_address =  familyDetails["native_address"] ?? "";
           moshal_sakh = familyDetails["moshal_sakh"] ?? "";
           moshal_native = familyDetails["moshal_native"] ?? "";

         }


       var astroDetails = _response.body["data"][6][0]["0"];

       print(astroDetails);

       if(astroDetails != null) {
         rashi =
         astroDetails['astro_rashi'] != null ? astroDetails['astro_rashi'].split(",")[0] : "";
         birth_star =
         astroDetails['birth_star'] != null ? astroDetails['birth_star'].split(",")[0] : "";
         gotra = astroDetails['gotra'] ?? "";
         belive_horoscope = astroDetails['believe_horoscope'] ?? "";
         bdate = astroDetails['birth_date'] ?? "";
         bcity = astroDetails['birth_place'] ?? "";
         btime = astroDetails['birth_time'] ?? "";
         time_zone = astroDetails['timezone'] ?? "";
         magalik = astroDetails['is_mangalik'] ?? "";
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

         print(pic1 + "-----++++=======");

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


         var hobbyDetails = _response.body["data"][16][0]["0"];

         if(hobbyDetails != null) {
           hobbies = hobbyDetails['hobbies'];
         }

         var family_mmeber_details = _response.body["data"][17][0]["0"];

         print(family_mmeber_details);

         if(family_mmeber_details != null) {

           membername1 = family_mmeber_details['member_details1'].toString().split(",")[0];
           relation1 = family_mmeber_details['member_details1'].toString().split(",")[1];
           marital1 = family_mmeber_details['member_details1'].toString().split(",")[2];
           age1 = family_mmeber_details['member_details1'].toString().split(",")[3];
           education1 = family_mmeber_details['member_details1'].toString().split(",")[4];
           occupation_income1 = family_mmeber_details['member_details1'].toString().split(",")[5];

           membername2 = family_mmeber_details['member_details2'].toString().split(",")[0];
           relation2 = family_mmeber_details['member_details2'].toString().split(",")[1];
           marital2 = family_mmeber_details['member_details2'].toString().split(",")[2];
           age2 = family_mmeber_details['member_details2'].toString().split(",")[3];
           education2 = family_mmeber_details['member_details2'].toString().split(",")[4];
           occupation_income2 = family_mmeber_details['member_details2'].toString().split(",")[5];

           membername3 = family_mmeber_details['member_details3'].toString().split(",")[0];
           relation3 = family_mmeber_details['member_details3'].toString().split(",")[1];
           marital3 = family_mmeber_details['member_details3'].toString().split(",")[2];
           age3 = family_mmeber_details['member_details3'].toString().split(",")[3];
           education3 = family_mmeber_details['member_details3'].toString().split(",")[4];
           occupation_income3 = family_mmeber_details['member_details3'].toString().split(",")[5];

           membername4 = family_mmeber_details['member_details4'].toString().split(",")[0];
           relation4 = family_mmeber_details['member_details4'].toString().split(",")[1];
           marital4 = family_mmeber_details['member_details4'].toString().split(",")[2];
           age4 = family_mmeber_details['member_details4'].toString().split(",")[3];
           education4 = family_mmeber_details['member_details4'].toString().split(",")[4];
           occupation_income4 = family_mmeber_details['member_details4'].toString().split(",")[5];

           membername5 = family_mmeber_details['member_details5'].toString().split(",")[0];
           relation5 = family_mmeber_details['member_details5'].toString().split(",")[1];
           marital5 = family_mmeber_details['member_details5'].toString().split(",")[2];
           age5 = family_mmeber_details['member_details5'].toString().split(",")[3];
           education5 = family_mmeber_details['member_details5'].toString().split(",")[4];
           occupation_income5 = family_mmeber_details['member_details5'].toString().split(",")[5];

           membername6 = family_mmeber_details['member_details6'].toString().split(",")[0];
           relation6 = family_mmeber_details['member_details6'].toString().split(",")[1];
           marital6 = family_mmeber_details['member_details6'].toString().split(",")[2];
           age6 = family_mmeber_details['member_details6'].toString().split(",")[3];
           education6 = family_mmeber_details['member_details6'].toString().split(",")[4];
           occupation_income6 = family_mmeber_details['member_details6'].toString().split(",")[5];

           refmembername1 = family_mmeber_details['ref_member_name1'] ?? "";
           refmemberadd1 = family_mmeber_details['ref_member_add1'] ?? "";
           refmembermobile1 = family_mmeber_details['ref_member_mobile1'] ?? "";

           refmembername2 = family_mmeber_details['ref_mmeber_name2'] ?? "";
           refmemberadd2 = family_mmeber_details['ref_member_add2'] ?? "";
           refmembermobile2 = family_mmeber_details['ref_member_mobile2'] ?? "";

         }


       isload = true;

       });

       EasyLoading.dismiss();

      // Navigator.of(context , rootNavigator: true).pop();

     }else {

       setState(() {

         communityName = prefs.getString(SharedPrefs.communityName).toString();
         fullnameabove = prefs.getString(SharedPrefs.firstName).toString()+" "+prefs.getString(SharedPrefs.lastname).toString();

         fullname = prefs.getString(SharedPrefs.fullname).toString();

         print(prefs.getString(SharedPrefs.dob).toString()+"()()");

         if(prefs.getString(SharedPrefs.dob).toString().isNotEmpty && prefs.getString(SharedPrefs.dob).toString() != null && prefs.getString(SharedPrefs.dob).toString() != "null") {

           if(utils().isValidDateDDMMYYYY(prefs.getString(SharedPrefs.dob).toString())){

             dob = prefs.getString(SharedPrefs.dob).toString();

           }else {
             dob = utils().formatGivenDate(
                 prefs.getString(SharedPrefs.dob).toString());
           }

         }

           if(dob.isNotEmpty && dob != null) {

             if(utils().isValidDateDDMMYYYY(prefs.getString(SharedPrefs.dob).toString())){

               age = utils().calculateAge(utils().convertDateYYYYMMDD(
                   prefs.getString(SharedPrefs.dob).toString())).toString();


             }else{


               age = utils().calculateAge(prefs.getString(SharedPrefs.dob).toString()).toString();
             }

           }

         print(age+"======"+prefs.getString(SharedPrefs.dob).toString());

         createdby = prefs.getString(SharedPrefs.createdBy).toString().split(",")[0];
         marital = prefs.getString(SharedPrefs.maritalStatus).toString().split(",")[0];
         caste = prefs.getString(SharedPrefs.caste).toString().split(",")[0];
         subcaste = prefs.getString(SharedPrefs.subcaste).toString().split(",")[0];
         lang_known = prefs.getString(SharedPrefs.languageKnown).toString().split("*")[0];
         mother_tongue = prefs.getString(SharedPrefs.motherTongue).toString().split(",")[0];
         profileId = prefs.getString(SharedPrefs.profileid).toString();
         isnri  = prefs.getString(SharedPrefs.isnri).toString();
         nri_details = prefs.getString(SharedPrefs.nri_details).toString();


         height = prefs.getString(SharedPrefs.height).toString();
         wieght = prefs.getString(SharedPrefs.weight).toString();
         skintone =
         prefs.getString(SharedPrefs.skinTone).toString().split(",")[0];
         bld_group = prefs.getString(SharedPrefs.bloodGroup).toString();
         body_type =
         prefs.getString(SharedPrefs.bodyType).toString().split(",")[0];
         diet_type =
         prefs.getString(SharedPrefs.dietType).toString().split(",")[0];
         fitness = prefs.getString(SharedPrefs.fitness).toString();
         drink_type =
         prefs.getString(SharedPrefs.drinkType).toString().split(",")[0];
         smoke_type =
         prefs.getString(SharedPrefs.smokeType).toString().split(",")[0];
         handicap = prefs.getString(SharedPrefs.isHandicap).toString() == "No" ? "Normal" : "Physically Disabled";
         handicap_details = prefs.getString(SharedPrefs.handicapDetail).toString();
         overall_health_details = prefs.getString(SharedPrefs.extra_details_physique).toString();


         mobile = prefs.getString(SharedPrefs.mobileNumber).toString();
         alt_mobile = prefs.getString(SharedPrefs.alternateMobile).toString();
         email = prefs.getString(SharedPrefs.emailId).toString();
         alt_email = prefs.getString(SharedPrefs.alternateEmail).toString();
         country =
         prefs.getString(SharedPrefs.permCountry).toString().split(",")[0];
         perm_state =
         prefs.getString(SharedPrefs.permState).toString().split(",")[0];
         perm_city =
         prefs.getString(SharedPrefs.permCity).toString().split(",")[0];
         work_state =
         prefs.getString(SharedPrefs.workState).toString().split(",")[0];
         work_city =
         prefs.getString(SharedPrefs.workCity).toString().split(",")[0];
         work_address = prefs.getString(SharedPrefs.workingAddress).toString();
         perm_address =
             prefs.getString(SharedPrefs.permanentAddress).toString();
         contact_time = prefs.getString(SharedPrefs.contactTime).toString();


         education = prefs.getString(SharedPrefs.education).toString().split(",")[0];
         edu_details = prefs.getString(SharedPrefs.educationDetail).toString();
         is_reputed = prefs.getString(SharedPrefs.isFromIITIIMNIT).toString();
         institute_name = prefs.getString(SharedPrefs.instituteName).toString().split(",")[0];
         is_administrative = prefs.getString(SharedPrefs.isFromAdminService).toString();
         admin_position = prefs.getString(SharedPrefs.adminPositionName).toString();
         occuapation = prefs.getString(SharedPrefs.occupation).toString().split(",")[0];
         occupation_details = prefs.getString(SharedPrefs.occupationDetail).toString();
         annual_income = prefs.getString(SharedPrefs.annualIncome).toString();
         employment_type = prefs.getString(SharedPrefs.employmentType).toString();
         office_address = prefs.getString(SharedPrefs.officeAddress).toString();


         rashi =
         prefs.getString(SharedPrefs.astroRashi).toString().split(",")[0];
         birth_star =
         prefs.getString(SharedPrefs.birthStar).toString().split(",")[0];
         gotra = prefs.getString(SharedPrefs.gotra).toString();
         bdate = prefs.getString(SharedPrefs.birthDate).toString();
         bcity = prefs.getString(SharedPrefs.birthPlace).toString();
         btime = prefs.getString(SharedPrefs.birthTime).toString();
         magalik = prefs.getString(SharedPrefs.isMangalik).toString() == "1"
             ? "Yes"  : prefs.getString(SharedPrefs.isMangalik).toString() == "-1" ? ""
             : "No";
         belive_horoscope =
             prefs.getString(SharedPrefs.believeHoroscope).toString() == "1" ? "Yes" :
             prefs.getString(SharedPrefs.isMangalik).toString() == "-1" ? ""
                 : "No";
         location_coords =
             prefs.getString(SharedPrefs.locationCoordinates).toString();


         fml_value =
         prefs.getString(SharedPrefs.familyValue).toString().split(",")[0];
         fml_type =
         prefs.getString(SharedPrefs.familyType).toString().split(",")[0];
         fml_status =
         prefs.getString(SharedPrefs.familyStatus).toString().split(",")[0];
         num_brother = prefs.getString(SharedPrefs.noBrother).toString();
         num_sister = prefs.getString(SharedPrefs.noSister).toString();
         num_married_bro =
             prefs.getString(SharedPrefs.marriedBrother).toString();
         num_married_sister =
             prefs.getString(SharedPrefs.marriedSister).toString();
         father_name = prefs.getString(SharedPrefs.fatherName).toString();
         mother_name = prefs.getString(SharedPrefs.motherName).toString();
         father_coccup =
             prefs.getString(SharedPrefs.fatherOccupation).toString();
         mother_occup =
             prefs.getString(SharedPrefs.motherOccupation).toString();
         house_owned = prefs.getString(SharedPrefs.houseOwned).toString().split(",")[0];
         house_type =
         prefs.getString(SharedPrefs.houseType).toString().split(",")[0];
         family_slogan = prefs.getString(SharedPrefs.detailFamily).toString();
         shakh =  prefs.getString(SharedPrefs.sakh).toString();
         native =  prefs.getString(SharedPrefs.native).toString();
         native_address =  prefs.getString(SharedPrefs.native_address).toString();
         moshal_sakh = prefs.getString(SharedPrefs.moshal_sakh).toString();
         moshal_native = prefs.getString(SharedPrefs.moshal_native).toString();


         pic1 = prefs.getString(SharedPrefs.pic1).toString();

         age_range = prefs.getString(SharedPrefs.ageRange).toString();
         height_range = prefs.getString(SharedPrefs.heightRange).toString();
         marital_prefs =
         prefs.getString(SharedPrefs.maritalStatus_prefs).toString().split(
             "*")[0];
         caste_prefs =
         prefs.getString(SharedPrefs.caste_prefs).toString().split("*")[0];
         subcaste_prefs =
         prefs.getString(SharedPrefs.subcaste_prefs).toString().split("*")[0];
         skintone_prefs =
         prefs.getString(SharedPrefs.skintoneprefs).toString().split("*")[0];
         state_prefs =
         prefs.getString(SharedPrefs.state_prefs).toString().split("*")[0];
         city_prefs =
         prefs.getString(SharedPrefs.city_prefs).toString().split("*")[0];
         edu_prefs =
         prefs.getString(SharedPrefs.education_prefs).toString().split("*")[0];
         ocupation_prefs =
         prefs.getString(SharedPrefs.occupation_prefs).toString().split("*")[0];
         body_prefs =
         prefs.getString(SharedPrefs.bodyType_prefs).toString().split("*")[0];
         diet_prefs =
         prefs.getString(SharedPrefs.dietType_prefs).toString().split("*")[0];
         smoke_prefs =
         prefs.getString(SharedPrefs.smokeType_prefs).toString().split("*")[0];
         drink_prefs =
         prefs.getString(SharedPrefs.drinkType_prefs).toString().split("*")[0];
         fml_value_prefs =
         prefs.getString(SharedPrefs.familyValue_prefs).toString().split(
             "*")[0];
         annual_income_prefs =
             prefs.getString(SharedPrefs.annualIncome_prefs).toString();

         hobbies = prefs.getString(SharedPrefs.hobbies).toString() ?? "";




         membername1 = prefs.getString(SharedPrefs.membername1).toString();
         relation1 = prefs.getString(SharedPrefs.relation1).toString();
         marital1 = prefs.getString(SharedPrefs.marital1).toString();
         age1 = prefs.getString(SharedPrefs.age1).toString();
         education1 = prefs.getString(SharedPrefs.education1).toString();
         occupation_income1 = prefs.getString(SharedPrefs.occupation_income1).toString();

         membername2 = prefs.getString(SharedPrefs.membername2).toString();
         relation2 = prefs.getString(SharedPrefs.relation2).toString();
         marital2 = prefs.getString(SharedPrefs.marital2).toString();
         age2 = prefs.getString(SharedPrefs.age2).toString();
         education2 = prefs.getString(SharedPrefs.education2).toString();
         occupation_income2 = prefs.getString(SharedPrefs.occupation_income2).toString();

         membername3 = prefs.getString(SharedPrefs.membername3).toString();
         relation3 = prefs.getString(SharedPrefs.relation3).toString();
         marital3 = prefs.getString(SharedPrefs.marital3).toString();
         age3 = prefs.getString(SharedPrefs.age3).toString();
         education3 = prefs.getString(SharedPrefs.education3).toString();
         occupation_income3 = prefs.getString(SharedPrefs.occupation_income3).toString();

         membername4 = prefs.getString(SharedPrefs.membername4).toString();
         relation4 = prefs.getString(SharedPrefs.relation4).toString();
         marital4 = prefs.getString(SharedPrefs.marital4).toString();
         age4 = prefs.getString(SharedPrefs.age4).toString();
         education4 = prefs.getString(SharedPrefs.education4).toString();
         occupation_income4 = prefs.getString(SharedPrefs.occupation_income4).toString();

         membername5 = prefs.getString(SharedPrefs.membername5).toString();
         relation5 = prefs.getString(SharedPrefs.relation5).toString();
         marital5 = prefs.getString(SharedPrefs.marital5).toString();
         age5 = prefs.getString(SharedPrefs.age5).toString();
         education5 = prefs.getString(SharedPrefs.education5).toString();
         occupation_income5 = prefs.getString(SharedPrefs.occupation_income5).toString();

         membername6 = prefs.getString(SharedPrefs.membername6).toString();
         relation6 = prefs.getString(SharedPrefs.relation6).toString();
         marital6 = prefs.getString(SharedPrefs.marital6).toString();
         age6 = prefs.getString(SharedPrefs.age6).toString();
         education6 = prefs.getString(SharedPrefs.education6).toString();
         occupation_income6 = prefs.getString(SharedPrefs.occupation_income6).toString();

         refmembername1 = prefs.getString(SharedPrefs.refmembername1).toString();
         refmemberadd1 = prefs.getString(SharedPrefs.refmemberadd1).toString();
         refmembermobile1 = prefs.getString(SharedPrefs.refmembermobile1).toString();

         refmembername2 = prefs.getString(SharedPrefs.refmembername2).toString();
         refmemberadd2 = prefs.getString(SharedPrefs.refmemberadd2).toString();
         refmembermobile2 = prefs.getString(SharedPrefs.refmembermobile2).toString();



         isload = true;
       });


       EasyLoading.dismiss();

     }





  }

  bool _navigating = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKeyglobal,
      appBar: AppBar(
          title: Column(crossAxisAlignment: CrossAxisAlignment.start  ,children: [  Text('Your Profile' , style: TextStyle(color: Colors.black87 , fontSize: 18),),   Text(communityName , style: TextStyle(color: Colors.black54 , fontSize: 16),)],),
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
      body: initialload == false  ? Container()  : SingleChildScrollView(child:Container( margin: EdgeInsets.only(bottom: 20)  ,child:Column(children: [

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
                    prefs == null ? "" : Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+pic1,
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
              Container(child: Text(fullnameabove , textAlign: TextAlign.center, style: TextStyle(fontSize: 18 ,color: ColorsPallete.blue_2 ,fontWeight: FontWeight.bold),),),
              SizedBox(height: 5),
              Container(child: Text("Profile ID : "+profileId , textAlign: TextAlign.center, style: TextStyle(fontSize: 16 ,color: ColorsPallete.purple ,fontWeight: FontWeight.bold),),),

              ElevatedButton(
                onPressed: () {

                  navService.pushNamed("/img_gallery");

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



      final res = await navService.pushNamed("/basic_details", args: "edit");
      initdata();



                }  ,child:Icon(Icons.edit, color: Colors.white),),
                header:  Text( TranslationService.translate("your_basic_details_key"), style: headerStyle),
                contentHorizontalPadding: 10,
                contentVerticalPadding: 10,
                content: Container(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileDetailItem(label: TranslationService.translate("full_name_key"), value: fullname),
                      ProfileDetailItem(label: TranslationService.translate("dob_key"), value: dob),
                      ProfileDetailItem(
                            label: TranslationService.translate("age_key"),
                            value: dob.toString() != "null" ? age : ""),

                      ProfileDetailItem(label: TranslationService.translate("created_by_key"), value: createdby),
                      ProfileDetailItem(label: TranslationService.translate("marital_status_key"), value: marital),
                      ProfileDetailItem(label: TranslationService.translate("caste_key"), value: caste),
                      ProfileDetailItem(label: TranslationService.translate("shakh"), value: subcaste),
                      /*ProfileDetailItem(label:TranslationService.translate("language_known_key"), value: lang_known),
                      ProfileDetailItem(label: TranslationService.translate("mother_tongue_key"), value: mother_tongue),
                      ProfileDetailItem(label: TranslationService.translate("is_nri") , value: isnri == "1" ? "Yes"  : "No"),
                      isnri == "1" ? ProfileDetailItem(label: TranslationService.translate("nri_details") , value: nri_details) : Container(),
               */     ],
                  ),
                ),),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector(onTap: () async {

                  final res =  await navService.pushNamed("/lifestyle_details" , args:"edit");
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
                      /*ProfileDetailItem(label: TranslationService.translate("bld_group_key"), value: bld_group),*/
                      ProfileDetailItem(label: TranslationService.translate("body_type_key"), value: body_type),
                      /*ProfileDetailItem(label: TranslationService.translate("diet_type_key"), value: diet_type),*/
                      ProfileDetailItem(label: TranslationService.translate("fitness_key"), value: fitness),
                     /* ProfileDetailItem(label: TranslationService.translate("drink_type_key"), value: drink_type),
                      ProfileDetailItem(label: TranslationService.translate("smoke_type_key"), value: smoke_type),*/
                      ProfileDetailItem(label: TranslationService.translate("physical_key"), value: handicap),
                      ProfileDetailItem(label: TranslationService.translate("physical_details_key"), value: handicap_details),
                      ProfileDetailItem(label: TranslationService.translate("overall_health_details_key"), value: overall_health_details),
                    ],
                  ),
                ),),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector( onTap: () async {

                  final res =  await navService.pushNamed("/contact_details" , args:"edit");
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
                      GestureDetector(onTap: (){

                        utils().dialPhoneNumber(mobile);

                      } ,child:ProfileDetailItem(label: TranslationService.translate("mobile_key"), value: mobile),),
                      ProfileDetailItem(label: TranslationService.translate("alt_mobile_key"), value: alt_mobile),
                      ProfileDetailItem(label: TranslationService.translate("email_key"), value: email),
                      /*ProfileDetailItem(label: TranslationService.translate("alt_email_key") , value: alt_email),*/
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
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector(onTap: () async {

                  final res =  await navService.pushNamed("/education_details" ,args:"edit");
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
                      /*ProfileDetailItem(label: TranslationService.translate("is_reputed_key"), value: is_reputed == "0" ? "No" : "Yes"),
                      ProfileDetailItem(label: TranslationService.translate("institute_name_key"), value: institute_name),
                      ProfileDetailItem(label: TranslationService.translate("is_administrative_key") , value: is_administrative == "0" ? "No" : "Yes"),
                      ProfileDetailItem(label: TranslationService.translate("admin_position_key"), value: admin_position),*/
                    ],
                  ),
                ),),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector(onTap: () async {

                  final res =  await  navService.pushNamed("/occuaptional_details" ,args:"edit");
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

                  final res =  await navService.pushNamed("/horoscope_details" ,args:"edit");
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
                      ProfileDetailItem(label: TranslationService.translate("bdate_key"), value: bdate),
                      ProfileDetailItem(label: TranslationService.translate("bcity_key"), value: bcity),
                      ProfileDetailItem(label: TranslationService.translate("btime_key"), value: btime),
                      ProfileDetailItem(label: TranslationService.translate("rashi_key"), value: rashi),
                      ProfileDetailItem(label: TranslationService.translate("birth_star_key"), value: birth_star),
                      /*ProfileDetailItem(label: TranslationService.translate("gotra_key"), value: gotra),
                      ProfileDetailItem(label: TranslationService.translate("mangalik_key"), value: magalik),
                      ProfileDetailItem(label: TranslationService.translate("believe_horoscope_key"), value: belive_horoscope),*/
                      ProfileDetailItem(label: TranslationService.translate("location_coords_key"), value: location_coords),

                    ],
                  ),
                ),),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector( onTap: () async {

                  final res =  await navService.pushNamed("/fml_details" ,args:"edit");
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
                    /*  ProfileDetailItem(label: TranslationService.translate("fml_value_key"), value: fml_value),
                      ProfileDetailItem(label: TranslationService.translate("fml_type_key"), value: fml_type),*/
                      ProfileDetailItem(label: TranslationService.translate("num_brother_key"), value: num_brother),
                      ProfileDetailItem(label: TranslationService.translate("num_sister_key"), value: num_sister),
                      ProfileDetailItem(label: TranslationService.translate("num_married_bro_key"), value: num_married_bro),
                      ProfileDetailItem(label: TranslationService.translate("num_married_sister_key"), value: num_married_sister),
                      ProfileDetailItem(label: TranslationService.translate("father_name_key"), value: father_name),
                      ProfileDetailItem(label: TranslationService.translate("mother_name_key"), value: mother_name),
                      ProfileDetailItem(label: TranslationService.translate("father_coccup_key"), value: father_coccup),
                      ProfileDetailItem(label: TranslationService.translate("mother_occup_key"), value: mother_occup),
                      ProfileDetailItem(label: TranslationService.translate("house_owned_key"), value: house_owned),
                      ProfileDetailItem(label: TranslationService.translate("house_type_key"), value: house_type),
                      /*ProfileDetailItem(label: TranslationService.translate("fml_status_key"), value: fml_status),*/

                      ProfileDetailItem(label: TranslationService.translate("shakh"), value: shakh),
                      ProfileDetailItem(label: TranslationService.translate("native"), value: native),
                      ProfileDetailItem(label: TranslationService.translate("native_address"), value: native_address),
                      ProfileDetailItem(label: TranslationService.translate("moshal_sakh"), value: moshal_sakh),
                     /* ProfileDetailItem(label: TranslationService.translate("moshal_native"), value: moshal_native),*/

                      /*ProfileDetailItem(label: TranslationService.translate("family_slogan_key"), value: family_slogan),*/
                    ],
                  ),
                ),),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector( onTap: () async {

                  final res =  await navService.pushNamed("/fml_member_details" ,args:"edit");
                  initdata();


                } ,child: Icon(Icons.edit, color: Colors.white),),
                header:  Text(TranslationService.translate("family_member_details_key"), style: headerStyle),
                contentHorizontalPadding: 10,
                contentVerticalPadding: 10,
                content: Container(child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      if (membername1.isNotEmpty) ...[
                        Text(
                          "Family Member Details 1",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        ProfileDetailItem(label: TranslationService.translate("member_name"), value: membername1),
                        ProfileDetailItem(label: TranslationService.translate("relation_with_can"), value: relation1),
                        ProfileDetailItem(label: TranslationService.translate("marital_status_members"), value: marital1),
                        ProfileDetailItem(label: TranslationService.translate("age"), value: age1),
                        ProfileDetailItem(label: TranslationService.translate("education"), value: education1),
                        ProfileDetailItem(label: TranslationService.translate("occupation_annual_income"), value: occupation_income1),
                      ],

                      SizedBox(height: 16),

                      // FAMILY MEMBER DETAILS 2
                      if (membername2.isNotEmpty) ...[
                        Text(
                          "Family Member Details 2",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        ProfileDetailItem(label: TranslationService.translate("member_name"), value: membername2),
                        ProfileDetailItem(label: TranslationService.translate("relation_with_can"), value: relation2),
                        ProfileDetailItem(label: TranslationService.translate("marital_status_members"), value: marital2),
                        ProfileDetailItem(label: TranslationService.translate("age"), value: age2),
                        ProfileDetailItem(label: TranslationService.translate("education"), value: education2),
                        ProfileDetailItem(label: TranslationService.translate("occupation_annual_income"), value: occupation_income2),
                      ],

                      SizedBox(height: 16),

                      // FAMILY MEMBER DETAILS 3
                      if (membername3.isNotEmpty) ...[
                        Text(
                          "Family Member Details 3",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        ProfileDetailItem(label: TranslationService.translate("member_name"), value: membername3),
                        ProfileDetailItem(label: TranslationService.translate("relation_with_can"), value: relation3),
                        ProfileDetailItem(label: TranslationService.translate("marital_status_members"), value: marital3),
                        ProfileDetailItem(label: TranslationService.translate("age"), value: age3),
                        ProfileDetailItem(label: TranslationService.translate("education"), value: education3),
                        ProfileDetailItem(label: TranslationService.translate("occupation_annual_income"), value: occupation_income3),
                      ],


                      if (membername4.isNotEmpty) ...[
                        Text(
                          "Family Member Details 4",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        ProfileDetailItem(label: TranslationService.translate("member_name"), value: membername4),
                        ProfileDetailItem(label: TranslationService.translate("relation_with_can"), value: relation4),
                        ProfileDetailItem(label: TranslationService.translate("marital_status_members"), value: marital4),
                        ProfileDetailItem(label: TranslationService.translate("age"), value: age4),
                        ProfileDetailItem(label: TranslationService.translate("education"), value: education4),
                        ProfileDetailItem(label: TranslationService.translate("occupation_annual_income"), value: occupation_income4),
                      ],

                      SizedBox(height: 16),

                      // FAMILY MEMBER DETAILS 5
                      if (membername5.isNotEmpty) ...[
                        Text(
                          "Family Member Details 5",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        ProfileDetailItem(label: TranslationService.translate("member_name"), value: membername5),
                        ProfileDetailItem(label: TranslationService.translate("relation_with_can"), value: relation5),
                        ProfileDetailItem(label: TranslationService.translate("marital_status_members"), value: marital5),
                        ProfileDetailItem(label: TranslationService.translate("age"), value: age5),
                        ProfileDetailItem(label: TranslationService.translate("education"), value: education5),
                        ProfileDetailItem(label: TranslationService.translate("occupation_annual_income"), value: occupation_income5),
                      ],

                      SizedBox(height: 16),

                      // FAMILY MEMBER DETAILS 6
                      if (membername6.isNotEmpty) ...[
                        Text(
                          "Family Member Details 6",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        ProfileDetailItem(label: TranslationService.translate("member_name"), value: membername6),
                        ProfileDetailItem(label: TranslationService.translate("relation_with_can"), value: relation6),
                        ProfileDetailItem(label: TranslationService.translate("marital_status_members"), value: marital6),
                        ProfileDetailItem(label: TranslationService.translate("age"), value: age6),
                        ProfileDetailItem(label: TranslationService.translate("education"), value: education6),
                        ProfileDetailItem(label: TranslationService.translate("occupation_annual_income"), value: occupation_income6),
                      ],

                      SizedBox(height: 16),

                      // REFERENCE MEMBERS
                      if (refmembername1.isNotEmpty || refmembername2.isNotEmpty) ...[
                        Text(
                          "Reference Member1",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                        ),

                        if (refmembername1.isNotEmpty) ...[
                          ProfileDetailItem(label: TranslationService.translate("member_name"), value: refmembername1),
                          ProfileDetailItem(label: TranslationService.translate("address"), value: refmemberadd1),
                          ProfileDetailItem(label: TranslationService.translate("mobile"), value: refmembermobile1),
                        ],


                        Text(
                          "Reference Member2",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                        ),

                        if (refmembername2.isNotEmpty) ...[
                          ProfileDetailItem(label: TranslationService.translate("member_name"), value: refmembername2),
                          ProfileDetailItem(label: TranslationService.translate("address"), value: refmemberadd2),
                          ProfileDetailItem(label: TranslationService.translate("mobile"), value: refmembermobile2),
                        ],
                      ],




                    ],
                  ),
                ),),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector(onTap: () async {

                  final res =  await navService.pushNamed("/partner_details" ,args:"edit");
                  initdata();


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
                      ProfileDetailItem(label: TranslationService.translate("shakh"), value: subcaste_prefs),
                      ProfileDetailItem(label: TranslationService.translate("skintone_prefs_key"), value: skintone_prefs),
                      ProfileDetailItem(label: TranslationService.translate("state_prefs_key"), value: state_prefs),
                      ProfileDetailItem(label: TranslationService.translate("city_prefs_key"), value:  city_prefs),
                      ProfileDetailItem(label: TranslationService.translate("edu_prefs_key"), value: edu_prefs),
                      ProfileDetailItem(label: TranslationService.translate("ocupation_prefs_key"), value: ocupation_prefs),
                      ProfileDetailItem(label: TranslationService.translate("body_prefs_key"), value: body_prefs),
                   //   ProfileDetailItem(label: TranslationService.translate("diet_prefs_key"), value: diet_prefs),
                   //   ProfileDetailItem(label: TranslationService.translate("drink_prefs_key"), value: drink_prefs),
                   //   ProfileDetailItem(label: TranslationService.translate("smoke_prefs_key"), value: smoke_prefs),
                   //   ProfileDetailItem(label: TranslationService.translate("fml_value_key"), value: fml_value),
                      ProfileDetailItem(label: TranslationService.translate("annual_income_prefs_key"), value: annual_income_prefs),
                    ],
                  ),
                ),),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: GestureDetector(onTap: () async {

                  final res =  await  navService.pushNamed("/preference_filter" ,args:"edit");
                  initdata();

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

                  final res =  await  navService.pushNamed("/hobbies" ,args:"edit");
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

                  final res =  await  navService.pushNamed("/documents" ,args:"edit");
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



    )));


  }



}