import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/SingleSelectDialog.dart';
import 'package:community_matrimonial/app_utils/Values.dart';
import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/user_profile/ButtonSubmit.dart';
import 'package:community_matrimonial/screens/user_profile/CustomDropdown.dart';
import 'package:community_matrimonial/screens/user_profile/CustomTextField.dart';
import 'package:community_matrimonial/screens/user_profile/MultilineTextfield.dart';
import 'package:community_matrimonial/utils/Designs.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/data.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:community_matrimonial/utils/validation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LifestyleDetailsEdit extends StatelessWidget {

  final List list;
  LifestyleDetailsEdit(this.list);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LifestyleDetailsStateful(list),
      builder: EasyLoading.init(),
    );
  }
}


class LifestyleDetailsStateful extends StatefulWidget {

  final List list;
  LifestyleDetailsStateful(this.list);

  @override
  LifestyleDetailsScreen createState() => LifestyleDetailsScreen();

}

class LifestyleDetailsScreen  extends State<LifestyleDetailsStateful> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController heightController =new TextEditingController();
  TextEditingController weightController =new TextEditingController();
  TextEditingController skintoneController =new TextEditingController();
  TextEditingController bloodgroupController = new TextEditingController();
  TextEditingController bodytypeController = new TextEditingController();
  TextEditingController diettypeController = new TextEditingController();
  TextEditingController ishandicapController = new TextEditingController();
  TextEditingController handicapdetailsController = new TextEditingController();
  TextEditingController fitnesslevelController = new TextEditingController();
  TextEditingController drinktypeController = new TextEditingController();
  TextEditingController smoketypeController = new TextEditingController();
  TextEditingController extradetailsController = new TextEditingController();

  int selectedRadio = -1;
  int selectedRadioFitness = -1;

  String height_value = "" , weight_value = "" , skintone = "" , blood_group = "";
  String body_type = "" , diet_type = "" , drink_type = "" , smoke_type = "";
  String handicap_details = "" ,    overall_health = "" ;

  late ConnectivityResult _connectivityResult;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initViews();

  }

  initViews() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();


    heightController.text =  widget.list[0];
    weightController.text =   widget.list[1];
    skintoneController.text =   widget.list[2];
    bloodgroupController.text =  widget.list[3];
    bodytypeController.text =   widget.list[4];
    diettypeController.text =   widget.list[5];

    setState(() {
      selectedRadioFitness  =  widget.list[8] == "High" ? 0 : widget.list[8] == "Low" ? 1 : 2;
      selectedRadio =   widget.list[6] == "Yes" ? 0 : 1;
      handicapdetailsController.text =   widget.list[7];
    });

    drinktypeController.text =   widget.list[9];
    smoketypeController.text =   widget.list[10];






    height_value = widget.list[0];
    weight_value = widget.list[1];
    skintone    =  widget.list[12];
    blood_group = widget.list[3];
    body_type = widget.list[13];

    diet_type  = widget.list[14];

    handicap_details = widget.list[7];
    drink_type = widget.list[15];
    smoke_type = widget.list[16];


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(key: _scaffoldKey,
      appBar: AppBar(
          title: Text('Physical & Lifestyle Details' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
          toolbarOpacity: 1,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
            onPressed: () {

              navService.goBack();

            },
          )),
      body:SafeArea(child: SingleChildScrollView(child:Container(margin: EdgeInsets.only(left: 15 ,right: 15) ,child:Column(children: [

        Divider(),
        Container(margin: EdgeInsets.only(top: 10) ,child:CustomDropdown(icondata: Icons.height  ,controller: heightController , labelText: TranslationService.translate("height"), onButtonPressed: () async {

         final value = await SingleSelectDialog().showBottomSheetSingle(context, Data().heights , TranslationService.translate("height"));
         heightController.text = value;
         height_value = value;

        },),),
        SizedBox(height: 20,),
        CustomDropdown(icondata: Icons.monitor_weight  ,controller: weightController , labelText: TranslationService.translate("weight"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheetSingle(context, Data().getWeight() , TranslationService.translate("weight"));
          weightController.text = value;
          weight_value =  value;

        },),
        SizedBox(height: 20,),
        CustomDropdown(icondata: MdiIcons.borderColor  ,controller: skintoneController , labelText: TranslationService.translate("skintone"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "skintone" , "") , "Select Skintone");
          skintoneController.text = value.label;
          skintone =  value.value;

        },),
        SizedBox(height: 20,),
        CustomDropdown(icondata: MdiIcons.bloodBag  ,controller: bloodgroupController , labelText: TranslationService.translate("blood_group"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "blood_group" , "") , "Select Blood group");
          bloodgroupController.text = value.label;
          blood_group = value.label;

        },),
        SizedBox(height: 20,),
        CustomDropdown(icondata: MdiIcons.pageLayoutBody  ,controller: bodytypeController , labelText: TranslationService.translate("body_type"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "body_type" , "") , "Select Body Type");
          bodytypeController.text = value.label;
          body_type =  value.value;

        },),
        SizedBox(height: 20,),
        CustomDropdown(icondata: MdiIcons.food  ,controller: diettypeController , labelText: TranslationService.translate("diet_type"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "diet_type" , "") , "Select Diet Type");
          diettypeController.text = value.label;
          diet_type =  value.value;

        },),
        SizedBox(height: 20,),
        Container(width: MediaQuery.of(context).size.width , margin: EdgeInsets.only(left: 10) ,child:Text("Are You Handicap?" , textAlign: TextAlign.left, style: TextStyle(),),),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
              value: 0,
              groupValue: selectedRadio,
              onChanged: (value) {
                setState(() {
                  selectedRadio = value!;
                });
              },
            ),
            Text('Yes'),
            Radio(
              value: 1,
              groupValue: selectedRadio,
              onChanged: (value) {
                setState(() {
                  selectedRadio = value!;
                });
              },
            ),
            Text('No'),

          ],
        ),
        MultilineTextfield(icondata: MdiIcons.details, controller: handicapdetailsController, labelText: TranslationService.translate("handicap_details"), enabled: false, minlines: 3, maxlines: 7,),
        SizedBox(height: 20,),
        Container(width: MediaQuery.of(context).size.width , margin: EdgeInsets.only(left: 10) ,child:Text("Your Fitness Level" , textAlign: TextAlign.left, style: TextStyle(),),),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
              value: 0,
              groupValue: selectedRadioFitness,
              onChanged: (value) {
                setState(() {
                  selectedRadioFitness = value!;
                });
              },
            ),
            Text('High'),
            Radio(
              value: 1,
              groupValue: selectedRadioFitness,
              onChanged: (value) {
                setState(() {
                  selectedRadioFitness = value!;
                });
              },
            ),
            Text('Low'),
            Radio(
              value: 2,
              groupValue: selectedRadioFitness,
              onChanged: (value) {
                setState(() {
                  selectedRadioFitness = value!;
                });
              },
            ),
            Text('Ok'),

          ],
        ),
        SizedBox(height: 5,),
        CustomDropdown(icondata: MdiIcons.foodForkDrink  ,controller: drinktypeController , labelText: TranslationService.translate("drink_type"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "drink_type" , "") , "Select Drink Type");
          drinktypeController.text = value.label;
          drink_type =  value.value;

        },),
        SizedBox(height: 20,),
        CustomDropdown(icondata: MdiIcons.smoke  ,controller: smoketypeController , labelText: TranslationService.translate("smoke_type"), onButtonPressed: () async {

          final value = await SingleSelectDialog().showBottomSheet(context, await Values.getValues(context , "smoke_type" , "") , "Select Smoke Type");
          smoketypeController.text = value.label;
          smoke_type =  value.value;

        },),
        SizedBox(height: 20,),
        MultilineTextfield(icondata: MdiIcons.details, controller: extradetailsController, labelText: TranslationService.translate("extra_details"), enabled: false, minlines: 3, maxlines: 7,),
        SizedBox(height: 20,),
        ButtonSubmit(text: 'Submit Lifestyle Details', onButtonPressed: () async {

   ConnectivityResult result = await Connectivity().checkConnectivity();
            setState(() {
              _connectivityResult = result;
            });
    if (_connectivityResult == ConnectivityResult.none) {
    DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");
    }else {
      String heightError = Validation.validateNotEmpty(
          heightController.text.toString(), 'Height');
      String weightError = Validation.validateNotEmpty(
          weightController.text.toString(), 'Weight');
      String skinToneError = Validation.validateNotEmpty(
          skintoneController.text.toString(), 'Skin Tone');
      String bloodGroupError = Validation.validateNotEmpty(
          bloodgroupController.text, 'Blood Group');
      String bodyTypeError = Validation.validateNotEmpty(
          bodytypeController.text.toString(), 'Body Type');
      String dietTypeError = Validation.validateNotEmpty(
          diettypeController.text.toString(), 'Diet Type');
      String drinkTypeError = Validation.validateNotEmpty(
          drinktypeController.text, 'Drink Type');
      String smokeTypeError = Validation.validateNotEmpty(
          smoketypeController.text, 'Smoke Type');

      if (heightError == "null" ||
          weightError == "null" ||
          skinToneError == "null" ||
          bodyTypeError == "null" ||
          dietTypeError == "null" ||
          selectedRadio == -1 ||
          selectedRadioFitness == -1

      ) {
        DialogClass().showDialog2(context, "Lifestyle Details Submit Alert!",
            "All fields are compulsory", "Ok");
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();


        if (widget.list[0] == "" || widget.list[0] == null) {
          EasyLoading.show(status: 'Please wait...');

          final _response = await Provider.of<ApiService>(
              context, listen: false)
              .postLifeStyleInsert(
              {
                "weight": weightController.text.toString(),
                "height": heightController.text.toString(),
                "skintone": skintone,
                "blood_group": "0",
                "fitness": selectedRadioFitness == 0
                    ? "High"
                    : selectedRadioFitness == 1 ? "Low" : "Ok",
                "body_type": body_type,
                "is_handicap": selectedRadio == 0 ? "yes" : "No",
                "handicap_detail": handicapdetailsController.text
                    .toString(),
                "diet_type": "",
                "drink_type": "",
                "smoke_type": "",
                "extra_detail_physic": extradetailsController.text
                    .toString(),
                "userId": widget.list[18],
                "communityId": prefs.getString(SharedPrefs.communityId),
                "profileId": widget.list[19]
              }
          );

          if (_response.body["data"]["affectedRows"] == 1) {


            EasyLoading.dismiss();
            navService.goBack();

          } else {
            DialogClass().showDialog2(
                context, "Lifestyle Details Submit Alert!",
                "Some problem occured Please try again", "Ok");
          }
        } else {
          EasyLoading.show(status: 'Please wait...');

          final _response = await Provider.of<ApiService>(
              context, listen: false)
              .postLifestyleUpdate(
              {
                "weight": weightController.text.toString(),
                "height": heightController.text.toString(),
                "skintone": skintone,
                "blood_group": blood_group,
                "fitness": selectedRadioFitness == 0
                    ? "High"
                    : selectedRadioFitness == 1 ? "Low" : "Ok",
                "body_type": body_type,
                "is_handicap": selectedRadio == 0 ? "yes" : "No",
                "handicap_detail": handicapdetailsController.text
                    .toString(),
                "diet_type": diet_type,
                "drink_type": drink_type,
                "smoke_type": smoke_type,
                "extra_detail_physic": extradetailsController.text
                    .toString(),
                "Id": widget.list[17]
              }
          );


          if (_response.body["success"] == 1) {
            EasyLoading.dismiss();
            navService.goBack();

          } else {

            EasyLoading.dismiss();

            DialogClass().showDialog2(
                context, "Lifestyle Details Submit Alert!",
                "Some problem occured Please try again", "Ok");
          }
        }
      }
      }


        },)
      ]))),
    ));

  }

}