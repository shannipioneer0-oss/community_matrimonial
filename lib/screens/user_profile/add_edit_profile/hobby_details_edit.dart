import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/user_profile/ButtonSubmit.dart';
import 'package:community_matrimonial/screens/user_profile/CustomTextField.dart';
import 'package:community_matrimonial/screens/user_profile/MultilineTextfield.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../locale/TranslationService.dart';






class HobbyDetails extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HobbyDetailsStateful(),
      builder: EasyLoading.init(),
    );
  }
}


class HobbyDetailsStateful extends StatefulWidget {



  @override
  HobbyDetailsScreen createState() => HobbyDetailsScreen();

}

class HobbyDetailsScreen  extends State<HobbyDetailsStateful>{


  var menuHobbies = [
    'Adventure',
    'Calligraphy',
    'Chatting',
    'Cooking',
    'Cricket',
    'Dance',
    'Drawing',
    'Driving',
    'Eating',
    'Gyming',
    'Hanging Out',
    'Hiking',
    'Listening music',
    'Movies',
    'Painting',
    'Photography',
    'Playing musical instrument',
    'Reading',
    'Singing',
    'Social Network',
    'Sports',
    'Surfing Internet',
    'Swimming',
    'Traveling',
    'Writing',
    'Other'
  ];

  List<bool> _selectedItems = [false , false ,false ,false ,false ,false ,false , false , false ,false ,false ,false ,false ,false , false , false ,false ,false ,false ,false ,false, false , false ,false ,false ,false];
  List<String> _selectedHobbies = [];

  // Toggle selection for chips
  void _toggleSelection(int index) {
    setState(() {
      if (_selectedItems[index] == true) {
        _selectedItems[index] = false;// Unselect
        _selectedHobbies.remove(menuHobbies[index]);
      } else {
        _selectedItems[index] = true;
        _selectedHobbies.add(menuHobbies[index]);
      }
    });

    controller.text = "";
    controller.text = _selectedHobbies.join(", ");
  }

  TextEditingController controller = TextEditingController();

     @override
  void initState() {
    // TODO: implement initState
    super.initState();

    EasyLoading.dismiss();

   initprefs();


  }

  initprefs() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    controller.text = prefs.getString(SharedPrefs.hobbies).toString();


    setState(() {
      menuHobbies.asMap().forEach((index , element) {

        if(prefs.getString(SharedPrefs.hobbies).toString().toLowerCase().contains(element.toString().toLowerCase())){
          _selectedHobbies.add(element.toString());
          _selectedItems[index] = true;
        }

      });
    });


  }


  @override
  Widget build(BuildContext context) {

    return Scaffold( appBar: AppBar(
        title: Text('Hobby Details\nRavaldev Matrimony' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
        toolbarOpacity: 1,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
          onPressed: () {

            navService.goBack();

          },
        )),

      body: SingleChildScrollView(child:Container( padding: EdgeInsets.all(10)   ,child: Column(children: [

        Container(alignment: Alignment.topLeft ,child:Text("Select Your Hobbies" , style:  TextStyle(fontSize: 18 , fontWeight: FontWeight.bold ,color: Colors.red),),),
         SizedBox(height: 15,),
        Wrap(children: List.generate(menuHobbies.length , (index) => ChoiceChip(
          padding: EdgeInsets.all(8),

          elevation: 2,
          label: Text(menuHobbies[index] , style: TextStyle( color: _selectedItems[index] ? Colors.white : Colors.black87),),
          // color of selected chip
          selectedColor: Colors.green,
          // selected chip value
          selected: _selectedItems[index] ,
          // onselected method
          onSelected: (bool selected) {
            setState(() {
              _toggleSelection(index);
            });
          },
        )),),
        SizedBox(height: 20,),
        MultilineTextfield(icondata: Icons.interests , controller: controller  , labelText: TranslationService.translate("select_hobby"), enabled: false, minlines: 3, maxlines: 7,),

        SizedBox(height: 20,),

        ButtonSubmit(text: "Submit Hobbies", onButtonPressed: () async {

          String hobbyError = Validation.validateNotEmpty(
              controller.text, 'hobby').toString();

          if(hobbyError == "null"){
            DialogClass().showDialog2(
                context, "Hobby Details Submit Alert!",
                "All fields are compulsory", "Ok");
          }else{

            SharedPreferences prefs = await SharedPreferences.getInstance();

            if(prefs.getString(SharedPrefs.hobbies) == null ||  prefs.getString(SharedPrefs.hobbies) == "null"){

              EasyLoading.show(status: 'Please wait...');
              final _response = await Provider.of<ApiService>(
                  context, listen: false).insertHobbies({"hobbies":controller.text.toString() , "userId":prefs.getString(SharedPrefs.userId) , "communityId" : prefs.getString(SharedPrefs.communityId) , "profileId" :prefs.getString(SharedPrefs.profileid)});

             if (_response.body["data"]["affectedRows"] == 1) {

                   EasyLoading.dismiss();
                  prefs.setString(SharedPrefs.hobbies ,  controller.text.toString());
                   navService.goBack();
              }

            }else{


              EasyLoading.show(status: 'Please wait...');
              final _response = await Provider.of<ApiService>(
                  context, listen: false).updateHobbies({"hobbies":controller.text.toString() , "userId":prefs.getString(SharedPrefs.userId) , "communityId" : prefs.getString(SharedPrefs.communityId)});

              if (_response.body["data"]["affectedRows"] == 1) {

                EasyLoading.dismiss();
                prefs.setString(SharedPrefs.hobbies ,  controller.text.toString());

                navService.goBack();
              }


            }



          }


        })


      ],)  ,),

    ));


  }






}