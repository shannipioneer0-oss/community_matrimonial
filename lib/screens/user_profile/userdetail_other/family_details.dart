



import 'package:community_matrimonial/network_utils/model/profile_details_model.dart';
import 'package:community_matrimonial/screens/user_profile/ProfileDetailItemOther.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../locale/TranslationService.dart';

class family extends StatelessWidget {

  final FamilyInfo familyinfo;
  family(this.familyinfo);

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(child: Container(child:Column(children: [

      Container(color: ColorsPallete.blue_2, width: MediaQuery.of(context).size.width*0.9  , margin: EdgeInsets.only(left: 8 ,right: 8 ,top: 20),padding: EdgeInsets.all(7) , child: Text("Family Details" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white , fontSize: 15),),),
      Container(color: Colors.white ,margin: EdgeInsets.only(left: 8 ,right: 8 ,bottom: 20 ), width: MediaQuery.of(context).size.width*0.9 , padding: EdgeInsets.all(10) ,child:Column(children: [



        ProfileDetailItemOther(label: TranslationService.translate("family_values") , value: familyinfo.familyValue != null ? familyinfo.familyValue.toString() : ""),
        ProfileDetailItemOther(label: TranslationService.translate("family_status") , value: familyinfo.familyStatus != null ? familyinfo.familyStatus.toString() : ""),
        ProfileDetailItemOther(label: TranslationService.translate("family_type") , value:  familyinfo.familyType != null ? familyinfo.familyType.toString() : ""),
        ProfileDetailItemOther(label: TranslationService.translate("no_brother_details") , value: familyinfo.noBrother != null ? familyinfo.noBrother.toString() : ""),
        ProfileDetailItemOther(label: TranslationService.translate("no_sister_details") , value: familyinfo.noSister != null ? familyinfo.noSister.toString() : ""),
        ProfileDetailItemOther(label: TranslationService.translate("no_married_brother") , value:familyinfo.marriedBrother != null ? familyinfo.marriedBrother.toString() : ""),
        ProfileDetailItemOther(label: TranslationService.translate("no_marrried_sister") , value: familyinfo.marriedSister != null ? familyinfo.marriedSister.toString() : ""),
        ProfileDetailItemOther(label: TranslationService.translate("father_name") , value: familyinfo.fatherName != null ? familyinfo.fatherName.toString() : ""),
        ProfileDetailItemOther(label: TranslationService.translate("mother_name") , value: familyinfo.motherName != null ? familyinfo.motherName.toString() : ""),
        ProfileDetailItemOther(label: TranslationService.translate("father_occupation") , value: familyinfo.fatherOccupation != null ? familyinfo.fatherOccupation.toString() : ""),
        ProfileDetailItemOther(label: TranslationService.translate("mother_occupation") , value: familyinfo.motherOccupation != null ?  familyinfo.motherOccupation.toString() : ""),
        ProfileDetailItemOther(label: TranslationService.translate("house_owned_details") , value: familyinfo.houseOwned != null ?  familyinfo.houseOwned.toString() : ""),
        ProfileDetailItemOther(label: TranslationService.translate("house_type_details") , value:familyinfo.houseType != null ?  familyinfo.houseType.toString() : ""),
        ProfileDetailItemOther(label: TranslationService.translate("will_stay_or_not") , value: familyinfo.parentsStayOptions != null ? familyinfo.parentsStayOptions.toString() : ""),
        ProfileDetailItemOther(label: TranslationService.translate("family_slogan_details") , value: familyinfo.detailFamily != null ?  familyinfo.detailFamily.toString() : ""),


      ]))



    ])));

  }

}