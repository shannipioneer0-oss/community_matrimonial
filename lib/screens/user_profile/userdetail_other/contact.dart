


import 'package:community_matrimonial/app_utils/SendNotification.dart';
import 'package:community_matrimonial/app_utils/StatefulWrapper.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/model/profile_details_model.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/user_profile/ProfileDetailItemOther.dart';
import 'package:community_matrimonial/screens/user_profile/userdetail_other/userdetailProvider.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class contact extends StatelessWidget {

   final ContactInfo contactInfo;
   final PrivacySettings settings;
   final String userId;
   final String view_contacts;

   
   contact(this.contactInfo, this.settings, this.userId , this.view_contacts);

   String grantValue = "";


  @override
  Widget build(BuildContext context) {

    final myState = Provider.of<UserDetailProvider>(context);

    return  StatefulWrapper(
     onInit: () async {

       print(view_contacts+"------"+userId+"-----"+view_contacts.split(",").contains(userId).toString());

      await myState.allowedUserPhone(context , userId);
      grantValue = (myState.allowed_user.data!.isNotEmpty ? myState.allowed_user.data![0].isGrant : '')!;

      print(myState.num_contacts+"-----"+myState.allowed_contatcs+"-----"+grantValue);
      
     // if(myState.ispremium != "") {
        if (int.parse(myState.num_contacts) <
            int.parse(myState.allowed_contatcs)) {
          if (contactInfo != null) {
             myState.ViewOtherContacts(context, userId);
          }
        }
    //  }
      

     },
    child: myState.ispremium != "" ?

    Container( child: int.parse(myState.num_contacts) < int.parse(myState.allowed_contatcs) || view_contacts.split(",").contains(userId) ? SingleChildScrollView(child: Container(child:Column(children: [

    Container(color: ColorsPallete.blue_2, width: MediaQuery.of(context).size.width*0.9  , margin: EdgeInsets.only(left: 8 ,right: 8 ,top: 20),padding: EdgeInsets.all(7) , child: Text("Contact Details" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white , fontSize: 15),),),
    Container(color: Colors.white ,margin: EdgeInsets.only(left: 8 ,right: 8 ,bottom: 20 ), width: MediaQuery.of(context).size.width*0.9 , padding: EdgeInsets.all(10) ,child:Column(children: [


      ProfileDetailItemOtherContainer(label: TranslationService.translate("mobile_no_detail") , value:  settings.profileId == null ? Container(child:Text(contactInfo.mobileNumber.toString())) : settings.phonePrivacy == "2" && grantValue == "" ? GestureDetector(onTap: () async {

        SharedPreferences prefs = await SharedPreferences.getInstance();


        final _response2 = await Provider.of<ApiService>(context, listen: false).postInsertAlloedFromUser({
          "from_id":prefs.getString(SharedPrefs.userId),
          "to_id": userId,
          "type":"phone",
          "communityId": prefs.getString(SharedPrefs.communityId)
        });

        if(_response2.body["data"]["affectedRows"] == 1){
          await myState.allowedUserPhone(context , userId);

          grantValue = (myState.allowed_user.data!.isNotEmpty ? myState.allowed_user.data![0].isGrant : '')!;
        }

        final _response = await Provider.of<ApiService>(context, listen: false).
        postInsertNotification({
          "notifi_type":"request_call",
          "message": prefs.getString(SharedPrefs.fullname).toString()+" sent you the Mobile number / call request",
          "sender_type":"user",
          "sender_id":prefs.getString(SharedPrefs.userId),
          "reciever_id":userId,
          "communityId":prefs.getString(SharedPrefs.communityId)
        });


        SendNotification().sendWhatsapp(
          contactInfo.whatsappNumber.toString(),
          "Mobile Number / call request from " +
              prefs
                  .getString(
                  SharedPrefs.fullname)
                  .toString()+"\n"+
              "The Request is from Community Matrimonial regarding Mobile Number reveal request from " +
              prefs
                  .getString(
                  SharedPrefs.fullname)
                  .toString() +
              " Please kindly accept or reject his request by opening app and going to notification section.",
        );



      }  ,child:Container(child:Text("Request Phone Number" , style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue
        ),)) ) : grantValue == "0" ?  Text("Request Sent!" , style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blue
      ),) : Text(contactInfo.mobileNumber.toString())),
      ProfileDetailItemOtherContainer(label: TranslationService.translate("mobile_no_detail") , value:  settings.profileId == null ? Container(child:Text(contactInfo.alternateMobile.toString())) : settings.phonePrivacy == "2" && grantValue == "" ? GestureDetector(onTap: () async {

        SharedPreferences prefs = await SharedPreferences.getInstance();


        final _response2 = await Provider.of<ApiService>(context, listen: false).postInsertAlloedFromUser({
          "from_id":prefs.getString(SharedPrefs.userId),
          "to_id": userId,
          "type":"phone",
          "communityId": prefs.getString(SharedPrefs.communityId)
        });

        if(_response2.body["data"]["affectedRows"] == 1){
          await myState.allowedUserPhone(context , userId);

          grantValue = (myState.allowed_user.data!.isNotEmpty ? myState.allowed_user.data![0].isGrant : '')!;
        }

        final _response = await Provider.of<ApiService>(context, listen: false).
        postInsertNotification({
          "notifi_type":"request_call",
          "message": prefs.getString(SharedPrefs.fullname).toString()+" sent you the Mobile number / call request",
          "sender_type":"user",
          "sender_id":prefs.getString(SharedPrefs.userId),
          "reciever_id":userId,
          "communityId":prefs.getString(SharedPrefs.communityId)
        });


        SendNotification().sendWhatsapp(
          contactInfo.whatsappNumber.toString(),
          "Mobile Number / call request from " +
              prefs
                  .getString(
                  SharedPrefs.fullname)
                  .toString()+"\n"+
              "The Request is from Community Matrimonial regarding Mobile Number reveal request from " +
              prefs
                  .getString(
                  SharedPrefs.fullname)
                  .toString() +
              " Please kindly accept or reject his request by opening app and going to notification section.",
        );


      }  ,child:Container(child:Text("Request Phone Number" , style: TextStyle(
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          color: Colors.blue
      ),)) ) : grantValue == "0" ?  Text("Request Sent!" , style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue
      ),) : Text(contactInfo.alternateMobile.toString())),
      ProfileDetailItemOther(label: TranslationService.translate("emailid_detail") , value: contactInfo.emailid.toString()),
      ProfileDetailItemOther(label: TranslationService.translate("alt_emailid_detail") , value: contactInfo.alternateEmail.toString()),
      ProfileDetailItemOther(label: TranslationService.translate("country") , value: contactInfo.permCountry.toString()),
      ProfileDetailItemOther(label: TranslationService.translate("perm_state") , value: contactInfo.permState.toString()),
      ProfileDetailItemOther(label: TranslationService.translate("perm_city") , value: contactInfo.permCity.toString()),
      ProfileDetailItemOther(label: TranslationService.translate("permanent_address") , value: contactInfo.permanentAddress.toString()),
      ProfileDetailItemOther(label: TranslationService.translate("work_country") , value: contactInfo.workCountry.toString()),
      ProfileDetailItemOther(label: TranslationService.translate("work_state_details") , value: contactInfo.workState.toString()),
      ProfileDetailItemOther(label: TranslationService.translate("work_city_details") , value: contactInfo.workCity.toString()),
      ProfileDetailItemOther(label: TranslationService.translate("work_address_details") , value: contactInfo.workingAddress.toString()),
      ProfileDetailItemOther(label: TranslationService.translate("contact_time_details") , value: contactInfo.contactTime.toString()),




    ]))



    ]))):  Container(margin: EdgeInsets.only(left: 15 ,right: 15)  ,height:MediaQuery.of(context).size.height*0.5 , child:Center(child:Text("You have Reached the Limit of your Plan to Access Contacts , Please upgrade to access more contacts" ,textAlign: TextAlign.center , style: TextStyle(fontWeight: FontWeight.bold , color: ColorsPallete.Pink2 , fontSize: 18),)))):  Container(margin: EdgeInsets.only(left: 15 , right: 15)   ,height:MediaQuery.of(context).size.height*0.5  ,child:Center(child:Text("Access to Contacts needs the Premium user only" ,textAlign: TextAlign.center , style: TextStyle(fontWeight: FontWeight.bold , color: ColorsPallete.Pink2 , fontSize: 18),))));

  }

}