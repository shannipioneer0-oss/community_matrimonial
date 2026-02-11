

import 'dart:async';

import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/screens/user_profile/CustomTextField.dart';
import 'package:community_matrimonial/screens/user_profile/MultilineTextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:no_context_navigation/no_context_navigation.dart';


class DialogClass {




  Future<bool> showPremiumInfoDialog(BuildContext context , String title , String message , String okbutton) async {

   return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.error_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                     Text(
                      title ,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                 Text(
                  message,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {

                         Navigator.pop(context , false);

                      },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:  Text(okbutton),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

  }

  Future<bool> showPremiumInfoDialog2(BuildContext context , String title , String message , String okbutton) async {

    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.error_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title ,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {

                      Navigator.pop(context , false);

                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:  Text(okbutton),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

  }

  void showDialog2(BuildContext context, String title, String msg, String btntext1)  {



    Dialogs.materialDialog(
        msg: msg,
        title: title,
        color: Colors.white,
        context: context,
        onClose: (value) => print("returned value is '$value'"),
        actions: [
          IconsOutlineButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop("value");
            },
            text: btntext1,
            iconData: Icons.info,
            textStyle: TextStyle(color: Colors.green),
            iconColor: Colors.green,
          ),

        ]);

  }



  void showDialog4(BuildContext context, String title, String msg, String btntext1) {

    showDialog(
      context: context,
      barrierDismissible: false,  // Disable dismissing by tapping outside or back press
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
          // Returning false prevents back press from dismissing the dialog
          return Future.value(false);
        },
        child: AlertDialog(
          title: Text(title),
          content: Text(msg),
        ));
      },
    );

  }



  void showDialog3(BuildContext context, String title, String msg, String btntext1) {

   /* Dialogs.materialDialog(
        msg: msg,
        title: title,
        color: Colors.white,
        context: context,
        barrierDismissible: false,
        useRootNavigator: false,
        onClose: (value) => print("returned value is '$value'"),
        actions: [
          IconsOutlineButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop("value");
              navService.pushNamed("/membership");
            },
            text: btntext1,
            iconData: Icons.info,
            textStyle: TextStyle(color: Colors.green),
            iconColor: Colors.green,
          ),

        ]);
*/


    showDialog(
      context: context,
      barrierDismissible: false,  // Disable dismissing by tapping outside or back press
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              // Returning false prevents back press from dismissing the dialog
              return Future.value(false);
            },
            child: AlertDialog(
              title: Text(title),
              content: Text(msg),
                actions: [
                  IconsOutlineButton(
                    onPressed: () {

                      Navigator.of(context, rootNavigator: true).pop("value");
                      navService.pushNamed("/membership");

                    },
                    text: btntext1,
                    iconData: Icons.info,
                    textStyle: TextStyle(color: Colors.green),
                    iconColor: Colors.green,
                  ),

                ]
            ));
      },

    );



  }


  showDailogwithTextField(BuildContext context, String title , String btntext1 , String labeltext_textfield , IconData icon ,Function(String) onValueReturned){

    TextEditingController controller = TextEditingController();

    Dialogs.materialDialog(
        title: title,
        color: Colors.white,
        customView: Container(padding: EdgeInsets.only(left: 20 ,right: 20)  ,child:CustomTextField(icondata: icon , controller: controller , labelText:labeltext_textfield, enabled: false,),),
        customViewPosition: CustomViewPosition.BEFORE_ACTION,
        context: context,
        onClose: (value) => print("returned value is '$value'"),
        actions: [
          IconsOutlineButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              onValueReturned(controller.text.toString());
            },
            text: btntext1,
            iconData: Icons.info,
            textStyle: TextStyle(color: Colors.green),
            iconColor: Colors.green,
          ),

        ]);


  }




   showDialogBeforesubmit(BuildContext context, String title, String msg, String btntext1 , String type) {


    Completer completer = Completer();

    Dialogs.materialDialog(
        msg: msg,
        title: title,
        color: Colors.white,
        context: context,
        onClose: (value) => print("returned value is '$value'"),
        actions: [
          IconsOutlineButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(type);
              completer.complete(type);
            },
            text: btntext1,
            iconData: Icons.info,
            textStyle: TextStyle(color: Colors.green),
            iconColor: Colors.grey,
          ),

          IconsOutlineButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            text: "Cancel",
            iconData: Icons.cancel,
            textStyle: TextStyle(color: Colors.red),
            iconColor: Colors.grey,
          ),


        ]);

    return completer.future;
  }



  static  TextEditingController comments = TextEditingController();
  showDialogBeforeAcceptReject(BuildContext context, String title, String msg, String btntext1 , String btntext2 , String btntext3) {


    Completer completer = Completer();


    Dialogs.materialDialog(
        msg: msg,
        title: title,
        color: Colors.white,
        context: context,
        onClose: (value) => print("returned value is '$value'"),
        customView: Container(margin: EdgeInsets.only(left:15 ,right: 15 ,top: 15)  ,child:MultilineTextfield(icondata: Icons.comment, controller: comments, labelText: "Enter Comments", enabled: false, minlines: 2, maxlines: 5),),
        customViewPosition: CustomViewPosition.BEFORE_MESSAGE,

        actions: [
          IconsOutlineButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(btntext1);
              completer.complete(btntext1);
            },
            text: btntext1,
            textStyle: TextStyle(color: Colors.green),
            iconColor: Colors.grey,
          ),

          IconsOutlineButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              completer.complete(btntext2);
            },
            text: btntext2,
            textStyle: TextStyle(color: Colors.red),
            iconColor: Colors.grey,
          ),


          IconsOutlineButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              completer.complete(btntext3);
            },
            text: btntext3,
            textStyle: TextStyle(color: Colors.red),
            iconColor: Colors.grey,
          ),


        ]);

    return completer.future;
  }




  void showNoInternetAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Internet Connection"),
          content: Text("Please check your internet connection."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void showCustomProgressDialog(BuildContext context) async {


    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CupertinoActivityIndicator(color: Colors.pink ,radius: 20),
          ),
        ),
      ),
    );

    // Simulate some work (replace this with your actual work

    // Dismiss the dialog after the task is completed

  }


}




















class CustomProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.pink,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 16.0),
            Text(
              'Please wait...',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

