import 'dart:math';

import 'package:community_matrimonial/locale/TranslationService.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/OtpFields.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_utils/TextFieldWithImage.dart';



class ProfileDetailItem extends StatelessWidget {
  final String label;
  final String value;
  String? verify_email;
  String? isrequired;

  ProfileDetailItem({required this.label, required this.value , this.verify_email ,this.isrequired});



  @override
  Widget build(BuildContext context) {


    String email_verify = "0";



    return StatefulBuilder(builder: (context, setState) {

      WidgetsBinding.instance.addPostFrameCallback((_) async {

        SharedPreferences prefs = await SharedPreferences.getInstance();

        setState((){

          email_verify = prefs.getString(SharedPrefs.verify_email).toString();

        });



      });



      return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isrequired == "1" ? Text("* " ,style: TextStyle(color: Colors.red , fontWeight: FontWeight.bold),): Container(),
            Container(
              width: MediaQuery.of(context).size.width*0.4,
              child: label != TranslationService.translate("email_key") ? Text(
                '$label',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: ColorsPallete.blue_2,
                ),
              ) : Column(crossAxisAlignment: CrossAxisAlignment.start  ,children: [ Text(
                '$label ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: ColorsPallete.blue_2,
                ),
              )  ,  GestureDetector(onTap: () async {

                SharedPreferences prefs = await SharedPreferences.getInstance();


                if(email_verify == "0" ||  verify_email == "0") {

                  Random random = Random();
                  String otp = '', otp_values = "";
                  for (int i = 0; i < 6; i++) {
                    otp += random.nextInt(10)
                        .toString(); // Append a random digit (0-9)
                  }


                  final smtpServer = gmail('shah.shanni2010@gmail.com',  'Shanni989810038520101990');
                  final message = Message()
                    ..from = Address('shah.shanni2010@gmail.com' , 'shah shanni')
                    ..recipients.add(value)
                    ..subject = 'Email Verification from Community Matrimonial'
                    ..text = 'Hi this is email verification from Community Matrimonial Otp to verify is ' + otp
                    ..html = '<h1>Hi this is email verification from Community Matrimonial Otp to verify is </h1>'+otp;


                  try {
                    await send(message , smtpServer);
                    final _response = await Provider.of<ApiService>(
                        context, listen: false).postUpdateEmailVerify({
                      "otp": otp,
                      "userId": prefs.getString(SharedPrefs.userId)
                    });

                    if (_response.body["data"]["affectedRows"] == 1) {
                      showDialog(context: context, builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Optional: Rounded corners
                          ),
                          insetPadding: EdgeInsets.all(15),
                          child: Card(
                            elevation: 8.0,
                            // Set the elevation for the embossed effect
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              // Set the border radius
                              side: BorderSide(
                                color: Colors.grey[300]!,
                                // Set the border color
                                width: 1.0, // Set the border width
                              ),
                            ),
                            child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.45,
                                margin: EdgeInsets.only(left: 3, right: 3),
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(
                                    left: 5, top: 15, bottom: 5),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      Strings.verify_label_emailid +
                                          " by entering otp sent to your emailid",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(margin: EdgeInsets.only(top: 10),
                                        child: OtpFields(callback: (p0) {
                                          otp_values = p0;
                                          print(p0);
                                        }, otp: otp_values,)),

                                    Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.9,
                                      margin: EdgeInsets.only(
                                          right: 15, bottom: 15, top: 10),
                                      child: Text(Strings.timer_pass,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: ColorsPallete.greyColor),),
                                    ),
                                    Row(children: [

                                      Expanded(flex: 1,
                                          child: GestureDetector(
                                            onTap: () async {
                                              SVProgressHUD.show(
                                                  status: 'Verifying OTP Please Wait....');

                                              final _response = await Provider
                                                  .of<ApiService>(
                                                  context, listen: false)
                                                  .verifyOtpEmail(
                                                  {
                                                    "userId": prefs.getString(
                                                        SharedPrefs.userId),
                                                    "otp": otp_values
                                                  }
                                              );

                                              print(_response.body);

                                              if (_response.body["data"] ==
                                                  "success") {
                                                SVProgressHUD.dismiss();
                                                Navigator.of(context).pop();

                                                prefs.setString(
                                                    SharedPrefs.verify_email,
                                                    "1");

                                                setState(() {
                                                  email_verify =
                                                      prefs.getString(
                                                          SharedPrefs
                                                              .verify_email)
                                                          .toString();
                                                },);
                                              }
                                            },
                                            child: RoundedContainer(
                                                text: Strings.verify,
                                                color: ColorsPallete.blue_2),)),
                                      SizedBox(width: 10),
                                      Expanded(flex: 1,
                                          child: GestureDetector(onTap: () {


                                          },
                                            child: RoundedContainer(
                                                text: Strings.resend,
                                                color: ColorsPallete.Pink),))


                                    ],),
                                    SizedBox(height: 15),

                                  ],)


                            ),
                          ),);
                      },);
                    }


                    print('Email sent successfully!');
                  } catch (error) {
                    print('Failed to send email: $error');
                  }
                }


              } ,child:Text(
                email_verify == "0" ? '' : "",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    decoration: TextDecoration.underline, // Adds underline
                    decorationColor: ColorsPallete.blue_2, // Color of the underline
                    decorationStyle: TextDecorationStyle.solid,
                    decorationThickness: 3
                ),
              ))],)  ,
            ),
            Text(":  "),
            Expanded(
              child: Text(
                value == "null" ? "" : value,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );

    },);
  }
}