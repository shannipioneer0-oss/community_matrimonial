


import 'package:community_matrimonial/app_utils/StatefulWrapper.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/screens/user_profile/ProfileDetailItemOther.dart';
import 'package:community_matrimonial/screens/user_profile/userdetail_other/userdetailProvider.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../network_utils/model/profile_details_model.dart';
import '../../../utils/utils.dart';

class personal extends StatelessWidget{


  final BasicInfo basicinfo;
  final PhysicalInfo physicalinfo ;
  final EducationInfo educationinfo ;
  final OccupationInfo pccupinfo ;
  final VerificationInfo verificationInfo;
  final String userId;
  final String hobbies;
  
  personal(this.basicinfo, this.physicalinfo, this.educationinfo, this.pccupinfo, this.verificationInfo ,this.userId, this.hobbies);


  @override
  Widget build(BuildContext context) {

    final myState = Provider.of<UserDetailProvider>(context);

    return  StatefulWrapper(
        onInit: () async {

          Future.delayed(Duration(milliseconds: 800) , (){


            print("ViewProfile "+userId);
            myState.ViewOtherProfile(context , userId);

          });


    },
    child: SingleChildScrollView( child:Container( child:Column(children: [ Column(children: [

      Container(color: ColorsPallete.blue_2, width: MediaQuery.of(context).size.width*0.9  , margin: EdgeInsets.only(left: 8 ,right: 8 ,top: 20),padding: EdgeInsets.all(7) , child: Text("Personal Details" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white , fontSize: 15),),),
      Container(color: Colors.white , margin: EdgeInsets.only(left: 8 ,right: 8 ), width: MediaQuery.of(context).size.width*0.9 , padding: EdgeInsets.all(10) ,child:Column(children: [

        ProfileDetailItemOther(label: TranslationService.translate("name") , value: basicinfo.fullname.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("age") , value: utils().calculateAge(basicinfo.age.toString()).toString()),
        ProfileDetailItemOther(label: TranslationService.translate("marital") , value: basicinfo.maritalStatus.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("created_by") , value: basicinfo.createdBy.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("caste_detail") , value: basicinfo.caste.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("subcaste_detail") , value: basicinfo.subcaste.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("lang_known_detail") , value: basicinfo.languageKnown.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("mother_tongue_detail") , value: basicinfo.motherTongue.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("weight_detail") , value: physicalinfo.weight.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("height_detail") , value: physicalinfo.height.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("skintone_detail") , value: physicalinfo.skintone.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("bgroup_detail") , value: physicalinfo.bloodGroup.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("fitness_level_detail") , value: physicalinfo.fitness.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("body_type_detail") , value: physicalinfo.bodyType.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("diet_type_detail") , value: physicalinfo.dietType.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("drink_type_detail") , value: physicalinfo.drinkType.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("smoke_type_detail") , value: physicalinfo.smokeType.toString()),
        physicalinfo.isHandicap.toString().toLowerCase() == "yes" ? ProfileDetailItemOther(label: TranslationService.translate("is_handicap") , value: physicalinfo.isHandicap.toString()) : Container(child:ProfileDetailItemOther(label: TranslationService.translate("is_handicap") , value: "No")),
        physicalinfo.isHandicap.toString().toLowerCase() == "yes" ? ProfileDetailItemOther(label: TranslationService.translate("handicap_details_key") , value: physicalinfo.handicapDetail.toString()) : Container(),


      ],))
    ],) ,




      Column(children: [

        Container(color: ColorsPallete.blue_2, width: MediaQuery.of(context).size.width*0.9  , margin: EdgeInsets.only(left: 8 ,right: 8 ,top: 20 ,bottom: 0),padding: EdgeInsets.all(5) , child: Text("Education & Occupational Details" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white , fontSize: 15),),),
        Container(color: Colors.white ,margin: EdgeInsets.only(left: 8 ,right: 8), width: MediaQuery.of(context).size.width*0.9 , padding: EdgeInsets.all(10) ,child:Column(children: [


          educationinfo.education != null ? ProfileDetailItemOther(label: TranslationService.translate("education") , value: educationinfo.education.toString()) : Container(),
          educationinfo.education != null ? ProfileDetailItemOther(label: TranslationService.translate("educational_details") , value: educationinfo.educationDetail.toString()) : Container(),
          educationinfo.education != null && educationinfo.isFromAdminService == "1" ? ProfileDetailItemOther(label: "Administrative Service" , value: educationinfo.adminPositionName.toString()) : Container(),
          educationinfo.education != null && educationinfo.isFromIITIIMNIT == "1" ? ProfileDetailItemOther(label: "Reputed University Name" , value: educationinfo.instituteName.toString()) : Container(),

          pccupinfo.occupation != null ? Column(children: [

            ProfileDetailItemOther(label: TranslationService.translate("occupation_d") , value: pccupinfo.occupation.toString()),
            ProfileDetailItemOther(label: TranslationService.translate("occupation_detail") , value: pccupinfo.occupationDetail.toString()),
            ProfileDetailItemOther(label: TranslationService.translate("annual_income_detail") , value: pccupinfo.annualIncome.toString()),
            ProfileDetailItemOther(label: TranslationService.translate("employment_type_detail") , value: pccupinfo.employmentType.toString()),
            ProfileDetailItemOther(label: TranslationService.translate("office_address_detail") , value: pccupinfo.officeAddress.toString()),


          ],) : Container(),


        ],))
      ],),



      verificationInfo.userId != null
      ? Column(children: [

        Container(color: ColorsPallete.blue_2, width: MediaQuery.of(context).size.width*0.9  , margin: EdgeInsets.only(left: 8 ,right: 8 ,top: 20),padding: EdgeInsets.all(5) , child: Text("User Verification" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white , fontSize: 15),),),
        Container(color: Colors.white ,margin: EdgeInsets.only(left: 8 ,right: 8 , bottom: 20), width: MediaQuery.of(context).size.width*0.9 , padding: EdgeInsets.all(10) ,child:Column(children: [

          ProfileDetailItemOther(label: TranslationService.translate("verify_mobile") , value: verificationInfo.mobileVerify == "0" ? "verification Going on" :verificationInfo.mobileVerify == "1" ? "Verified" : verificationInfo.mobileVerify == "2" ? "Rejected" : ""),
          ProfileDetailItemOther(label: TranslationService.translate("verify_user") , value: verificationInfo.userVerify == "0" ?  "verification Going on" :  verificationInfo.userVerify == "1" ?  "Verified" : verificationInfo.userVerify == "2" ? "Rejected" : "" ),
          ProfileDetailItemOther(label: TranslationService.translate("verify_email") , value: verificationInfo.emailVerify == "0" ?  "verification Going on" :  verificationInfo.emailVerify == "1" ?  "Verified" : verificationInfo.emailVerify == "2" ? "Rejected" : ""),
          ProfileDetailItemOther(label: TranslationService.translate("verfiy_identity") , value: verificationInfo.isIdVerify == "0" ?  "verification Going on" :  verificationInfo.isIdVerify == "1" ?  "Verified" : verificationInfo.isIdVerify == "2" ? "Rejected" : ""),
          ProfileDetailItemOther(label: TranslationService.translate("verify_education") , value: verificationInfo.isEducationVerify == "0" ?  "verification Going on" :  verificationInfo.isEducationVerify == "1" ?  "Verified" : verificationInfo.isEducationVerify == "2" ? "Rejected" : ""),
          ProfileDetailItemOther(label: TranslationService.translate("verify_income") , value: verificationInfo.incomeProof == "0" ?  "verification Going on" :  verificationInfo.isIncomeVerify == "1" ?  "Verified" :verificationInfo.isIncomeVerify == "2" ? "Rejected" : ""),



        ],))
      ],) : Container(),

      hobbies != "" ?  Column(children: [

        Container(color: ColorsPallete.blue_2, width: MediaQuery.of(context).size.width*0.9  , margin: EdgeInsets.only(left: 8 ,right: 8 ,top: 20),padding: EdgeInsets.all(5) , child: Text("Selected Hobbies" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white , fontSize: 15),),),
        Container(color: Colors.white ,margin: EdgeInsets.only(left: 8 ,right: 8 , bottom: 20), width: MediaQuery.of(context).size.width*0.9 , padding: EdgeInsets.all(10) ,child:Column(children: [

          ProfileDetailItemOther(label: TranslationService.translate("select_hobby") , value: hobbies),

        ],))
      ],) : Container(),


    ],) )));

  }



}