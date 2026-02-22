import 'package:community_matrimonial/app_utils/SendNotification.dart';
import 'package:community_matrimonial/app_utils/StatefulWrapper.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/model/profile_details_model.dart';
import 'package:community_matrimonial/screens/chat/HoroscopeDataStore.dart';
import 'package:community_matrimonial/screens/chat/models/horoscope.dart';
import 'package:community_matrimonial/screens/user_profile/FancyBorderDashedImage.dart';
import 'package:community_matrimonial/screens/user_profile/ProfileDetailItemOther.dart';
import 'package:community_matrimonial/screens/user_profile/userdetail_other/userdetailProvider.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../network_utils/service/api_service.dart';


class HoroscopeStateful extends StatefulWidget {

  final AstroInfo astroinfo;
  final PrivacySettings settings;
  final String userId;
  final String view_horoscope;
  final String whatsappnumber;

  HoroscopeStateful(this.astroinfo, this.settings, this.userId , this.view_horoscope , this.whatsappnumber);

  @override
  horoscope createState() => horoscope();

}


class horoscope extends State<HoroscopeStateful>{

  String grantValue  = "";

  HoroscopeDataStore datastore = HoroscopeDataStore();

  @override
  void initState() {
    super.initState();

   // HoroscopeDataStore.box.clear();

    initHoroscope();

  }

  initHoroscope() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

   List<Horoscope> horoscope = HoroscopeDataStore.box.values.toList().where((element) => element.myId == prefs.getString(SharedPrefs.userId) && element.otheruserId == widget.userId).toList();

   // HoroscopeDataStore.box.clear();
   print(horoscope.length.toString());

   if(horoscope.length == 0) {

     initbirthchart();
     Future.delayed(Duration(milliseconds: 300));
     initGunmilanScore();

   }else{

     setState(() {

       svg = horoscope[0].birth_chart;
       gunmilan_score = horoscope[0].gunmilan;

       print(svg);
       print(gunmilan_score);

     });

   }



  }


  String svg = "";
  initbirthchart() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();


    String dob = prefs.getString(SharedPrefs.birthDate).toString();
    String tob = prefs.getString(SharedPrefs.birthTime).toString();

    String  date = "" , month = "" , year = "";
    if(dob.split("/")[0].length == 1){
      date =  "0"+dob.split("/")[0];
    }else{
      date = dob.split("/")[0];
    }

    if(dob.split("/")[1].length == 1){
      month =  "0"+dob.split("/")[1];
    }else{
      month = dob.split("/")[1];
    }

    year = dob.split("/")[2];

    String hour = "" ,minute =  "";

    if(tob.split(":")[0].length == 1){
      hour = "0"+tob.split(":")[0];
    }else{
      hour = tob.split(":")[0];
    }


    if(tob.split(":")[1].length == 1){
      minute = "0"+tob.split(":")[1];
    }else{
      minute = tob.split(":")[1];
    }

    print(prefs.getString(SharedPrefs.locationCoordinates).toString());

    final _response = await Provider.of<ApiService>(context, listen: false).
    postBirthChart({
      "dob":date+"/"+month+"/"+year,
      "tob": hour+":"+minute,
      "tz": prefs.getString(SharedPrefs.timezone).toString(),
      "lat": prefs.getString(SharedPrefs.locationCoordinates).toString().split(",")[0],
      "lon": prefs.getString(SharedPrefs.locationCoordinates).toString().split(",")[1]
    });


    print(_response.body.toString().toString()+"[]{}");

   setState(() {
     if(_response.body["data"]["status"].toString() != "402") {
       svg = _response.body["data"];
     }else{
       svg = "";
     }
   });



  }

  String gunmilan_score = "No Data";
  initGunmilanScore() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();

    String boy_dob = "" , boy_tob = "" , boy_tz = "" , boy_lat = "" , boy_lon = "";
    String girl_dob = "" , girl_tob = "" , girl_tz = "" , girl_lat = "" , girl_lon = "";

    print(prefs.getString(SharedPrefs.gender).toString());

    if(prefs.getString(SharedPrefs.gender).toString().toLowerCase() == "male"){

      String dob = prefs.getString(SharedPrefs.birthDate).toString();
      String tob = prefs.getString(SharedPrefs.birthTime).toString();

       String  date = "" , month = "" , year = "";
      if(dob.split("/")[0].length == 1){
        date =  "0"+dob.split("/")[0];
      }else{
        date = dob.split("/")[0];
      }

      if(dob.split("/")[1].length == 1){
          month =  "0"+dob.split("/")[1];
      }else{
          month = dob.split("/")[1];
      }

      year = dob.split("/")[2];

      String hour = "" ,minute =  "";

      if(tob.split(":")[0].length == 1){
          hour = "0"+tob.split(":")[0];
      }else{
          hour = tob.split(":")[0];
      }


      if(tob.split(":")[1].length == 1){
        minute = "0"+tob.split(":")[1];
      }else{
        minute = tob.split(":")[1];
      }


      boy_dob =  date+"/"+month+"/"+year;
      boy_tob =  hour+":"+minute;
      boy_tz =  prefs.getString(SharedPrefs.timezone).toString();
      boy_lat =  prefs.getString(SharedPrefs.locationCoordinates).toString().split(",")[0];
      boy_lon =  prefs.getString(SharedPrefs.locationCoordinates).toString().split(",")[1];


      girl_dob = widget.astroinfo.birthDate.toString();
      girl_tob = widget.astroinfo.birthTime.toString().split(":")[0]+":"+widget.astroinfo.birthTime.toString().split(":")[1];
      girl_tz = widget.astroinfo.timezone.toString();
      girl_lat = widget.astroinfo.birthLocation.toString().split(",")[0];
      girl_lon = widget.astroinfo.birthLocation.toString().split(",")[1];

    }



    if(prefs.getString(SharedPrefs.gender).toString().toLowerCase() == "female"){



      String dob = prefs.getString(SharedPrefs.birthDate).toString();
      String tob = prefs.getString(SharedPrefs.birthTime).toString();

      String  date = "" , month = "" , year = "";
      if(dob.split("/")[0].length == 1){
        date =  "0"+dob.split("/")[0];
      }else{
        date = dob.split("/")[0];
      }

      if(dob.split("/")[1].length == 1){
        month =  "0"+dob.split("/")[1];
      }else{
        month = dob.split("/")[1];
      }

      year = dob.split("/")[2];

      String hour = "" ,minute =  "";

      if(tob.split(":")[0].length == 1){
        hour = "0"+tob.split(":")[0];
      }else{
        hour = tob.split(":")[0];
      }


      if(tob.split(":")[1].length == 1){
        minute = "0"+tob.split(":")[1];
      }else{
        minute = tob.split(":")[1];
      }


      girl_dob =  date+"/"+month+"/"+year;
      girl_tob =   hour+":"+minute;
      girl_tz =  prefs.getString(SharedPrefs.timezone).toString();
      girl_lat =  prefs.getString(SharedPrefs.locationCoordinates).toString().split(",")[0];
      girl_lon =  prefs.getString(SharedPrefs.locationCoordinates).toString().split(",")[1];


      boy_dob = widget.astroinfo.birthDate.toString();
      boy_tob = widget.astroinfo.birthTime.toString().split(":")[0]+":"+widget.astroinfo.birthTime.toString().split(":")[1];
      boy_tz = widget.astroinfo.timezone.toString();
      boy_lat = widget.astroinfo.birthLocation.toString().split(",")[0];
      boy_lon = widget.astroinfo.birthLocation.toString().split(",")[1];

    }



    final _response = await Provider.of<ApiService>(context, listen: false).postMatchScore({
      "boy_dob":boy_dob,
      "boy_tob": boy_tob,
      "boy_tz": boy_tz,
      "boy_lat": boy_lat,
      "boy_lon": boy_lon ,
      "girl_dob": girl_dob,
      "girl_tob": girl_tob,
      "girl_tz": girl_tz,
      "girl_lat": girl_lat,
      "girl_lon": girl_lon
    });

    print({
      "boy_dob":boy_dob,
      "boy_tob": boy_tob,
      "boy_tz": boy_tz,
      "boy_lat": boy_lat,
      "boy_lon": boy_lon ,
      "girl_dob": girl_dob,
      "girl_tob": girl_tob,
      "girl_tz": girl_tz,
      "girl_lat": girl_lat,
      "girl_lon": girl_lon
    });


    print(_response.body);

    setState(() {
      if(_response.body["data"]["status"] ==  200){
         gunmilan_score = _response.body["data"]["response"]["score"].toString();
      }else {
         gunmilan_score =  "No Data";
      }

      print(gunmilan_score+"======");

      datastore.addMessage(horoscope: Horoscope(Id: int.parse(prefs.getString(SharedPrefs.userId).toString()) , myId: prefs.getString(SharedPrefs.userId).toString(), otheruserId:  widget.userId, birth_chart: svg, gunmilan: gunmilan_score));

    });

  }
  
  bool isvalidsvg(String svg){
    
    try{
      SvgPicture.string(svg);
      
      return true;
    }catch(e){
      return false;
    }
    
  }

  @override
  Widget build(BuildContext context) {

    final myState = Provider.of<UserDetailProvider>(context);

    return  StatefulWrapper(
        onInit: () async {

          await myState.allowedUserHoroscope(context , widget.userId);
          grantValue = (myState.allowed_user_horoscope.data!.isNotEmpty ? myState.allowed_user_horoscope.data![0].isGrant : '')!;

          if(myState.ispremium_horoscope != "") {
            if (int.parse(myState.num_horoscope) <
                int.parse(myState.allowed_horoscope)) {
              if (widget.astroinfo != null) {
                myState.ViewOtherHoroscope(context, widget.userId);
              }
            }
          }


    },
    child:  Container( child: GestureDetector(onTap: () async {

      SharedPreferences prefs = await SharedPreferences.getInstance();

      final _response2 = await Provider.of<ApiService>(context, listen: false).postInsertAlloedFromUser({
        "from_id":prefs.getString(SharedPrefs.userId),
        "to_id": widget.userId,
        "type":"horoscope",
        "communityId": prefs.getString(SharedPrefs.communityId)
      });

      if(_response2.body["data"]["affectedRows"] == 1){
        await myState.allowedUserHoroscope(context , widget.userId);

        grantValue = (myState.allowed_user_horoscope.data!.isNotEmpty ? myState.allowed_user_horoscope.data![0].isGrant : '')!;
      }

      final _response = await Provider.of<ApiService>(context, listen: false).
      postInsertNotification({
        "notifi_type":"request_horoscope",
        "message": prefs.getString(SharedPrefs.fullname).toString()+" sent you the Mobile number / call request",
        "sender_type":"user",
        "sender_id":prefs.getString(SharedPrefs.userId),
        "reciever_id":widget.userId,
        "communityId":prefs.getString(SharedPrefs.communityId)
      });


      SendNotification().sendWhatsapp(
        widget.whatsappnumber,
        "Horoscope request from " +
            prefs
                .getString(
                SharedPrefs.fullname)
                .toString()+"\n"+
            "The Request is from Community Matrimonial regarding Horoscope reveal request from " +
            prefs
                .getString(
                SharedPrefs.fullname)
                .toString() +
            " Please kindly accept or reject his request by opening app and going to notification section.",
      );




    }  ,child: HoroscopeContainer() )));

  }



  Widget HoroscopeContainer(){


    return Container(child:SingleChildScrollView(child: Container(child:Column(children: [

      Container(color: ColorsPallete.blue_2, width: MediaQuery.of(context).size.width*0.9  , margin: EdgeInsets.only(left: 8 ,right: 8 ,top: 20),padding: EdgeInsets.all(7) , child: Text("Horoscope Details" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white , fontSize: 15),),),
      Container(color: Colors.white ,margin: EdgeInsets.only(left: 8 ,right: 8 ,bottom: 20 ), width: MediaQuery.of(context).size.width*0.9 , padding: EdgeInsets.all(10) ,child:Column(children: [


        ProfileDetailItemOther(label: TranslationService.translate("birth_date") , value: widget.astroinfo.birthDate.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("birth_time") , value: widget.astroinfo.birthTime.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("birth_place") , value: widget.astroinfo.birthPlace.toString()),
        ProfileDetailItemOther(label: TranslationService.translate("gotra_details") , value: widget.astroinfo.gotra.toString()),
        /*ProfileDetailItemOther(label: TranslationService.translate("mangalik") , value: widget.astroinfo.isMangalik.toString() == "0" ? "Non Mangalik" : "Mangalik"),
        ProfileDetailItemOther(label: TranslationService.translate("believe_in_horoscope") , value: widget.astroinfo.believeHoroscope.toString()),*/

        Container(width: MediaQuery.of(context).size.width , margin: EdgeInsets.only(bottom: 10)  ,child:Text("Birth Chart" , textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),),),
        Center(
          child: Container( width: MediaQuery.of(context).size.width *0.9 , height: MediaQuery.of(context).size.width *0.9 ,child: gunmilan_score != "No Data" ? SvgPicture.string(svg) : Container()),),
        Container(width: MediaQuery.of(context).size.width , margin: EdgeInsets.only(top:30 , bottom: 20)  ,child:Text("Gunmilan Score" , textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),),
        CircularPercentIndicator(
          radius: 80.0,
          animation: true,
          animationDuration: 1200,
          lineWidth: 20.0,
          percent: 0.75,
          center: new Text(
            gunmilan_score+"/36",
            style:
            new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          circularStrokeCap: CircularStrokeCap.butt,
          backgroundColor: Colors.grey,
          progressColor: Colors.red,
        ),

      ]))



    ]))));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    svg = "";
  }

}