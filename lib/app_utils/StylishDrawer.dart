import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/SharedPrefs.dart';
import 'Dialogs.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


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



  String img1 = "" , username = "" , percentage = "" ,version = "";
    double percent = 0.0;
  late SharedPreferences prefs;

  initIntro() async {

     prefs = await SharedPreferences.getInstance();
     PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      img1 = prefs.getString(SharedPrefs.pic1).toString();
      username = prefs.getString(SharedPrefs.firstName).toString()+" "+prefs.getString(SharedPrefs.lastname).toString();
      percentage = prefs.getString(SharedPrefs.profile_percentage).toString().split(".")[0];

      community_name = prefs.getString(SharedPrefs.communityName).toString();
      mobilenumber = prefs.getString(SharedPrefs.mobile).toString();
      version = packageInfo.version;

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
               Row(children: [ CircleAvatar(radius: 30 ,backgroundImage: NetworkImage(Strings.IMAGE_BASE_URL+"/uploads/matrimonial_photo/"+prefs.getString(SharedPrefs.communityId).toString()+"/"+img1 ), ) , SizedBox(width: 10,),Container(width: MediaQuery.of(context).size.width*0.45  ,child: Text(username , maxLines: 3 ,overflow: TextOverflow.ellipsis , style: TextStyle(color: Colors.white , fontSize:  20 , fontWeight: FontWeight.bold ,overflow: TextOverflow.ellipsis),))],),

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

                SizedBox(height: 1,),

               Row(mainAxisAlignment: MainAxisAlignment.start  ,children: [Container(child: Text("Version : "+version , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),),])



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
              title: TranslationService.translate("your_member_details"),
              onTap: () => _onItemTap(8),
              isSelected: _selectedItemIndex == 8,
            ),
          role == "admin" ? DrawerItem(
            icon: Icons.verified,
            title: TranslationService.translate("manage_verification"),
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
              title:TranslationService.translate("comittee_members"),
              onTap: () => _onItemTap(11),
              isSelected: _selectedItemIndex == 11,
            ),DrawerItem(
              icon: Icons.account_circle,
              title: TranslationService.translate("about_us"),
              onTap: () => _onItemTap(12),
              isSelected: _selectedItemIndex == 12,
            ),DrawerItem(
              icon: Icons.account_circle,
              title: TranslationService.translate("contact_us"),
              onTap: () => _onItemTap(13),
              isSelected: _selectedItemIndex == 13,
            ),
            DrawerItem(
              icon: Icons.account_circle,
              title: TranslationService.translate("update_app"),
              onTap: () => _onItemTap(14),
              isSelected: _selectedItemIndex == 14,
            ),
            DrawerItem(
              icon: Icons.account_circle,
              title: TranslationService.translate("share_app"),
              onTap: () => _onItemTap(15),
              isSelected: _selectedItemIndex == 15,
            ),
            DrawerItem(
              icon: Icons.account_circle,
              title: TranslationService.translate("logout"),
              onTap: () => _onItemTap(16),
              isSelected: _selectedItemIndex == 16,
            ),
            // Add more DrawerItem widgets for additional items
          ],
        ),
      ),
    ));
  }



  void showLanguagePopup(BuildContext context2) {
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

              final res = await  DialogClass().showPremiumInfoDialog(context2, "Translate Alert!", "Translate to English", "Ok");
                navService.pushNamed("/main_screen" ,args: 0);


              },
              child: Text('English'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString(SharedPrefs.translate, "gu");


                await TranslationService.load('gu');

                final res = await  DialogClass().showPremiumInfoDialog(context2, "Translate Alert!", "Translate to Gujarati", "Ok");

                navService.pushNamed("/main_screen" ,args:0);

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

      final res = await ApiService.create().select_version({});

      print(res.body);

      prefs = await SharedPreferences.getInstance();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if(packageInfo.version.toString().compareTo(res.body["data"][0]["version"].toString()) == 0 || packageInfo.version.toString().compareTo(res.body["data"][0]["version"].toString()) > 0) {

        DialogClass().showPremiumInfoDialog(context,  TranslationService.translate("no_need_updates") , TranslationService.translate("no_need_updates_details"), "Ok");


      }else if(packageInfo.version.toString().compareTo(res.body["data"][0]["version"].toString()) < 0){

       final res = await  DialogClass().showPremiumInfoDialog(context,  TranslationService.translate("update_app") , TranslationService.translate("update_app_details"), "Ok");
       
       if(res == true || res == false){
         
         launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.matrimonial.community_matrimonial_latest2.appa&hl=en_IN"));
         
       }

      }

    }else if(index == 15){


        final String message = '''
Install the Raval Dev Matrimony app on Android & iPhone 👇

https://matrimonial.pioerp.com/uploads/shareapp.html
''';

        Share.share(
          message,
          subject: 'Raval Dev Matrimony App',
        );




    }else if(index == 16){

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