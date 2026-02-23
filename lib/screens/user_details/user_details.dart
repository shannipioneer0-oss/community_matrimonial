import 'dart:ffi';
import 'dart:io';

import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/SendNotification.dart';
import 'package:community_matrimonial/app_utils/Userdata.dart';
import 'package:community_matrimonial/network_utils/model/profile_details_model.dart';
import 'package:community_matrimonial/network_utils/service/VideoCalls.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/chat/ChatScreen.dart';
import 'package:community_matrimonial/screens/chat/models/horoscope.dart';
import 'package:community_matrimonial/screens/chat/models/message.dart';
import 'package:community_matrimonial/screens/user_profile/FancyBorderDashedImage.dart';
import 'package:community_matrimonial/screens/user_profile/FancyBorderedImage.dart';
import 'package:community_matrimonial/screens/user_profile/userdetail_other/ExpandingPanel.dart';
import 'package:community_matrimonial/screens/user_profile/userdetail_other/contact.dart';
import 'package:community_matrimonial/screens/user_profile/userdetail_other/family_details.dart';
import 'package:community_matrimonial/screens/user_profile/userdetail_other/horoscope.dart';
import 'package:community_matrimonial/screens/user_profile/userdetail_other/personal_detail.dart';
import 'package:community_matrimonial/screens/user_profile/userdetail_other/userdetailProvider.dart';
import 'package:community_matrimonial/screens/videocalls/call.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../../utils/universalback_wrapper.dart';
import '../user_profile/add_edit_profile/educationaldetails.dart';




class UserDetailOther extends StatelessWidget {
  final List user;

  UserDetailOther({required this.user});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserDetailProvider>(
        create: (_) {
          return UserDetailProvider();
        },
        child: MaterialApp(
          home: UserDetailStateful(user),
          builder: EasyLoading.init(),
        ));
  }
}

class UserDetailStateful extends StatefulWidget {
  final List user;

  UserDetailStateful(this.user);

  @override
  UserDetailScreen createState() => UserDetailScreen();
}

class UserDetailScreen extends State<UserDetailStateful> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedindex = 0;



  @override
  void initState() {
    super.initState();

   _checkConnectivity();

    initViews();
    initOfflinemessages();

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



  initOfflinemessages() async {

    Directory? externalDir = await getExternalStorageDirectory();

    if (externalDir != null) {
      // Create a custom directory within the external storage
      String customDirPath = '${externalDir.path}/Storage';

      print(customDirPath);
      Directory customDir = Directory(customDirPath);

      // Ensure the custom directory exists
      if (!customDir.existsSync()) {
        customDir.createSync(recursive: true);
      }

      Directory directory = Directory(customDirPath);
      await Hive.initFlutter(customDirPath);

    }

    bool isRegistered = Hive.isAdapterRegistered(0);
    bool isRegistered1 = Hive.isAdapterRegistered(1);

    if(isRegistered == false){
      Hive.registerAdapter<Message123>(MessageAdapter());
    }
     if(isRegistered1 == false) {
       Hive.registerAdapter<Horoscope>(HoroscopeAdapter());
     }

    /// Open box
    await Hive.openBox<Message123>("messages");
    await Hive.openBox<Horoscope>("horoscope");

  }

  BasicInfo basicinfo = BasicInfo();
  PhysicalInfo physicalinfo = PhysicalInfo();
  EducationInfo educationinfo = EducationInfo();
  OccupationInfo pccupinfo = OccupationInfo();

  VerificationInfo verificationInfo = VerificationInfo();
  ContactInfo contactInfo = ContactInfo();
  FamilyInfo familyInfo = FamilyInfo();
  AstroInfo astroinfo = AstroInfo();
  PhotoInfo picinfo = PhotoInfo();
  PrivacySettings privacy = PrivacySettings();

  bool isshortlist = false, like = false;
  String shortlist = "", likes = "" , view_contacts = "" , view_horoscope = "";
  String hobbies = "";

  SharedPreferences? prefs;
  String communityId = "";

  initViews() async {

    EasyLoading.show(status: "Loading Wait...");

     prefs = await SharedPreferences.getInstance();
    communityId =  prefs!.getString(SharedPrefs.communityId).toString();

    print({
      "userId": widget.user[0].replaceAll(RegExp(r'\D'), ''),
      "communityId": prefs?.getString(SharedPrefs.communityId),
      "myuserId": prefs?.getString(SharedPrefs.userId),
      "Id": prefs?.getString(SharedPrefs.userId),
      "original": "en",
      "translate": [prefs?.getString(SharedPrefs.translate)]
    });


    Future.delayed(Duration(milliseconds: 200), () {
      Userdata().initUserData(context);
    });

    final _response = await Provider.of<ApiService>(context, listen: false)
      .postProfileDetails({
      "userId": prefs?.getString(SharedPrefs.translate).toString() == "mr" ?  utils().marathiToEnglish(widget.user[0]).toString() : widget.user[0].replaceAll(RegExp(r'\D'), '').toString(),
      "communityId": prefs?.getString(SharedPrefs.communityId).toString(),
      "myuserId": prefs?.getString(SharedPrefs.userId).toString(),
      "Id": prefs?.getString(SharedPrefs.userId).toString(),
      "original": "en",
      "translate": [prefs?.getString(SharedPrefs.translate).toString()]
    });

    print(_response.body);

    print(widget.user[0]+"++==++");
    print({
      "userId": prefs?.getString(SharedPrefs.translate) == "mr" ?  utils().marathiToEnglish(widget.user[0]) : widget.user[0].replaceAll(RegExp(r'\D'), ''),
      "communityId": prefs?.getString(SharedPrefs.communityId).toString(),
      "myuserId": prefs?.getString(SharedPrefs.userId).toString(),
      "Id": prefs?.getString(SharedPrefs.userId).toString(),
      "original": "en",
      "translate": [prefs?.getString(SharedPrefs.translate).toString()]
    });


    //ProfileDetailsModel detailResult = ProfileDetailsModel.fromJson(_response.body);

    setState(() {

      if (_response.body["data"][0][0].toString() != "{}") {



        basicinfo = BasicInfo(
            id: 1,
            fullname: _response.body["data"][0][0]["0"]["fullname"],
            createdBy: _response.body["data"][0][0]["0"]["created_by"],
            age: _response.body["data"][0][0]["0"]["dob"],
            maritalStatus: _response.body["data"][0][0]["0"]["marital_status"],
            caste: _response.body["data"][0][0]["0"]["caste"],
            subcaste: _response.body["data"][0][0]["0"]["subcaste"],
            languageKnown: _response.body["data"][0][0]["0"]["language_known"],
            motherTongue: _response.body["data"][0][0]["0"]["mother_tongue"]);

      }

      if (_response.body["data"][2][0].toString() != "{}") {
        physicalinfo = PhysicalInfo(
            weight: _response.body["data"][2][0]["0"]["weight"],
            height: _response.body["data"][2][0]["0"]["height"],
            skintone: _response.body["data"][2][0]["0"]["skintone"],
            bloodGroup: _response.body["data"][2][0]["0"]["blood_group"],
            fitness: _response.body["data"][2][0]["0"]["fitness"],
            bodyType: _response.body["data"][2][0]["0"]["body_type"],
            isHandicap: _response.body["data"][2][0]["0"]["is_handicap"],
            handicapDetail: _response
                .body["data"][2][0]["0"]["handicap_detail"],
            dietType: _response.body["data"][2][0]["0"]["diet_type"],
            drinkType: _response.body["data"][2][0]["0"]["drink_type"],
            smokeType: _response.body["data"][2][0]["0"]["smoke_type"]);
      }

      if (_response.body["data"][3][0].toString() != "{}") {
        String first  = "" ,second  ="" , third = "";

      //  print(_response.body["data"][3][0]["0"]["education"]+"====---");

        List<Course> courses = _response.body["data"][3][0]["0"]["education"] != null ? _response.body["data"][3][0]["0"]["education"].toString()
        !.split('|')
            .map((e) => Course.fromString(e))
            .toList() : [];

        try{

          first = courses[0].label;

        }catch(ex){
          first =  "";
        }

        try{

          second = courses[1].label;

        }catch(ex){
          second =  "";
        }

        try{

          third = courses[2].label;

        }catch(ex){
          third =  "";
        }

        final result = [
          if (first.isNotEmpty) first ,
          if (second.isNotEmpty) second,
          if (third.isNotEmpty) third
        ];




        educationinfo = EducationInfo(
            isFromAdminService: _response.body["data"][3][0]["0"]
            ["is_from_admin_service"],
            adminPositionName: _response.body["data"][3][0]["0"]
            ["admin_position_name"],
            isFromIITIIMNIT: _response.body["data"][3][0]["0"]
            ["is_from_iit_iim_nit"],
            instituteName: _response.body["data"][3][0]["0"]["institute_name"],
            education:  result.join(","),
            educationDetail: _response.body["data"][3][0]["0"]
            ["education_detail"]);
      }

      if (_response.body["data"][4][0].toString() != "{}") {
        pccupinfo = OccupationInfo(
            occupation: _response.body["data"][4][0]["0"]["occupation"],
            occupationDetail: _response.body["data"][4][0]["0"]
            ["occupation_detail"],
            annualIncome: _response.body["data"][4][0]["0"]["annual_income"],
            employmentType: _response
                .body["data"][4][0]["0"]["employment_type"],
            officeAddress: _response.body["data"][4][0]["0"]["office_address"]);
      }

      print(_response.body["data"][9][0]);
      if (_response.body["data"][9][0].toString() != "{}") {
        verificationInfo = VerificationInfo(
            id: _response.body["data"][9][0]["0"]["Id"].toString(),
            idProofs: _response.body["data"][9][0]["0"]["is_id_verify"],
            educationProof: _response.body["data"][9][0]["0"]
                ["education_proof"],
            incomeProof: _response.body["data"][9][0]["0"]["income_proof"],
            isIdVerify: _response.body["data"][9][0]["0"]["is_id_verify"],
            isEducationVerify: _response.body["data"][9][0]["0"]
                ["is_education_verify"],
            isIncomeVerify: _response.body["data"][9][0]["0"]
                ["is_income_verify"],
            userId: prefs?.getString(SharedPrefs.userId).toString(),
            communityId: "",
            profileId: "",
            userVerify: _response.body["data"][9][0]["0"]["user_verify"],
            emailVerify: _response.body["data"][9][0]["0"]["email_verify"],
            mobileVerify: _response.body["data"][9][0]["0"]["mobile_verify"]);
      }

      print("test");
      print(verificationInfo);

      if (_response.body["data"][1][0].toString() != "{}") {

        contactInfo = ContactInfo(
            mobileNumber: _response.body["data"][1][0]["0"]["mobile_number"],
            whatsappNumber: _response
                .body["data"][1][0]["0"]["whatsapp_number"],
            permanentAddress: _response.body["data"][1][0]["0"]
            ["permanent_adddress"],
            emailid: _response.body["data"][1][0]["0"]["emailid"],
            alternateMobile: _response.body["data"][1][0]["0"]
            ["alternate_mobile"],
            alternateEmail: _response
                .body["data"][1][0]["0"]["alternate_email"],
            workingAddress: _response
                .body["data"][1][0]["0"]["working_address"],
            contactTime: _response.body["data"][1][0]["0"]["contact_time"],
            permCountry: _response.body["data"][1][0]["0"]["perm_country"],
            permState: _response.body["data"][1][0]["0"]["perm_state"],
            permCity: _response.body["data"][1][0]["0"]["perm_city"],
            workCountry: _response.body["data"][1][0]["0"]["work_country"],
            workState: _response.body["data"][1][0]["0"]["work_state"],
            workCity: _response.body["data"][1][0]["0"]["work_city"]);

      }

      if (_response.body["data"][5][0].toString() != "{}") {

        familyInfo = FamilyInfo(
            familyStatus: _response.body["data"][5][0]["0"]["family_status"],
            familyType: _response.body["data"][5][0]["0"]["family_type"],
            familyValue: _response.body["data"][5][0]["0"]["family_value"],
            noBrother: _response.body["data"][5][0]["0"]["no_brother"],
            noSister: _response.body["data"][5][0]["0"]["no_sister"],
            marriedBrother: _response
                .body["data"][5][0]["0"]["married_brother"],
            marriedSister: _response.body["data"][5][0]["0"]["married_sister"],
            fatherName: _response.body["data"][5][0]["0"]["father_name"],
            motherName: _response.body["data"][5][0]["0"]["mother_name"],
            fatherOccupation: _response.body["data"][5][0]["0"]
            ["father_occupation"],
            motherOccupation: _response.body["data"][5][0]["0"]
            ["mother_occupation"],
            houseOwned: _response.body["data"][5][0]["0"]["house_owned"],
            houseType: _response.body["data"][5][0]["0"]["house_type"],
            parentsStayOptions: _response.body["data"][5][0]["0"]
            ["parents_stay_options"],
            detailFamily: _response.body["data"][5][0]["0"]["detail_family"]);

      }

      if (_response.body["data"][6][0].toString() != "{}") {

        astroinfo = AstroInfo(
            astroRashi: _response.body["data"][6][0]["0"]["astro_rashi"],
            birthStar: _response.body["data"][6][0]["0"]["birth_star"],
            gotra: _response.body["data"][6][0]["0"]["gotra"],
            believeHoroscope: _response.body["data"][6][0]["0"]
            ["believe_horoscope"],
            birthDate: _response.body["data"][6][0]["0"]["birth_date"],
            birthPlace: _response.body["data"][6][0]["0"]["birth_place"],
            birthTime: _response.body["data"][6][0]["0"]["birth_time"],
            birthCountry: _response.body["data"][6][0]["0"]["birth_country"],
            horoscopeDoc: '',
            birthLocation: _response.body["data"][6][0]["0"]["birth_location"],
            timezone: _response.body["data"][6][0]["0"]["timezone"],
            isMangalik: _response.body["data"][6][0]["0"]["is_mangalik"]);

      }

      if (_response.body["data"][7][0].toString() != "{}") {

        picinfo = PhotoInfo(
            id: prefs?.getString(SharedPrefs.translate) != "en" && prefs?.getString(SharedPrefs.translate) != "mr" ? int.parse(_response.body["data"][7][0]["0"]["Id"]) : prefs?.getString(SharedPrefs.translate) != "en" && prefs?.getString(SharedPrefs.translate) == "mr" ? int.parse(utils().marathiToEnglish(_response.body["data"][7][0]["0"]["Id"]))    : _response.body["data"][7][0]["0"]["Id"],
            pic1: _response.body["data"][7][0]["0"]["pic1"],
            pic2: _response.body["data"][7][0]["0"]["pic2"],
            pic3: _response.body["data"][7][0]["0"]["pic3"],
            pic4: _response.body["data"][7][0]["0"]["pic4"],
            pic5: _response.body["data"][7][0]["0"]["pic5"],
            pic6: _response.body["data"][7][0]["0"]["pic6"],
            pic7: _response.body["data"][7][0]["0"]["pic7"],
            pic8: _response.body["data"][7][0]["0"]["pic8"],
            isVerifyPic1: _response.body["data"][7][0]["0"]["isverifypic1"],
            isVerifyPic2: _response.body["data"][7][0]["0"]["isverifypic2"],
            isVerifyPic3: _response.body["data"][7][0]["0"]["isverifypic3"],
            isVerifyPic4: _response.body["data"][7][0]["0"]["isverifypic4"],
            isVerifyPic5: _response.body["data"][7][0]["0"]["isverifypic5"],
            isVerifyPic6: _response.body["data"][7][0]["0"]["isverifypic6"],
            isVerifyPic7: _response.body["data"][7][0]["0"]["isverifypic7"],
            isVerifyPic8: _response.body["data"][7][0]["0"]["isverifypic8"],
            isVerifyPic9: _response.body["data"][7][0]["0"]["isverifypic9"],
            isVerifyPic10: _response.body["data"][7][0]["0"]["isverifypic10"],
            userId: _response.body["data"][7][0]["0"]["userId"],
            communityId: _response.body["data"][7][0]["0"]["communityId"],
            profileId: _response.body["data"][7][0]["0"]["profileId"]);

           print(picinfo.pic1.toString()+"--=====----===");

      } else {

      }

      if (_response.body["data"][14][0].toString() != "{}") {

        privacy = PrivacySettings(
            id: prefs?.getString(SharedPrefs.translate) != "en" && prefs?.getString(SharedPrefs.translate) != "mr" ? int.parse(_response.body["data"][14][0]["0"]["Id"]) : prefs?.getString(SharedPrefs.translate) != "en" && prefs?.getString(SharedPrefs.translate) == "mr" ? int.parse(utils().marathiToEnglish(_response.body["data"][14][0]["0"]["Id"])) : _response.body["data"][14][0]["0"]["Id"],
            phonePrivacy: _response.body["data"][14][0]["0"]["phone_privacy"],
            photoPrivacy: _response.body["data"][14][0]["0"]["photo_privacy"],
            horoscopePrivacy: _response.body["data"][14][0]["0"]
                ["horoscope_privacy"],
            userId: _response.body["data"][14][0]["0"]["userId"],
            communityId: _response.body["data"][14][0]["0"]["communityId"],
            profileId: _response.body["data"][14][0]["0"]["profileId"],
            user_verify: _response.body["data"][14][0]["0"]["user_verify"],
            mobile_verify: _response.body["data"][14][0]["0"]["mobile_verify"],
            email_verify: _response.body["data"][14][0]["0"]["email_verify"]);
      }

      if (_response.body["data"][11][0].toString() != "{}") {
        isshortlist = _response.body["data"][11][0]["0"]["shortlist"]
            .toString()
            .split(",")
            .contains(widget.user[0]);
        shortlist = _response.body["data"][11][0]["0"]["shortlist"].toString();
      }

      if (_response.body["data"][12][0].toString() != "{}") {
        like = _response.body["data"][12][0]["0"]["likes"]
            .toString()
            .split(",")
            .contains(widget.user[0]);
        likes = _response.body["data"][12][0]["0"]["likes"].toString();
      }

      if (_response.body["data"][16][0].toString() != "{}") {
        view_contacts = _response.body["data"][16][0]["0"]["view_contacts"].toString();
      }

      print(_response.body["data"][16][0].toString()+"{}{}");

      if (_response.body["data"][17][0].toString() != "{}") {
        view_horoscope = _response.body["data"][17][0]["0"]["view_horoscope"].toString();
      }

      if (_response.body["data"][18][0].toString() != "{}") {
        hobbies = _response.body["data"][18][0]["0"]["hobbies"].toString();
      }

    });

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return UniversalBackWrapper(
        isRoot: false

        ,child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Text(
              'Details Of ' + widget.user[1],
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
            toolbarOpacity: 1,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Image.asset(
                "assets/images/back.png",
                width: 50,
                height: 40,
              ),
              onPressed: () {

                navService.goBack();

              },
            )),
        body: SingleChildScrollView(
          child: SafeArea(child: Container(
              color: ColorsPallete.grey_light_2,
              constraints: BoxConstraints(
                maxWidth: double.infinity,
                // Allows the container to expand horizontally
                maxHeight: double
                    .infinity, // Allows the container to expand vertically
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.309,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          child: GestureDetector(onTap: (){


                            if(picinfo.pic1 != "null" && picinfo.pic1 != "" && picinfo.pic1 != null) {
                              navService.pushNamed("/img_gallery_other",
                                  args: [picinfo , basicinfo.fullname]);
                            }

                          }  ,child:Image.network(
                              Strings.IMAGE_BASE_URL +
                                  "/uploads/"+utils().imagePath(communityId)+
                                  picinfo.pic1.toString(),
                              fit: BoxFit.fitWidth , errorBuilder: (context, error, stackTrace) {

                                return Image.asset("assets/images/no_image.png" , fit: BoxFit.fitWidth);

                              },),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [ ExpandingPanel(picinfo , basicinfo.fullname.toString())],
                        ),
                         Positioned(
                           bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                  padding: EdgeInsets.only(top: 5),
                                  color: Colors.black38,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                          onTap: () async {


                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            if (isshortlist == false) {
                                              final result = await DialogClass()
                                                  .showDialogBeforesubmit(
                                                      context,
                                                      "Shortlist alert!",
                                                      "Are you sure you want to shortlist this person?",
                                                      "Shortlist",
                                                      "shortlist");

                                              if (result == "shortlist") {
                                                final _response = await Provider
                                                        .of<ApiService>(context,
                                                            listen: false)
                                                    .postshortlistInsert({
                                                  "fromId": prefs.getString(
                                                      SharedPrefs.userId),
                                                  "memberId": widget.user[0],
                                                  "is_shortlist": "1",
                                                  "communityId": prefs
                                                      .getString(SharedPrefs
                                                          .communityId)
                                                });

                                                print(
                                                    _response.body.toString());

                                                if (_response.body["success"] ==
                                                    1) {
                                                  setState(() {
                                                    //   widget.user.isshortlist = true;

                                                    shortlist = shortlist +
                                                        "," +
                                                        widget.user[0];
                                                    isshortlist = shortlist
                                                        .split(",")
                                                        .contains(
                                                            widget.user[0]);
                                                  });
                                                }
                                              }
                                            } else {
                                              final result = await DialogClass()
                                                  .showDialogBeforesubmit(
                                                      context,
                                                      "Shortlist alert!",
                                                      "Are you sure you want to remove shortlist",
                                                      "Remove",
                                                      "shortlist");

                                              if (result == "shortlist") {
                                                final _response = await Provider
                                                        .of<ApiService>(context,
                                                            listen: false)
                                                    .postshortlistInsert({
                                                  "fromId": prefs.getString(
                                                      SharedPrefs.userId),
                                                  "memberId": widget.user[0],
                                                  "is_shortlist": "0",
                                                  "communityId": prefs
                                                      .getString(SharedPrefs
                                                          .communityId)
                                                });

                                                print(
                                                    _response.body.toString());

                                                if (_response.body["success"] ==
                                                    1) {
                                                  setState(() {
                                                    //  widget.user.isshortlist = false;
                                                    shortlist =
                                                        shortlist.replaceAll(
                                                            "," +
                                                                widget.user[0],
                                                            "");
                                                    isshortlist = shortlist
                                                        .split(",")
                                                        .contains(
                                                            widget.user[0]);
                                                  });
                                                }
                                              }
                                            }
                                          },
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/ellipse_white.png",
                                                width: 45,
                                                height: 45,
                                                color: isshortlist == false
                                                    ? ColorsPallete.Pink2
                                                    : ColorsPallete.Pink,
                                              ),
                                              Positioned(
                                                  top: 10,
                                                  child: Image.asset(
                                                    "assets/images/shortlist.png",
                                                    width: 20,
                                                    height: 20,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          )),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            int num = prefs
                                                .getString(SharedPrefs
                                                .numExpressInterests)
                                                .toString() == "" ? 0 : int.parse(prefs.getString(SharedPrefs.numExpressInterests).toString());

                                            if (prefs.getString(
                                                    SharedPrefs.validityDays) !=
                                                null) {

                                                if (like == false) {
                                                  final result = await DialogClass()
                                                      .showDialogBeforesubmit(
                                                          context,
                                                          "Express Interest!",
                                                          "Are you sure you want to Send like to this person?",
                                                          "Send Like",
                                                          "like");

                                                  if (result == "like") {
                                                    final _response = await Provider
                                                            .of<ApiService>(
                                                                context,
                                                                listen: false)
                                                        .postExpressInterestInsert({
                                                      "from_id": prefs
                                                          .getString(SharedPrefs
                                                              .userId),
                                                      "to_id": widget.user[0],
                                                      "is_sent": "1",
                                                      "communityId": prefs
                                                          .getString(SharedPrefs
                                                              .communityId)
                                                    });

                                                    if (_response.body["data"]
                                                            ["affectedRows"] ==
                                                        1) {
                                                      setState(() {
                                                        likes = likes +
                                                            "," +
                                                            widget.user[0];

                                                        like = likes.split(",").contains(widget.user[0]);
                                                      });

                                                      final _response = await Provider
                                                              .of<ApiService>(
                                                                  context,
                                                                  listen: false)
                                                          .postInsertNotification({
                                                        "notifi_type":
                                                            "interest",
                                                        "message": "Like Request from " +
                                                            prefs
                                                                .getString(
                                                                    SharedPrefs
                                                                        .fullname)
                                                                .toString(),
                                                        "sender_type": "user",
                                                        "sender_id":
                                                            prefs.getString(
                                                                SharedPrefs
                                                                    .userId),
                                                        "reciever_id":
                                                            widget.user[0],
                                                        "communityId":
                                                            prefs.getString(
                                                                SharedPrefs
                                                                    .communityId)
                                                      });

                                                      SendNotification().sendWhatsapp(
                                                        contactInfo.whatsappNumber.toString(),
                                                        "Like Request From " +
                                                            prefs
                                                                .getString(
                                                                SharedPrefs.fullname)
                                                                .toString()+"\n"+
                                                            "The Request is from Community Matrimonial regarding like request from " +
                                                            prefs
                                                                .getString(
                                                                SharedPrefs.fullname)
                                                                .toString() +
                                                            " Please kindly accept or reject request by opening notification section of app or website",
                                                      );


                                                    }
                                                  } else {}
                                                } else {
                                                  DialogClass().showDialog2(
                                                      context,
                                                      "Express Interest alert!",
                                                      "Already Expressed Interest",
                                                      "Ok");
                                                }

                                            } else {

                                                if (like == false) {
                                                  final result = await DialogClass()
                                                      .showDialogBeforesubmit(
                                                          context,
                                                          "Express Interest!",
                                                          "Are you sure you want to Send like to this person?",
                                                          "Send Like",
                                                          "like");

                                                  if (result == "like") {

                                                    final _response = await Provider
                                                            .of<ApiService>(
                                                                context,
                                                                listen: false)
                                                        .postExpressInterestInsert({
                                                      "from_id": prefs
                                                          .getString(SharedPrefs
                                                              .userId),
                                                      "to_id": widget.user[0],
                                                      "is_sent": "1",
                                                      "communityId": prefs
                                                          .getString(SharedPrefs
                                                              .communityId)
                                                    });

                                                    if (_response.body["data"]
                                                            ["affectedRows"] ==
                                                        1) {
                                                      setState(() {
                                                        likes = likes +
                                                            "," +
                                                            widget.user[0];

                                                        like = likes.split(",").contains(widget.user[0]);
                                                      });

                                                      final _response = await Provider
                                                              .of<ApiService>(
                                                                  context,
                                                                  listen: false)
                                                          .postInsertNotification({
                                                        "notifi_type":
                                                            "interest",
                                                        "message": "Like Request from " +
                                                            prefs
                                                                .getString(
                                                                    SharedPrefs
                                                                        .fullname)
                                                                .toString(),
                                                        "sender_type": "user",
                                                        "sender_id":
                                                            prefs.getString(
                                                                SharedPrefs
                                                                    .userId),
                                                        "reciever_id":
                                                            widget.user[0],
                                                        "communityId":
                                                            prefs.getString(
                                                                SharedPrefs
                                                                    .communityId)
                                                      });

                                                      SendNotification().sendWhatsapp(
                                                        contactInfo.whatsappNumber.toString(),
                                                        "Like Request From " +
                                                            prefs
                                                                .getString(
                                                                SharedPrefs.fullname)
                                                                .toString()+"\n"+
                                                            "The Request is from Community Matrimonial regarding like request from " +
                                                            prefs
                                                                .getString(
                                                                SharedPrefs.fullname)
                                                                .toString() +
                                                            " Please kindly accept or reject request by opening notification section of app or website",
                                                      );


                                                    }
                                                  } else {}
                                                } else {
                                                  DialogClass().showDialog2(
                                                      context,
                                                      "Express Interest alert!",
                                                      "Already Expressed Interest",
                                                      "Ok");
                                                }

                                            }
                                          },
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/ellipse_white.png",
                                                width: 45,
                                                height: 45,
                                                color: like == false
                                                    ? ColorsPallete.Pink2
                                                    : ColorsPallete.Pink,
                                              ),
                                              Positioned(
                                                  top: 10,
                                                  child: Image.asset(
                                                    "assets/images/send_icon.png",
                                                    width: 15,
                                                    height: 15,
                                                  ))
                                            ],
                                          )),
                                      SizedBox(
                                        width: 3,
                                      ),
                                   /* GestureDetector(onTap: () async {

                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      String msg = Strings.msgvideocall;

                                      String _ispremium = prefs.getString(SharedPrefs.validityDays) ?? "";

                                      if(_ispremium != "") {
                                        if (int.parse(prefs.getString(
                                            SharedPrefs.numVideo).toString()) <
                                            int.parse(prefs.getString(
                                                SharedPrefs.numberVideo)
                                                .toString())) {


                                          Dialogs.materialDialog(
                                              msg: msg,
                                              title: "Vidoe Call",
                                              color: Colors.white,
                                              context: context,
                                              onClose: (value) =>
                                                  print(
                                                      "returned value is '$value'"),
                                              actions: [
                                                IconsOutlineButton(
                                                  onPressed: () {
                                                    Navigator.of(context,
                                                        rootNavigator: true)
                                                        .pop();





                                                    VideoCalls()
                                                        .sendVideoPushMessage(
                                                        [widget.user[2]],
                                                        utils()
                                                            .getRandomString2(
                                                            12),
                                                        prefs.getString(SharedPrefs.fullname)
                                                            .toString(),
                                                        Strings.IMAGE_BASE_URL +
                                                            "/uploads/matrimonial_photo/" +
                                                            prefs.getString(SharedPrefs.pic1)
                                                                .toString(),
                                                        prefs.getString(SharedPrefs.mobileNumber)
                                                            .toString(),
                                                        prefs.getString(
                                                            SharedPrefs
                                                                .profileid)
                                                            .toString() + "_" +
                                                            widget.user[3],
                                                        prefs.getString(SharedPrefs.mobile_reg_token).toString());

                                                    String token = VideoCalls()
                                                        .getToken(
                                                        prefs.getString(
                                                            SharedPrefs
                                                                .profileid)
                                                            .toString() + "_" +
                                                            widget.user[3]);

                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 500), () {});

                                                    print(widget.user[0] +
                                                        "____{}{}");

                                                    *//*Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Call(list: [
                                                              prefs.getString(
                                                                  SharedPrefs
                                                                      .profileid)
                                                                  .toString() +
                                                                  "_" +
                                                                  widget
                                                                      .user[3],
                                                              token,
                                                              "",
                                                              "0",
                                                              widget.user[0]
                                                            ],),
                                                      ),
                                                    );*//*


                                                  },
                                                  text: "Make a call",
                                                  iconData: Icons.info,
                                                  textStyle: TextStyle(
                                                      color: Colors.green),
                                                  iconColor: Colors.green,
                                                ),

                                                IconsOutlineButton(
                                                  onPressed: () {
                                                    Navigator.of(context,
                                                        rootNavigator: true)
                                                        .pop();
                                                  },
                                                  text: "Cancel call",
                                                  iconData: Icons.info,
                                                  textStyle: TextStyle(
                                                      color: Colors.green),
                                                  iconColor: Colors.green,
                                                ),
                                              ]);
                                        } else {
                                          DialogClass().showDialog2(
                                              context, "Video Call Alert!",
                                              "You have reached your vidoe call limit Please upgrade to make more calls",
                                              "Ok");
                                        }
                                      }else{

                                        DialogClass().showDialog2(
                                            context, "Video Call Alert!",
                                            "To make video clal upgrade to Plans Membership",
                                            "Ok");

                                      }


                                    }  ,child:Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/ellipse_white.png",
                                            width: 45,
                                            height: 45,
                                            color: ColorsPallete.Pink2,
                                          ),
                                          Positioned(
                                              top: 8,
                                              child: Image.asset(
                                                "assets/images/videocall.png",
                                                width: 22,
                                                height: 22,
                                                color: Colors.white,
                                              ))
                                        ],
                                      ),),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      GestureDetector(onTap: () async {

                                        SharedPreferences prefs = await SharedPreferences.getInstance();

                                        String _ispremium = prefs.getString(SharedPrefs.validityDays) ?? "";

                                        if(_ispremium != "") {

                                          navService.pushNamed("/chat_screen",
                                              args: [
                                                prefs.getString(SharedPrefs.userId).toString(),
                                                widget.user[0],
                                                prefs.getString(SharedPrefs.fullname).toString(),
                                                basicinfo.fullname.toString()
                                              ]);

                                          await Provider.of<ApiService>(
                                              context, listen: false).postChat({
                                            "fromId": prefs.getString(
                                                SharedPrefs.userId),
                                            "toId": widget.user[0],
                                            "communityId": prefs.getString(
                                                SharedPrefs.communityId)
                                          });

                                        }else{

                                          DialogClass().showDialog2(
                                              context, "Chat Alert!",
                                              "To Chat upgrade to Premium Plans Membership",
                                              "Ok");

                                        }


                                      }   ,child:Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/ellipse_white.png",
                                            width: 45,
                                            height: 45,
                                            color: ColorsPallete.Pink2,
                                          ),
                                          Positioned(
                                              top: 10,
                                              child: Image.asset(
                                                "assets/images/chat_icon.png",
                                                width: 20,
                                                height: 20,
                                                color: Colors.white,
                                              ))
                                        ],
                                      ),),*/
                                      Expanded(flex: 1, child: Container()),
                                      Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          Positioned(
                                              child: GestureDetector(
                                            onTap: () {
                                              navService.pushNamed(
                                                  "/match_profile",
                                                  args: [
                                                    basicinfo,
                                                    contactInfo,
                                                    physicalinfo,
                                                    educationinfo,
                                                    pccupinfo,
                                                    familyInfo,
                                                    picinfo
                                                  ]);
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    bottomLeft:
                                                        Radius.circular(20.0),
                                                  ),
                                                  color: ColorsPallete.Pink2,
                                                ),
                                                height: 30,
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  "Match Profile",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ))
                                        ],
                                      ),
                                    ],
                                  ))),

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    child: SlideSwitcher(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text(
                              'Personal',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: selectedindex == 0
                                      ? ColorsPallete.blue_2
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text('Contact',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: selectedindex == 1
                                        ? ColorsPallete.blue_2
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text('Family',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: selectedindex == 2
                                        ? ColorsPallete.blue_2
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text('Horoscope',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: selectedindex == 3
                                        ? ColorsPallete.blue_2
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ),
                        ],
                        containerBorderRadius: 2,
                        indents: 12,
                        containerColor: ColorsPallete.Pink,
                        onSelect: (index) {
                          setState(() {
                            selectedindex = index;
                          });
                        },
                        containerHeight: 50,
                        containerWight: MediaQuery.of(context).size.width,
                        direction: Axis.horizontal),
                  ),
                  Container(
                      child: selectedindex == 0
                          ? basicinfo != null
                              ? personal(basicinfo, physicalinfo, educationinfo,
                                  pccupinfo, verificationInfo , widget.user[0] ,hobbies)
                              : Container()
                          : selectedindex == 1
                              ? contactInfo != null
                                  ? contact(
                                      contactInfo, privacy, widget.user[0] , view_contacts)
                                  : Container()
                              : selectedindex == 2
                                  ? familyInfo != null
                                      ? family(familyInfo)
                                      : Container()
                                  : astroinfo != null
                                      ? HoroscopeStateful(
                                          astroinfo, privacy, widget.user[0] , view_horoscope , contactInfo.whatsappNumber.toString())
                                      : Container()),
            ],
              )),
        ))));
  }




   @override
  void dispose() {
     print('Disposing of2 ${this.runtimeType}');

     super.dispose();
  }

}
