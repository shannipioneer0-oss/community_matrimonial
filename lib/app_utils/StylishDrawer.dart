import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/SharedPrefs.dart';
import 'Dialogs.dart';

class StylishDrawer extends StatefulWidget {
  @override
  _StylishDrawerState createState() => _StylishDrawerState();
}

class _StylishDrawerState extends State<StylishDrawer> {
  int _selectedItemIndex = 0;
  String community_name = "Zalawad Community";
  String mobilenumber = "";

    @override
  void initState() {
    // TODO: implement initState
    super.initState();


    initIntro();
    initprefs();


  }

  String role= "";
  initprefs() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      role = prefs.getString(SharedPrefs.role_type).toString();
    });


    print(role);

  }



  String img1 = "" , username = "" , percentage = "";
    double percent = 0.0;
  late SharedPreferences prefs;

  initIntro() async {

     prefs = await SharedPreferences.getInstance();

    setState(() {
      img1 = prefs.getString(SharedPrefs.pic1).toString();
      username = prefs.getString(SharedPrefs.firstName).toString()+" "+prefs.getString(SharedPrefs.lastname).toString();
      percentage = prefs.getString(SharedPrefs.profile_percentage).toString().split(".")[0];

      community_name = prefs.getString(SharedPrefs.communityName).toString();
      mobilenumber = prefs.getString(SharedPrefs.mobileNumber).toString();

      percent = int.parse(percentage).toDouble();
    });

    print(Strings.IMAGE_BASE_URL+"/uploads/matrimonial_photo/"+prefs.getString(SharedPrefs.communityId).toString()+"/"+img1);


  }


  @override
  Widget build(BuildContext context) {


    return Drawer(
      child:SingleChildScrollView(child:Container(
        color: Colors.white54,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           Container(margin: EdgeInsets.only(bottom: 20) , height: MediaQuery.of(context).size.height*0.35 ,child:DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
              ),
              child: Column(children: [

               Row(mainAxisAlignment: MainAxisAlignment.start  ,children: [Text(community_name ,textAlign: TextAlign.left , style: TextStyle(color: Colors.white , fontSize:  15 , fontWeight: FontWeight.bold , overflow: TextOverflow.ellipsis),),],),
               SizedBox(height: 10,),
               Row(children: [ CircleAvatar(radius: 30 ,backgroundImage: NetworkImage(Strings.IMAGE_BASE_URL+"/uploads/matrimonial_photo/"+prefs.getString(SharedPrefs.communityId).toString()+"/"+img1 ), ) , SizedBox(width: 10,),Text(username , style: TextStyle(color: Colors.white , fontSize:  20 , fontWeight: FontWeight.bold),)],),

                Container(width:300  ,margin: EdgeInsets.only(top: 25 , bottom: 5 ,left:15) ,child:Text("Your Profile Completion" , textAlign: TextAlign.left , style: TextStyle(color: Colors.white , fontSize:  13 , fontWeight: FontWeight.bold),)),
                LinearPercentIndicator(
                  width: 200.0,
                  lineHeight: 10.0,
                  percent: percent/100.0,
                  backgroundColor: Colors.white,
                  progressColor: Colors.indigo,
                  barRadius: Radius.circular(20),
                  trailing: Text(percent.toString().split(".")[0]+"%" , style: TextStyle(color: Colors.white , fontSize:  14 , fontWeight: FontWeight.bold)),
                ),

                Row(mainAxisAlignment: MainAxisAlignment.start  ,children: [Text(mobilenumber ,textAlign: TextAlign.left , style: TextStyle(color: Colors.white , fontSize:  15 , fontWeight: FontWeight.bold , overflow: TextOverflow.ellipsis),),],),


              ],),
            ),),
            DrawerItem(
              icon: Icons.home,
              title: TranslationService.translate("dashboard"),
              onTap: () => _onItemTap(0),
              isSelected: _selectedItemIndex == 0,

            ),
            DrawerItem(
              icon: Icons.account_circle_outlined,
              title: TranslationService.translate("profile"),
              onTap: () => _onItemTap(1),
              isSelected: _selectedItemIndex == 1,
            ),
            DrawerItem(
              icon: Icons.search,
              title: TranslationService.translate("search"),
              onTap: () => _onItemTap(2),
              isSelected: _selectedItemIndex == 2,
            ),
            DrawerItem(
              icon: Icons.mail,
              title: TranslationService.translate("inbox"),
              onTap: () => _onItemTap(3),
              isSelected: _selectedItemIndex == 3,
            ),
            DrawerItem(
              icon: Icons.chat,
              title: TranslationService.translate("Language"),
              onTap: () => _onItemTap(4),
              isSelected: _selectedItemIndex == 4,
            ),
            DrawerItem(
              icon: Icons.card_membership,
              title: TranslationService.translate("membership"),
              onTap: () => _onItemTap(5),
              isSelected: _selectedItemIndex == 5,
            ),
            DrawerItem(
              icon: Icons.settings,
              title: TranslationService.translate("settings"),
              onTap: () => _onItemTap(6),
              isSelected: _selectedItemIndex == 6,
            ),
            DrawerItem(
              icon: Icons.notifications,
              title: TranslationService.translate("notification"),
              onTap: () => _onItemTap(7),
              isSelected: _selectedItemIndex == 7,
            ),
            DrawerItem(
              icon: Icons.card_membership,
              title: "Your Membership Details",
              onTap: () => _onItemTap(8),
              isSelected: _selectedItemIndex == 8,
            ),
          role == "admin" ? DrawerItem(
            icon: Icons.verified,
            title: "Manage Verification",
            onTap: () => _onItemTap(9),
            isSelected: _selectedItemIndex == 9,
          ) : DrawerItem(
            icon: Icons.menu,
            title: "",
            onTap: () => _onItemTap(10),
            isSelected: _selectedItemIndex == 10,
            ),
            DrawerItem(
              icon: Icons.account_circle,
              title: "Committee Members",
              onTap: () => _onItemTap(11),
              isSelected: _selectedItemIndex == 11,
            ),DrawerItem(
              icon: Icons.account_circle,
              title: "About Us",
              onTap: () => _onItemTap(12),
              isSelected: _selectedItemIndex == 12,
            ),DrawerItem(
              icon: Icons.account_circle,
              title: "Contact Us",
              onTap: () => _onItemTap(13),
              isSelected: _selectedItemIndex == 13,
            ),
            DrawerItem(
              icon: Icons.account_circle,
              title: "Logout",
              onTap: () => _onItemTap(14),
              isSelected: _selectedItemIndex == 14,
            ),
            // Add more DrawerItem widgets for additional items
          ],
        ),
      ),
    ));
  }



  void showLanguagePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose Language'),
          content: Text('Please select your preferred language'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString(SharedPrefs.translate, "en");


                await TranslationService.load('en');

                DialogClass().showDialog2(context, "Translate Alert!", "Translated to English", "Ok");

              },
              child: Text('English'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString(SharedPrefs.translate, "gu");


                await TranslationService.load('gu');

                DialogClass().showDialog2(context, "Translate Alert!", "Translated to Gujarati", "Ok");

              },

              child: Text('ગુજરાતી'),
            ),
          ],
        );
      },
    );
  }



  Future<void> _onItemTap(int index) async {
    setState(() {
      _selectedItemIndex = index;
    });

    if(index == 0){
      navService.pushNamed("/main_screen" , args:2);
    }else if(index == 1){
      navService.pushNamed("/main_screen" , args:0);
    }else if(index == 2){
      navService.pushNamed("/saved_search");
    }else if(index == 3){
      navService.pushNamed("/main_screen" , args:1);
    }else if(index == 4){
      showLanguagePopup(context);
    }else if(index == 5){
      navService.pushNamed("/membership");
    }else if(index == 6){
      navService.pushNamed("/settings");
    }else if(index == 7){
      navService.pushNamed("/notification");
    }else if(index == 8){
      navService.pushNamed("/membership_details");
    }else if(index == 9){
      navService.pushNamed("/verifyscreen");
    }else if(index == 11){
      navService.pushNamed("/chief_members");
    }else if(index == 12){
      navService.pushNamed("/about_us");
    }else if(index == 13){
      navService.pushNamed("/contact_us");
    }else if(index == 14){

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(SharedPrefs.isLogin);
      prefs.clear();

      navService.pushNamedAndRemoveUntil("/intro");

    }

    // Handle navigation or other actions based on the selected item
  }
}


class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return title =="" ?  Container() :  Container(
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFFFDDE2) : Colors.transparent,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(isSelected ? 30.0 : 0.0),
          bottomRight: Radius.circular(isSelected ? 30.0 : 0.0),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        leading: Icon(
          icon,
          color: isSelected ?   Colors.pinkAccent : Colors.black54 ,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.pinkAccent : Colors.black54 ,
            fontSize: 16,
            fontFamily: "Roboto-Medium",
            fontWeight: FontWeight.normal
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}