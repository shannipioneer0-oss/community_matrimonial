




import 'package:community_matrimonial/network_utils/model/profile_details_model.dart';
import 'package:community_matrimonial/screens/filter/CircleWithNumber.dart';
import 'package:community_matrimonial/screens/user_details/InclinedPhoto.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_utils/Dialogs.dart';

class MatchProfile extends StatelessWidget {

  final List list_match;
  MatchProfile(this.list_match);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MatchProfileStateful(list_match),
    );
  }

}


class MatchProfileStateful extends StatefulWidget {

  final List list_match;
  MatchProfileStateful(this.list_match);

  @override
  MatchProfileScreen createState() => MatchProfileScreen();

}

class MatchProfileScreen  extends State<MatchProfileStateful>{

  @override
  void initState() {
    super.initState();

    _checkConnectivity();

    initMatchProfile();

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


  String name1= "" ,name2 = "";
  String pic1 = "" , pic2 = "" , marital_status = "" , height = "" , caste = "", subcaste = "" , state = "" ,city = "";
  String education = "" , occupation = "", fml_ype = "" , diet_type = "" ,skintone = "" ,body_type = "" ;
  String drink_type = "" ,smoke_type = "" , annual_income = "";

  String  marital_status_prefer = "" , height_prefer = "" , caste_prefer = "", subcaste_prefer = "" , state_prefer = "" ,city_prefer = "";
  String education_prefer = "" , occupation_prefer = "", fml_ype_prefer = "" , diet_type_prefer = "" ,skintone_prefer = "" ,body_type_prefer = "" ;
  String drink_type_prefer = "" ,smoke_type_prefer = "" , annual_income_prefer = "";

  bool marital_bool = false , height_bool = false , caste_bool = false, subcaste_bool = false , state_bool = false;
  bool city_bool = false ,edu_bool = false , ocup_bool = false , fml_bool = false , diet_type_bool = false , skintone_bool = false ;
  bool body_bool = false , drink_bool = false , smoke_bool =  false , annual_bool = false;

  int count =0 , percentage = 0;

  initMatchProfile() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    BasicInfo basciinfo = widget.list_match[0] as BasicInfo;
    ContactInfo contsactinfo = widget.list_match[1] as ContactInfo;
    PhysicalInfo physic_info = widget.list_match[2] as PhysicalInfo;
    EducationInfo eduinfo = widget.list_match[3] as EducationInfo;
     OccupationInfo ocupinfo = widget.list_match[4] as OccupationInfo;
    FamilyInfo fmlinfo = widget.list_match[5] as FamilyInfo;

    PhotoInfo photoinfo =  widget.list_match[6] as PhotoInfo;

    print(physic_info.height.toString());
    print(marital_status_prefer == marital_status +"_____________");

      setState(() {

        name1 =  prefs.getString(SharedPrefs.fullname).toString();
        name2 = basciinfo.fullname.toString();
        

      pic1 = Strings.IMAGE_BASE_URL+"/uploads/matrimonial_photo/Matrimonial_Photo/"+prefs.getString(SharedPrefs.pic1).toString();
      pic2 = Strings.IMAGE_BASE_URL+"/uploads/matrimonial_photo/Matrimonial_Photo/"+photoinfo.pic1.toString();

      marital_status = basciinfo.maritalStatus.toString();
      marital_status_prefer = prefs.getString(SharedPrefs.maritalStatus_prefs).toString().split("*")[0];

      height = physic_info.height.toString();
      height_prefer = prefs.getString(SharedPrefs.heightRange).toString();

      caste = basciinfo.caste.toString();
      caste_prefer = prefs.getString(SharedPrefs.caste_prefs).toString();

      subcaste = basciinfo.subcaste.toString();
      subcaste_prefer = prefs.getString(SharedPrefs.subcaste_prefs).toString();

      state = contsactinfo.permState.toString();
      state_prefer = prefs.getString(SharedPrefs.state_prefs).toString().split("*")[0];

      city = contsactinfo.permCity.toString();
      city_prefer = prefs.getString(SharedPrefs.city_prefs).toString().split("*")[0];

      education = eduinfo.education.toString();
      education_prefer = prefs.getString(SharedPrefs.education_prefs).toString().split("*")[0];

      occupation = ocupinfo.occupation.toString();
      occupation_prefer = prefs.getString(SharedPrefs.occupation_prefs).toString().split("*")[0];

      fml_ype = fmlinfo.familyValue.toString();
      fml_ype_prefer = prefs.getString(SharedPrefs.familyValue_prefs).toString().split("*")[0];

      diet_type = physic_info.dietType.toString();
      diet_type_prefer = prefs.getString(SharedPrefs.dietType_prefs).toString().split("*")[0];

      skintone = physic_info.skintone.toString();
      skintone_prefer = prefs.getString(SharedPrefs.skintoneprefs).toString().split("*")[0];

      body_type = physic_info.bodyType.toString();
      body_type_prefer = prefs.getString(SharedPrefs.bodyType_prefs).toString().split("*")[0];

      drink_type = physic_info.drinkType.toString();
      drink_type_prefer = prefs.getString(SharedPrefs.drinkType_prefs).toString().split("*")[0];

      smoke_type = physic_info.smokeType.toString();
      smoke_type_prefer = prefs.getString(SharedPrefs.smokeType_prefs).toString().split("*")[0];

      annual_income = ocupinfo.annualIncome.toString();
      annual_income_prefer = prefs.getString(SharedPrefs.annualIncome_prefs).toString();

      int fromfeet = height_prefer != "null" ?  int.parse(extractDigits(height_prefer.split("-")[0].split(" ")[0]))*12 : 0;
      int from_inch = height_prefer != "null" ? int.parse(extractDigits(height_prefer.split("-")[0].split(" ")[1])) : 0;

        int tofeet =  height_prefer != "null" ? int.parse(extractDigits(height_prefer.split("-")[1].split(" ")[0]))*12 : 0;
        int to_inch = height_prefer != "null" ? int.parse(extractDigits(height_prefer.split("-")[1].split(" ")[1])) : 0;

        int givenfeet = height != "null" ? int.parse(extractDigits(height.split(" ")[0]))*12 : 0;
        int giveninch = height != "null" ? int.parse(extractDigits(height.split(" ")[1])): 0;

        int fromheight = fromfeet + from_inch;
        int toheight = tofeet + to_inch;
        int given =   givenfeet + giveninch;

        print(annual_income_prefer+"____"+annual_income);

       /* int fromannual_income = annual_income_prefer != "null" && annual_income_prefer != "Any" &&  annual_income_prefer.isNotEmpty ? int.parse(annual_income_prefer) : 0;
        int toannual_income = annual_income_prefer != "null" && annual_income_prefer != "Any"  &&  annual_income_prefer.isNotEmpty ? int.parse(annual_income_prefer) : 0;
        int given_annualincome = annual_income != "null" && annual_income != "" ? int.parse(annual_income) : 0;*/



        marital_status_prefer == marital_status  ? marital_bool = true : false;

        print(marital_status_prefer +"----"+ marital_status);
        given > fromheight && given < toheight == true ? height_bool = true : false;
        (caste_prefer == "Any" && caste != "null") || caste_prefer.contains(caste) == true ? caste_bool = true : false;
        (subcaste_prefer == "Any" && subcaste != "null") || subcaste_prefer.contains(subcaste) == true ? subcaste_bool = true : false;
        (state_prefer == "Any" && state != "null") || state_prefer.contains(state) == true ? state_bool = true : false;
        (city_prefer == "Any" && city != "null") || city_prefer.contains(city) == true ? city_bool = true : false;
        (education_prefer == "Any" && education != "null") ||  education_prefer.contains(education) == true ? edu_bool = true : false;
        (occupation_prefer == "Any" && occupation != "null") ||  occupation_prefer.contains(occupation) == true ? ocup_bool = true : false;
        (fml_ype_prefer == "Any" && fml_ype != "null") || fml_ype_prefer.contains(fml_ype) == true ? fml_bool = true : false;
        (diet_type_prefer == "Any" && diet_type != "null") ||  diet_type_prefer.contains(diet_type) == true ? diet_type_bool = true : false;

        (skintone_prefer == "Any" && skintone != "null") ||  skintone_prefer.contains(skintone) == true ? skintone_bool = true : false;
        (body_type_prefer == "Any" && body_type != "null") || body_type_prefer.contains(body_type) == true ? body_bool = true : false;
        (drink_type_prefer == "Any" && drink_type != "null") || drink_type_prefer.contains(drink_type) == true ? drink_bool = true : false;
        (smoke_type_prefer == "Any" && smoke_type != "null") ||  smoke_type_prefer.contains(smoke_type) == true ? smoke_bool = true : false;
        (annual_income_prefer == "Any" && annual_income != "null") ||  annual_income_prefer == annual_income || annual_income_prefer.contains(annual_income) ? annual_bool = true : false;

        print(caste_bool.toString()+"[][][][]");

      marital_bool == true ? count++ : count;
      height_bool == true ? count++ : count;
      caste_bool  == true ? count++ : count;
      subcaste_bool == true ? count++ : count;
      state_bool == true ? count++ : count;
      city_bool == true ? count++ : count;
      edu_bool == true ? count++ : count;
      ocup_bool == true ? count++ : count;
      fml_bool == true ? count++ : count;
      diet_type_bool == true ? count++ : count;
      skintone_bool == true ? count++ : count;
      body_bool == true ? count++ : count;
      drink_bool == true ? count++ : count;
      smoke_bool == true ? count++ : count;
      annual_bool == true ? count++ : count;

      print(count.toString()+" count---------");

      percentage = ((count * 100)/15).toInt() ;


      });


  }



  String extractDigits(String input) {
    StringBuffer result = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      if (input[i].contains(RegExp(r'\d'))) {
        result.write(input[i]);
      }
    }
    return result.toString();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(
    title: Text('Match Details' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
    toolbarOpacity: 1,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: IconButton(
    icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
    onPressed: () {

      navService.goBack();

    },
    )),
    body: SingleChildScrollView(child:Container(constraints: BoxConstraints(maxWidth:double.infinity , maxHeight: double.infinity)   ,color: ColorsPallete.grey_light_2  ,margin: EdgeInsets.only(top: 20),

      child: Column(children: [

       Stack(  children: [ Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           InclinedPhoto(imagePath: pic1, degree: -10,),
           SizedBox(width: 20.0), // Adjust spacing between photos
           InclinedPhoto(imagePath: pic2, degree: 10,),
         ],
       ), Positioned(left: MediaQuery.of(context).size.width*0.39 , bottom: 0   ,child: Image.asset("assets/images/heart_awesome.png" , width: 80, height: 80, color: ColorsPallete.Pink_light,)),
         Positioned(left: MediaQuery.of(context).size.width*0.47 , bottom: 25   ,child: Text( percentage.toString()+"%" , style: TextStyle(color: Colors.white , fontSize: 16 , fontWeight: FontWeight.bold),))
       ],),

       Container(margin: EdgeInsets.only(top: 5 ,right: 40), width: MediaQuery.of(context).size.width  ,child:Row( mainAxisAlignment: MainAxisAlignment.center ,children: [
          InclinedText(text: name1, degree: -10,),
          SizedBox(width: 10.0), // Adjust spacing between photos
          InclinedText(text: name2, degree: 10,),
        ],),),

        Container(
          margin: EdgeInsets.only(top: 30),
          width: MediaQuery.of(context).size.width*0.9,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            image: DecorationImage(
              image: AssetImage('assets/images/input.png'), // Replace with your image path
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius
          ),
          child:Column(mainAxisAlignment: MainAxisAlignment.center ,children: [

            Center(
              child: Text(
                'Matching Results',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
              SizedBox(height: 5,),
            Center(
              child: Text(
                'Your Preference Vs Profile Data',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),


          ],)
        ),

        SizedBox(height: 30,),
        Container(margin: EdgeInsets.only(left: 15 , right: 15 ,bottom: 20) ,child:Column(

          children: [

            Container(child:Row(children: [ CircleWithNumber(number: "01") , const SizedBox(width: 15,) , Text("Marital Status", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


              Image.asset("assets/images/path.png" , height: 60,) , SizedBox(width: 30,) ,Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [

                Column(children: [

                  Text(marital_status_prefer, style: TextStyle(fontSize: 15),),
              Container(child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
              Text(marital_status, style: TextStyle(fontSize: 15),),

              ],),

                    SizedBox(width: 20,),
                    Container(margin: EdgeInsets.only(left: 20) ,child:Image.asset( marital_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png" , width: 25, height: 25,)),

                  ],
                ),
              ),
            ],),),


            Container(child:Row(children: [ CircleWithNumber(number: "02") , const SizedBox(width: 15,) , Text("Height Range", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


              Image.asset("assets/images/path_two.png" , height: 80,) , SizedBox(width: 20,) ,Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center ,children: [


                  Column(
                    children: [

                      Text(height_prefer , style: TextStyle(fontSize: 15),),
                      Container(child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                      Text(height , style: TextStyle(fontSize: 15),),

                    ],
                  ),
                  SizedBox(width: 20,),
                  Container(margin: EdgeInsets.only(left: 20) ,child:Image.asset(height_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png" , width: 25, height: 25, )),


                ],)
              ),
            ],),),

            Container(child:Row(children: [ CircleWithNumber(number: "03") , const SizedBox(width: 15,) , Text("Caste", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


              Image.asset("assets/images/path.png" , height: 90,) , SizedBox(width: 30,) ,Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [

                    Column(children: [
                      Container(width: MediaQuery.of(context).size.width*0.5  ,child: Text(caste_prefer , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                      Container(width: MediaQuery.of(context).size.width*0.5  ,child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                      Container(width: MediaQuery.of(context).size.width*0.5  ,child: Text(caste , style: TextStyle(fontSize: 15),),)
                    ],),

                    Container(margin: EdgeInsets.only(left: 0) ,child:Image.asset(caste_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png" , width: 25, height: 25, )),

                  ],
                ),
              ),
            ],),),

            Container(child:Row(children: [ CircleWithNumber(number: "04") , const SizedBox(width: 15,) , Text("Subcaste", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


              Image.asset("assets/images/path_two.png" , height: 80,) , SizedBox(width: 30,) ,Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                ),
                child: Row( children: [

                  Column(
                    children: [

                Container(width: MediaQuery.of(context).size.width*0.5  ,child:Text(subcaste_prefer, style: TextStyle(fontSize: 15),),),
                      Container(child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                      Text(subcaste, style: TextStyle(fontSize: 15),),


                    ],
                  ),

                  Container(margin: EdgeInsets.only(left: 20) ,child:Image.asset(subcaste_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png" , width: 25, height: 25, )),

                ], )
              ),
            ],),),

            Container(child:Row(children: [ CircleWithNumber(number: "05") , const SizedBox(width: 15,) , Text("State", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [

              Image.asset("assets/images/path.png" , height: 90,) , SizedBox(width: 20,) ,Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                  child: Row(children: [



                   Expanded(flex: 4 ,child:Column(
                      children: [

                        Text(state_prefer, style: TextStyle(fontSize: 14),),
                        Container(child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                        Text(state, style: TextStyle(fontSize: 15),),

                      ],
                    ),),

                    Expanded(flex: 1  ,child:Container(margin: EdgeInsets.only(left: 20) ,child:Image.asset(state_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png", width: 25, height: 25, ))),


                  ],)
              ),
            ],),),

            Container(child:Row(children: [ CircleWithNumber(number: "06") , const SizedBox(width: 15,) , Text("City", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


              Image.asset("assets/images/path_two.png" , height: 90,) , SizedBox(width: 20,) ,Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                  child: Row(children: [



                    Expanded(flex: 4 ,child:Column(
                      children: [

                        Text(city_prefer, style: TextStyle(fontSize: 14),),
                        Container(child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                        Text(city , style: TextStyle(fontSize: 15),),

                      ],
                    ),),

                    Expanded(flex: 1  ,child:Container(margin: EdgeInsets.only(left: 20) ,child:Image.asset(city_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png", width: 25, height: 25 , ))),


                  ],)
              ),
            ],),),


            Container(child:Row(children: [ CircleWithNumber(number: "07") , const SizedBox(width: 15,) , Text("Education", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


              Image.asset("assets/images/path.png" , height: 80,) , SizedBox(width: 20,) ,Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                  child: Row(children: [



                    Expanded(flex: 4 ,child:Column(
                      children: [

                        Text(education_prefer , style: TextStyle(fontSize: 14),),
                        Container(child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                        Text(education ,  style: TextStyle(fontSize: 15),),

                      ],
                    ),),

                    Expanded(flex: 1  ,child:Container(margin: EdgeInsets.only(left: 20) ,child:Image.asset(edu_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png" , width: 25, height: 25 , ))),


                  ],)
              ),
            ],),),

            Container(child:Row(children: [ CircleWithNumber(number: "08") , const SizedBox(width: 15,) , Text("Occupation", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


              Image.asset("assets/images/path_two.png" , height: 80,) , SizedBox(width: 20,) ,Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                  child: Row(children: [



                    Expanded(flex: 4 ,child:Column(
                      children: [

                        Text(occupation_prefer, style: TextStyle(fontSize: 14),),
                        Container(child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                        Text(occupation , style: TextStyle(fontSize: 15),),

                      ],
                    ),),

                    Expanded(flex: 1  ,child:Container(margin: EdgeInsets.only(left: 20) ,child:Image.asset(ocup_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png" , width: 25, height: 25 , ))),


                  ],)
              ),
            ],),),

            Container(child:Row(children: [ CircleWithNumber(number: "09") , const SizedBox(width: 15,) , Text("Family Value", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


              Image.asset("assets/images/path.png" , height: 80,) , SizedBox(width: 20,) ,Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                  child: Row(children: [



                    Expanded(flex: 4 ,child:Column(
                      children: [

                        Text(fml_ype_prefer, style: TextStyle(fontSize: 14),),
                        Container(child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                        Text(fml_ype, style: TextStyle(fontSize: 15),),

                      ],
                    ),),

                    Expanded(flex: 1  ,child:Container(margin: EdgeInsets.only(left: 20) ,child:Image.asset(fml_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png", width: 25, height: 25 , ))),


                  ],)
              ),
            ],),),

            Container(child:Row(children: [ CircleWithNumber(number: "10") , const SizedBox(width: 15,) , Text("Diet Type", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


              Image.asset("assets/images/path_two.png" , height: 80,) , SizedBox(width: 20,) ,Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                  child: Row(children: [



                    Expanded(flex: 4 ,child:Column(
                      children: [

                        Text(diet_type_prefer , style: TextStyle(fontSize: 14),),
                        Container(child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                        Text(diet_type , style: TextStyle(fontSize: 15),),

                      ],
                    ),),

                    Expanded(flex: 1  ,child:Container(margin: EdgeInsets.only(left: 20) ,child:Image.asset(diet_type_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png" , width: 25, height: 25 , ))),


                  ],)
              ),
            ],),),

            Container(child:Row(children: [ CircleWithNumber(number: "11") , const SizedBox(width: 15,) , Text("Skintone", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


              Image.asset("assets/images/path_two.png" , height: 80,) , SizedBox(width: 20,) ,Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                  child: Row(children: [



                    Expanded(flex: 4 ,child:Column(
                      children: [

                        Text(skintone_prefer, style: TextStyle(fontSize: 14),),
                        Container(child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                        Text(skintone, style: TextStyle(fontSize: 15),),

                      ],
                    ),),

                    Expanded(flex: 1  ,child:Container(margin: EdgeInsets.only(left: 20) ,child:Image.asset(skintone_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png" , width: 25, height: 25 , ))),


                  ],)
              ),
            ],),),

            Container(child:Row(children: [ CircleWithNumber(number: "12") , const SizedBox(width: 15,) , Text("Body Type", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


              Image.asset("assets/images/path.png" , height: 80,) , SizedBox(width: 20,) ,Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                  child: Row(children: [



                    Expanded(flex: 4 ,child:Column(
                      children: [

                        Text(body_type_prefer, style: TextStyle(fontSize: 14),),
                        Container(child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                        Text(body_type, style: TextStyle(fontSize: 15),),

                      ],
                    ),),

                    Expanded(flex: 1  ,child:Container(margin: EdgeInsets.only(left: 20) ,child:Image.asset(body_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png" , width: 25, height: 25 , ))),


                  ],)
              ),
            ],),),

            Container(child:Row(children: [ CircleWithNumber(number: "13") , const SizedBox(width: 15,) , Text("Drink Type", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


              Image.asset("assets/images/path_two.png" , height: 80,) , SizedBox(width: 20,) ,Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                  child: Row(children: [



                    Expanded(flex: 4 ,child:Column(
                      children: [

                        Text(drink_type_prefer , style: TextStyle(fontSize: 14),),
                        Container(child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                        Text(drink_type  ,  style: TextStyle(fontSize: 15),),

                      ],
                    ),),

                    Expanded(flex: 1  ,child:Container(margin: EdgeInsets.only(left: 20) ,child:Image.asset(drink_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png" , width: 25, height: 25 , ))),


                  ],)
              ),
            ],),),

            Container(child:Row(children: [ CircleWithNumber(number: "14") , const SizedBox(width: 15,) , Text("Smoke Type", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


              Image.asset("assets/images/path.png" , height: 80,) , SizedBox(width: 20,) ,Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                  child: Row(children: [



                    Expanded(flex: 4 ,child:Column(
                      children: [

                        Text(smoke_type_prefer, style: TextStyle(fontSize: 14),),
                        Container(child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                        Text(smoke_type , style: TextStyle(fontSize: 15),),

                      ],
                    ),),

                    Expanded(flex: 1  ,child:Container(margin: EdgeInsets.only(left: 20) ,child:Image.asset(smoke_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png" , width: 25, height: 25 , ))),


                  ],)
              ),
            ],),),

            Container(child:Row(children: [ CircleWithNumber(number: "15") , const SizedBox(width: 15,) , Text("Annual Income", style: TextStyle(fontFamily: "Roboto-Medium" , fontSize: 16 , color: Colors.black87 , fontWeight: FontWeight.w200 ),)],),),
            Container(margin:const EdgeInsets.only(left: 15 , right: 15) , child:Row(children: [


              Image.asset("assets/images/path_two.png" , height: 80,) , SizedBox(width: 20,) ,Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                  child: Row(children: [



                    Expanded(flex: 4 ,child:Column(
                      children: [

                        Text(annual_income_prefer, style: TextStyle(fontSize: 14),),
                        Container(child: Text(" Vs " , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),),
                        Text(annual_income , style: TextStyle(fontSize: 15),),

                      ],
                    ),),

                    Expanded(flex: 1  ,child:Container(margin: EdgeInsets.only(left: 20) ,child:Image.asset(annual_bool == true ? "assets/images/green_tick.png" : "assets/images/grey_tick.png" , width: 25, height: 25 , ))),


                  ],)
              ),
            ],),),

          ],

        )),



      ],),



    )),

    );


  }







}
