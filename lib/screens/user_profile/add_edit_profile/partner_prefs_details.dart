import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/MultiSelectDialog.dart';
import 'package:community_matrimonial/app_utils/SingleSelectDialog.dart';
import 'package:community_matrimonial/app_utils/Values.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/model/DataFetch.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/filter/dropdown.dart';
import 'package:community_matrimonial/screens/user_profile/ButtonSubmit.dart';
import 'package:community_matrimonial/screens/user_profile/CustomDropdown.dart';
import 'package:community_matrimonial/screens/user_profile/CustomTextField.dart';
import 'package:community_matrimonial/screens/user_profile/MultilineTextfield.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/Designs.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/data.dart';
import 'package:community_matrimonial/utils/lists.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PartnerDetails extends StatelessWidget {

  final String type;
  PartnerDetails({required this.type});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PartnerDetailStateful(type),
      builder: EasyLoading.init(),
    );
  }
}


class PartnerDetailStateful extends StatefulWidget {

  final String type;
  PartnerDetailStateful(this.type);

  @override
  PartnerDetailScreen createState() => PartnerDetailScreen();

}

class PartnerDetailScreen  extends State<PartnerDetailStateful>{

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  TextEditingController maritalController = new TextEditingController();
  TextEditingController casteController = new TextEditingController();
  TextEditingController subcasteController = new TextEditingController();
  TextEditingController skintoneController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();

  TextEditingController cityController = new TextEditingController();
  TextEditingController educationController = new TextEditingController();
  TextEditingController occupationController = new TextEditingController();
  TextEditingController bodytypeController = new TextEditingController();

  TextEditingController diettypeController = new TextEditingController();
  TextEditingController drinktypeController = new TextEditingController();
  TextEditingController smoketypeController = new TextEditingController();
  TextEditingController familyvalueController = new TextEditingController();
  TextEditingController AnnualIncomeController = new TextEditingController();


  String from_age = "18" , to_age = "70" , from_height = "4ft 0inch" , to_height = "7ft 5inch";
  String marital_vlaue = "" , caste_vlaue ="" , subcaste_value = "", skintone_value = "" , state_value = "";
  String  city_value = "" , edu_value = "" , occup_value = "" , body_type = "" , diet_type = "" ,drink_type =""  ;
  String smoke_type = "" ,  family_value = "", annual_income = "";

  List<String> Age =  Lists().generateNumberList(18, 70);

  late ConnectivityResult _connectivityResult;

  @override
  void initState() {
    super.initState();

    EasyLoading.dismiss();

    initLoader();
    initViews();

  }


  initLoader(){

    EasyLoading.instance
      ..displayDuration =const Duration(milliseconds: 4000)
      ..loadingStyle =EasyLoadingStyle.custom //This was missing in earlier code
      ..backgroundColor = Colors.red
      ..textColor = Colors.white
      ..indicatorColor = Colors.white
      ..maskColor = Colors.red
      ..indicatorType = EasyLoadingIndicatorType.hourGlass
      ..dismissOnTap = false
      ..userInteractions = false;

  }




  initViews() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(prefs.getString(SharedPrefs.maritalStatus_prefs).toString());

    if(prefs.getString(SharedPrefs.maritalStatus_prefs).toString().length > 0) {
      maritalController.text = utils().replaceNull(prefs.getString(SharedPrefs.maritalStatus_prefs).toString().split("*")[0]);
      marital_vlaue =  prefs.getString(SharedPrefs.maritalStatus_prefs).toString().split("*")[1] ?? "";
    }

    if(prefs.getString(SharedPrefs.subcaste_prefs).toString().length > 0 && prefs.getString(SharedPrefs.subcaste_prefs).toString().contains("*")) {
      subcaste_value =  utils().replaceNull(prefs.getString(SharedPrefs.subcaste_prefs).toString().split("*")[1]);
      subcasteController.text = prefs.getString(SharedPrefs.subcaste_prefs).toString().split("*")[0];
    }

    if(prefs.getString(SharedPrefs.skintoneprefs).toString().length > 0) {
      skintoneController.text =  utils().replaceNull(prefs.getString(SharedPrefs.skintoneprefs).toString().split("*")[0]);
      skintone_value   = prefs.getString(SharedPrefs.skintoneprefs).toString().split("*")[1];
    }

    if(prefs.getString(SharedPrefs.state_prefs).toString().length > 0) {
      stateController.text =  utils().replaceNull(prefs.getString(SharedPrefs.state_prefs).toString().split("*")[0]);
      state_value =   prefs.getString(SharedPrefs.state_prefs).toString().split("*")[1];
    }

    if(prefs.getString(SharedPrefs.city_prefs).toString().length > 0) {
      cityController.text = utils().replaceNull(prefs.getString(SharedPrefs.city_prefs).toString().split("*")[0]);
      city_value     =    prefs.getString(SharedPrefs.city_prefs).toString().split("*")[1];
    }

    if(prefs.getString(SharedPrefs.education_prefs).toString().length > 0) {
      educationController.text = utils().replaceNull(prefs.getString(SharedPrefs.education_prefs).toString().split("*")[0]);
      edu_value    =   prefs.getString(SharedPrefs.education_prefs).toString().split("*")[1] ;
    }

    if(prefs.getString(SharedPrefs.occupation_prefs).toString().length > 0) {
      occupationController.text = utils().replaceNull(prefs.getString(SharedPrefs.occupation_prefs).toString().split("*")[0]);
      occup_value   = prefs.getString(SharedPrefs.occupation_prefs).toString().split("*")[1];
    }

    if(prefs.getString(SharedPrefs.bodyType_prefs).toString().length > 0) {
      bodytypeController.text = utils().replaceNull(prefs.getString(SharedPrefs.bodyType_prefs).toString().split("*")[0]);
      body_type  =    prefs.getString(SharedPrefs.bodyType_prefs).toString().split("*")[1];
    }

    if(prefs.getString(SharedPrefs.dietType_prefs).toString().length > 0) {
      diettypeController.text = utils().replaceNull(prefs.getString(SharedPrefs.dietType_prefs).toString().split("*")[0]);
      diet_type   =  prefs.getString(SharedPrefs.dietType_prefs).toString().split("*")[1];
    }

    if(prefs.getString(SharedPrefs.drinkType_prefs).toString().length > 0) {
      drinktypeController.text = utils().replaceNull(prefs.getString(SharedPrefs.drinkType_prefs).toString().split("*")[0]);
      drink_type    =    prefs.getString(SharedPrefs.drinkType_prefs).toString().split("*")[1];
    }

    if(prefs.getString(SharedPrefs.smokeType_prefs).toString().length > 0) {
      smoketypeController.text = utils().replaceNull(prefs.getString(SharedPrefs.smokeType_prefs).toString().split("*")[0]);
      smoke_type   = prefs.getString(SharedPrefs.smokeType_prefs).toString().split("*")[1];
    }

    if(prefs.getString(SharedPrefs.familyValue_prefs).toString().length > 0 && prefs.getString(SharedPrefs.familyValue_prefs).toString().contains("*")) {
      familyvalueController.text = utils().replaceNull(prefs.getString(SharedPrefs.familyValue_prefs).toString().split("*")[0]);
      family_value =  prefs.getString(SharedPrefs.familyValue_prefs).toString().split("*")[1];
    }

    if(prefs.getString(SharedPrefs.annualIncome_prefs).toString().length > 0) {
      AnnualIncomeController.text =  utils().replaceNull(prefs.getString(SharedPrefs.annualIncome_prefs).toString());
      annual_income = prefs.getString(SharedPrefs.annualIncome_prefs).toString();
    }

    print(prefs.getString(SharedPrefs.heightRange).toString()+"{}{}{}");

    setState(() {

      if(prefs.getString(SharedPrefs.ageRange).toString() == "-"){

        from_age = "18";
        to_age  = "70";

      }else {
        from_age =
            prefs.getString(SharedPrefs.ageRange).toString().split("-")[0]
                .toString();
        to_age = prefs.getString(SharedPrefs.ageRange).toString().split("-")[1]
            .toString();
      }

      if(prefs.getString(SharedPrefs.heightRange).toString() == "-"){

        from_height = "4ft 0inch";
        to_height = "7ft 5inch";

      }else {
        from_height =
            prefs.getString(SharedPrefs.heightRange).toString().split("-")[0]
                .toString();
        to_height =
            prefs.getString(SharedPrefs.heightRange).toString().split("-")[1]
                .toString();
      }

      String gender = prefs.getString(SharedPrefs.gender).toString().toLowerCase();
      String age    = prefs.getString(SharedPrefs.age).toString();
      String height    = prefs.getString(SharedPrefs.height).toString();


      /*if(from_age ==  "18") {
        if (gender == "male") {

          from_age =   (int.parse(age) - 3).toString();
          to_age   =   age;

        } else {

          from_age =    age;
          to_age   =   (int.parse(age) + 3).toString();

        }
      }



      if(from_height ==  "4ft 0inch") {
        if (gender == "male") {

          from_height = Data().heights[Data().heights.indexOf(height) > 3 ? Data().heights.indexOf(height)-3 : 0];
          to_height   = Data().heights[Data().heights.indexOf(height)];

        } else {

          to_height = Data().heights[Data().heights.indexOf(height) < Data().heights.length-3 ? Data().heights.indexOf(height)+3 : Data().heights.length];
          from_height   = Data().heights[Data().heights.indexOf(height)];

        }
      }*/


      print(from_age+"----"+to_age);
      print(from_height+"----"+to_height);

    });





  }

  bool _loading = false;
  TextEditingController countryController = new TextEditingController();
  String country_value = "";

  @override
  Widget build(BuildContext context) {

    print(to_height+"==---");

    return Scaffold(key: _scaffoldKey,
        appBar: AppBar(
            title: Text('Partner Preference Details\nRavaldev Matrimony' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
            toolbarOpacity: 1,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
              onPressed: () {

                navService.goBack();

              },
            )),

        body:SafeArea(child: SingleChildScrollView( child:Container(margin: EdgeInsets.only(left: 15 ,right: 15) ,child:Column( children: [

          Divider(),

          Row(children: [Expanded(flex: 7  , child: DropDown(listItems: Age, onItemSelected: (String value) {

            setState(() {
              from_age = value;
            });

          }, selectedItem: from_age , label: 'From Age', seq: "from_age",)),
            Expanded(flex: 1  ,child: Container()),
            Expanded(flex: 7  ,child: DropDown(listItems: Age, onItemSelected: (String value) {

              setState(() {
                to_age = value;
              });

            }, selectedItem: to_age, label: 'To Age', seq: "to_age",)),
          ],),
          SizedBox(height: 20,),
          Row(children: [Expanded(flex: 7  ,child: DropDown(listItems: Data().heights, onItemSelected: (String value) {

            setState(() {
              from_height = value;
            });

          }, selectedItem: from_height , label: 'From Height', seq:"from_height" ,)),
            Expanded(flex: 1  ,child: Container()),
            Expanded(flex: 7  ,child: DropDown(listItems: Data().heights, onItemSelected: (String value) {

              setState(() {
                to_height = value;
              });

            }, selectedItem: to_height , label: 'To Height', seq: "to_height",)),
          ],),
          SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.family_restroom , controller: maritalController, labelText: TranslationService.translate("marital_status_prefs"), onButtonPressed: () async {

            EasyLoading.show(status: 'Please wait...');

            MultiSelectDialogWithBottomSheet().showMultiSelect(context , await Values.getValuesMultiple(context , "marital_status" , "") , maritalController , "Select Marital Status" , callback: (String newData) {
             marital_vlaue = newData;
            },);
            EasyLoading.dismiss();

          },),
          SizedBox(height: 20,),
          CustomTextField(icondata: Icons.person , controller: subcasteController , labelText: TranslationService.translate("shakh"), enabled: false,),

          SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.person , controller: skintoneController, labelText: TranslationService.translate("skintone_prefs"), onButtonPressed: () async {

            EasyLoading.show(status: 'Please wait...');

            List<MultiSelectItem<dynamic>> list_skintone =   await Values.getValuesMultiple(context , "skintone" , "");
            list_skintone.insert(0, MultiSelectItem("Any", "Any"));

            MultiSelectDialogWithBottomSheet().showMultiSelect(context , list_skintone  , skintoneController , "Select Skintone"  ,callback: (String newData) {
            skintone_value = newData;
            },);

            EasyLoading.dismiss();


          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: MdiIcons.googleMaps  ,controller: countryController , labelText: TranslationService.translate("perm_country") , onButtonPressed: () async {

            final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValuesContacts(context , "country" , "") , "Select Country");
            countryController.text = value.label;
            country_value = value.value;

          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: MdiIcons.googleMaps , controller: stateController , labelText: TranslationService.translate("state_prefs"), onButtonPressed: () async {

           if(country_value != "") {
             EasyLoading.show(status: 'Please wait...');

             List<MultiSelectItem<dynamic>> list_state = await Values
                 .getValuesMultipleState(context, "state", country_value);
             list_state.insert(0, MultiSelectItem("Any", "Any"));



             MultiSelectDialogWithBottomSheet().showMultiSelect(
               context, list_state, stateController, "Select State",
               callback: (String newData) {

                 setState(() {
                   state_value = newData;
                 });


                 print(state_value);

               },);

             EasyLoading.dismiss();

           }else{


             DialogClass().showDialog2(context, "No Country", "No Country Selected", "OK");

           }



          },),
          SizedBox(height: state_value.toLowerCase().contains("any") ? 0 : 20,),
          state_value.toLowerCase().contains("any") ? Container() : CustomDropdown(icondata:MdiIcons.googleMaps , controller: cityController , labelText: TranslationService.translate("city_prefs"), onButtonPressed: () async {

            if(state_value == "" || state_value.isEmpty){

              DialogClass().showDialog2(
                  context, "City alert!",
                  "Please select state first", "Ok");

            }else if(state_value.contains("Any")){

              DialogClass().showDialog2(
                  context, "City alert!",
                  "You have Selected Any State ,hence city does not matter", "Ok");


            }else {


            EasyLoading.show(status: 'Please wait...');

              List<MultiSelectItem<dynamic>> list_city = await Values
                  .getValuesMultipleCity(context, state_value.replaceAll("Any", ""), "1");
              list_city.insert(0, MultiSelectItem("Any", "Any"));

              MultiSelectDialogWithBottomSheet().showMultiSelect(
                context, list_city, cityController , "Select City" , callback: (String newData) {
                city_value = newData;
              },);

              EasyLoading.dismiss();
            }

          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.person , controller: educationController , labelText: TranslationService.translate("education_prefs"), onButtonPressed: () async {

            EasyLoading.show(status: 'Please wait...');

            List<MultiSelectItem<dynamic>> list_education = await Values.getValuesMultipleEducation(context , "education" , "");
            list_education.insert(0, MultiSelectItem("Any", "Any"));

            MultiSelectDialogWithBottomSheet().showMultiSelect(context , list_education  , educationController , "Select Education" , callback: (String newData) {
              edu_value = newData;
            },);

            EasyLoading.dismiss();


          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.person , controller: occupationController , labelText: TranslationService.translate("occupation_prefs"), onButtonPressed: () async {


            EasyLoading.show(status: 'Please wait...');

            List<MultiSelectItem<dynamic>> list_occupation = await Values.getValuesMultipleOccupation(context , "occupation" , "");
            list_occupation.insert(0, MultiSelectItem("Any", "Any"));

            MultiSelectDialogWithBottomSheet().showMultiSelect(context , list_occupation , occupationController , "Select Occupation" , callback: (String newData) {
            occup_value = newData;
            },);

            EasyLoading.dismiss();

          },),
        /*  SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.person , controller: diettypeController , labelText: TranslationService.translate("diet_type_prefs"), onButtonPressed: () async {


            EasyLoading.show(status: 'Please wait...');

            List<MultiSelectItem<dynamic>> list_diet_type = await Values.getValuesMultiple(context , "diet_type" , "");
            list_diet_type.insert(0, MultiSelectItem("Any", "Any"));

            MultiSelectDialogWithBottomSheet().showMultiSelect(context , list_diet_type , diettypeController , "Select Diet Type" , callback: (String newData) {
            diet_type = newData;
            },);
            EasyLoading.dismiss();


          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.person , controller: familyvalueController , labelText: TranslationService.translate("family_value_prefs"), onButtonPressed: () async {


            EasyLoading.show(status: 'Please wait...');

            List<MultiSelectItem<dynamic>> list_fml_value = await Values.getValuesMultiple(context , "fml_value" , "");
            list_fml_value.insert(0, MultiSelectItem("Any", "Any"));

            MultiSelectDialogWithBottomSheet().showMultiSelect(context , list_fml_value , familyvalueController , "Select Family Value" , callback: (String newData) {
            family_value = newData;
            },);

            EasyLoading.dismiss();

          },),*/
          SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.person , controller: AnnualIncomeController , labelText: TranslationService.translate("annual_income_prefs"), onButtonPressed: () async {

            EasyLoading.show(status: 'Please wait...');

            List<MultiSelectItem<dynamic>> list_annual_income = await Values.getValuesMultiple(context , "annual_income" , "");
            list_annual_income.insert(0, MultiSelectItem("Any", "Any"));

            MultiSelectDialogWithBottomSheet().showMultiSelect(context , list_annual_income , AnnualIncomeController , "Select Annual Income" , callback: (String newData) {
            annual_income = newData;
            },);

            EasyLoading.dismiss();

          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.person , controller: bodytypeController , labelText: TranslationService.translate("body_type_prefs"), onButtonPressed: () async {

            EasyLoading.show(status: 'Please wait...');

            List<MultiSelectItem<dynamic>> list_body_type = await Values.getValuesMultiple(context , "body_type" , "");
            list_body_type.insert(0, MultiSelectItem("Any", "Any"));

            MultiSelectDialogWithBottomSheet().showMultiSelect(context , list_body_type , bodytypeController , "Select Body Type" , callback: (String newData) {
            body_type = newData;
            },);

            EasyLoading.dismiss();

          },),
/*          SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.person , controller: drinktypeController , labelText: TranslationService.translate("drinktype_prefs"), onButtonPressed: () async {

            List<MultiSelectItem<dynamic>> list_drink_type = await Values.getValuesMultiple(context , "drink_type" , "");
            list_drink_type.insert(0, MultiSelectItem("Any", "Any"));

            MultiSelectDialogWithBottomSheet().showMultiSelect(context , list_drink_type , drinktypeController , "Select Drink Type" , callback: (String newData) {
            drink_type = newData;
            },);

          },),
          SizedBox(height: 20,),
          CustomDropdown(icondata: Icons.person , controller: smoketypeController , labelText: TranslationService.translate("smoketype_prefs"), onButtonPressed: () async {

            List<MultiSelectItem<dynamic>> list_smoke_type = await Values.getValuesMultiple(context , "smoke_type" , "");
            list_smoke_type.insert(0, MultiSelectItem("Any", "Any"));

            MultiSelectDialogWithBottomSheet().showMultiSelect(context , list_smoke_type , smoketypeController , "Select Smoke Type" , callback: (String newData) {
            smoke_type = newData;
            },);

          },),*/
          SizedBox(height: 20,),
          ButtonSubmit(text: 'Submit Partner Preference Details', onButtonPressed: () async {

   ConnectivityResult result = await Connectivity().checkConnectivity();
            setState(() {
              _connectivityResult = result;
            });
    if (_connectivityResult == ConnectivityResult.none) {
    DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");
    }else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      
      //prefs.remove(SharedPrefs.ageRange);

      if (prefs
          .getString(SharedPrefs.ageRange) == null) {
        EasyLoading.show(status: 'Please wait...');

        final _response = await Provider.of<ApiService>(
            context, listen: false).postPartnerPrefernceInsert({
          "age_range": from_age + "-" + to_age,
          "height_range": from_height + "-" + to_height,
          "marital_status": marital_vlaue,
          "caste": "",
          "subcaste": subcaste_value,
          "skintone": skintone_value,
          "state": state_value,
          "city": city_value,
          "education": edu_value,
          "occupation": occup_value,
          "diet_type": diet_type,
          "family_value": family_value,
          "annual_income": AnnualIncomeController.text.toString(),
          "body_type": body_type,
          "smoke_type": smoke_type,
          "drink_type": drink_type,
          "partner_details": "",
          "userId": prefs.getString(SharedPrefs.userId),
          "communityId": prefs.getString(SharedPrefs.communityId),
          "profileId": prefs.getString(SharedPrefs.profileid),
        });

        print(_response.body.toString());

        if (_response.body["data"]["affectedRows"] == 1) {
          await prefs.setString(
              SharedPrefs.partner_prefs_id, _response.body["data"]["insertId"].toString());

          await prefs.setString(
              SharedPrefs.ageRange, from_age + "-" + to_age ?? '');
          await prefs.setString(
              SharedPrefs.heightRange, from_height + "-" + to_height ?? '');
          await prefs.setString(
              SharedPrefs.maritalStatus_prefs, maritalController.text
              .toString() + "*" + marital_vlaue ?? '');
          await prefs.setString(SharedPrefs.caste_prefs, "" ?? '');
          await prefs.setString(SharedPrefs.subcaste_prefs, subcasteController
              .text.toString() + "*" + subcaste_value ?? '');
          await prefs.setString(SharedPrefs.state_prefs, stateController.text
              .toString() + "*" + state_value ?? '');
          await prefs.setString(SharedPrefs.city_prefs, cityController.text
              .toString() + "*" + city_value ?? '');
          await prefs.setString(SharedPrefs.skintoneprefs, skintoneController
              .text.toString() + "*" + skintone_value ?? '');
          await prefs.setString(SharedPrefs.education_prefs, educationController
              .text.toString() + "*" + edu_value ?? '');
          await prefs.setString(
              SharedPrefs.occupation_prefs, occupationController.text
              .toString() + "*" + occup_value ?? '');
          await prefs.setString(
              SharedPrefs.familyValue_prefs, familyvalueController.text
              .toString() + "*" + family_value ?? '');
          await prefs.setString(SharedPrefs.dietType_prefs, diettypeController
              .text.toString() + "*" + diet_type ?? '');
          await prefs.setString(SharedPrefs.bodyType_prefs, bodytypeController
              .text.toString() + "*" + body_type ?? '');
          await prefs.setString(SharedPrefs.drinkType_prefs, drinktypeController
              .text.toString() + "*" + drink_type ?? '');
          await prefs.setString(SharedPrefs.smokeType_prefs, smoketypeController
              .text.toString() + "*" + smoke_type ?? '');
          await prefs.setString(SharedPrefs.annualIncome_prefs,
              AnnualIncomeController.text ?? '');
          await prefs.setString(SharedPrefs.partnerDetails, "" ?? '');


          EasyLoading.dismiss();

          if (widget.type == "insert") {
            navService.pushNamed("/documents");
          } else {
            navService.goBack();
          }
        } else {
          EasyLoading.dismiss();

          DialogClass().showDialog2(
              context, "Partner Preference Details Submit Alert!",
              "Some problem occured Please try again", "Ok");
        }
      } else {
        print(from_age + "-" + to_age);
        print(from_height + "-" + to_height);

        final _response = await Provider.of<ApiService>(
            context, listen: false).postPartnerPrefernceUpdate({
          "age_range": from_age + "-" + to_age,
          "height_range": from_height + "-" + to_height,
          "marital_status": marital_vlaue,
          "caste": "",
          "subcaste": subcaste_value,
          "skintone": skintone_value,
          "state": state_value,
          "city": city_value,
          "education": edu_value,
          "occupation": occup_value,
          "diet_type": diet_type,
          "family_value": family_value,
          "annual_income": AnnualIncomeController.text.toString(),
          "body_type": body_type,
          "smoke_type": smoke_type,
          "drink_type": drink_type,
          "partner_details": "",
          "Id": prefs.getString(SharedPrefs.partner_prefs_id),
        });


        if (_response.body["success"] == 1) {
          await prefs.setString(
              SharedPrefs.ageRange, from_age + "-" + to_age ?? '');
          await prefs.setString(
              SharedPrefs.heightRange, from_height + "-" + to_height ?? '');
          await prefs.setString(
              SharedPrefs.maritalStatus_prefs, maritalController.text
              .toString() + "*" + marital_vlaue ?? '');
          await prefs.setString(SharedPrefs.caste_prefs, "" ?? '');
          await prefs.setString(SharedPrefs.subcaste_prefs, subcasteController
              .text.toString() + "*" + subcaste_value ?? '');
          await prefs.setString(SharedPrefs.state_prefs, stateController.text
              .toString() + "*" + state_value ?? '');
          await prefs.setString(SharedPrefs.city_prefs, cityController.text
              .toString() + "*" + city_value ?? '');
          await prefs.setString(SharedPrefs.skintoneprefs, skintoneController
              .text.toString() + "*" + skintone_value ?? '');
          await prefs.setString(SharedPrefs.education_prefs, educationController
              .text.toString() + "*" + edu_value ?? '');
          await prefs.setString(
              SharedPrefs.occupation_prefs, occupationController.text
              .toString() + "*" + occup_value ?? '');
          await prefs.setString(
              SharedPrefs.familyValue_prefs, familyvalueController.text
              .toString() + "*" + family_value ?? '');
          await prefs.setString(SharedPrefs.dietType_prefs, diettypeController
              .text.toString() + "*" + diet_type ?? '');
          await prefs.setString(SharedPrefs.bodyType_prefs, bodytypeController
              .text.toString() + "*" + body_type ?? '');
          await prefs.setString(SharedPrefs.drinkType_prefs, drinktypeController
              .text.toString() + "*" + drink_type ?? '');
          await prefs.setString(SharedPrefs.smokeType_prefs, smoketypeController
              .text.toString() + "*" + smoke_type ?? '');
          await prefs.setString(SharedPrefs.annualIncome_prefs,
              AnnualIncomeController.text ?? '');
          await prefs.setString(SharedPrefs.partnerDetails, "" ?? '');


          EasyLoading.dismiss();
          navService.goBack();
        } else {
          EasyLoading.dismiss();

          DialogClass().showDialog2(
              context, "Partner Prefrence Details Submit Alert!",
              "Some problem occured Please try again", "Ok");
        }
      }
    }

          },)

        ],)),
        )));

  }




}
