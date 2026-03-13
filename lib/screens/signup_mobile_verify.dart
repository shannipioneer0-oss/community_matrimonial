
import 'dart:async';
import 'dart:math';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import '../app_utils/Dialogs.dart';
import '../app_utils/TextFieldWithImage.dart';
import '../network_utils/model/get_otp.dart';
import '../network_utils/service/api_service.dart';
import '../utils/Colors.dart';
import '../utils/Strings.dart';
import '../utils/universalback_wrapper.dart';
import '../utils/utils.dart';
import 'OtpFields.dart';



class SignupMobileVerifyApp extends StatelessWidget {

  final List list;
  SignupMobileVerifyApp(this.list);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignupMobileVerifyAppStateful(mobile_number: list,),
    );
  }


}


class SignupMobileVerifyAppStateful extends StatefulWidget {

  final List mobile_number;

  SignupMobileVerifyAppStateful( {required this.mobile_number});

  @override
  SignupScreenVerify createState() => SignupScreenVerify();

}


class SignupScreenVerify extends State<SignupMobileVerifyAppStateful> {




  final TextEditingController _otpController = TextEditingController();
  final FocusNode _firstFocusNode = FocusNode();
  final FocusNode _secondFocusNode = FocusNode();
  final FocusNode _thirdFocusNode = FocusNode();
  final FocusNode _fourthFocusNode = FocusNode();
  final FocusNode _fifthFocusNode = FocusNode();
  final FocusNode _sixFocusNode = FocusNode();


  String otp_values = "" , otp_value = "" , otp = "";

  @override
  void initState() {
    super.initState();

    otp = widget.mobile_number[8];
    print(widget.mobile_number[8]);

    initGetOtp();
    startTimer();

  }

  initSendSms(String otp) async {


    print(widget.mobile_number[1]);

    //if(widget.mobile_number[1] == "1") {

      print(widget.mobile_number[1]+"-=-=-=");

      final responseSendSms = await http.get(Uri.parse(
          "http://piosys.co.in/SendSMS.aspx?UserName=shah.shanni2010@gmail.com&Password=Shanni9898100385&SenderId=COMMSG&Message=Dear Member " +
              widget.mobile_number[8] +
              " Verification Code For Community Matrimonial Mobile Application For Raval samaj  Use it to Proceed... PS&MobileNo=" +
              widget.mobile_number[0] +
              "&EntityId=1701158046859603415&TemplateId=1707162823932242380"));

      print(responseSendSms.body);

   // }


  }


  initGetOtp() async {



    setState(() {
     // otp_values = widget.mobile_number[8];
    });

    initSendSms(otp.toString());

    /* final res = await DialogClass().showDialogBeforesubmit(context, "OTP " , "Your OTP is "+getotp.message[0].otp.toString() , "Copy" , "1");

    if(res != null) {

      WidgetsBinding.instance.addPostFrameCallback((_) =>

      setState(() {
        otp_values = getotp.message[0].otp.toString();
      })

      );


    }*/

  }

  int _seconds = 60;            // countdown duration
  Timer? _timer;
  bool _canResend = false;


  void startTimer() {

    _canResend = false;
    _seconds = 60;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _seconds--;
        });
      }
    });

  }


  String generateRandomDigits(int length) {

    Random random = Random();
    String digits = '';
    for (int i = 0; i < length; i++) {
      digits += random.nextInt(10).toString(); // Generates a single digit (0-9)
    }

    return digits;
  }


  String getProfileId() {
    // First three letters of the alphabet
    String letters = 'ABC';

    // Length of the digits to be appended
    int digitLength = 3;

    // Generating the numeric part
    String digits = generateRandomDigits(digitLength);

    // Combine letters and digits
    return letters + digits;
  }

  String generateOtp() {
    final random = Random();
    const min = 100000; // Smallest 6-digit number
    const max = 999999; // Largest 6-digit number

    int otp = min + random.nextInt(max - min + 1);
    return otp.toString();
  }

  void resend() {
    // TODO: Add your resend logic here
    print("Resend clicked");

    otp =  generateOtp();
    initGetOtp();

    startTimer(); // restart countdown after resend
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return UniversalBackWrapper(
        isRoot: false ,

        child:Scaffold(

        body:SingleChildScrollView(child:Container(color: Colors.white , height: MediaQuery.of(context).size.height  ,child:Stack(
            fit: StackFit.expand,
            alignment: Alignment.topCenter,
            children: [
              // Background Image
              Image.asset( 'assets/images/image_top_edit_two.png' ,
                height: MediaQuery.of(context).size.height*0.4,
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              ),

              Positioned(top: MediaQuery.of(context).size.height*0.4 , left:MediaQuery.of(context).size.width*0.17 ,child: Text("VERIFY" , style: TextStyle(color: Colors.pink , fontSize:18 , fontWeight: FontWeight.w700 ),)),
              Positioned(top: MediaQuery.of(context).size.height*0.36 , left:MediaQuery.of(context).size.width*0.65 ,child: Image.asset("assets/images/heart.png" , width: 45 , height: 45, color: Colors.pink,),),
              Positioned(top: MediaQuery.of(context).size.height*0.45, left:MediaQuery.of(context).size.width*0.1 ,child: Text( textAlign: TextAlign.left  ,"Verify Mobile Number : "+widget.mobile_number[0] , style: TextStyle(color: Colors.black87 , fontSize:15 , fontWeight: FontWeight.w700 ),)),

              Positioned(top: MediaQuery.of(context).size.height*0.54 ,child: Card(
                elevation: 8.0, // Set the elevation for the embossed effect
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Set the border radius
                  side: BorderSide(
                    color: Colors.grey[300]!, // Set the border color
                    width: 1.0, // Set the border width
                  ),
                ),
                child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    margin: EdgeInsets.only(left: 15 , right: 15),
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left:5 , top:15 , bottom: 5),

                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          Strings.verify_label ,
                          style: TextStyle(
                            fontSize: 16.0 ,
                            fontWeight: FontWeight.bold ,
                          ),
                        ),
                        Container(margin:EdgeInsets.only(top:10)   ,child: otp_values.isEmpty ? OtpFields(callback: (p0) {


                          otp_value = p0;
                          print(p0);


                        }, otp: otp_values,) : OtpFields(callback: (p0) {


                          otp_value = p0;
                          print(p0);


                        }, otp: otp_values,), ),

                        Container(width: MediaQuery.of(context).size.width*0.8  ,child:Column(crossAxisAlignment: CrossAxisAlignment.center  ,children: [

                          Text(
                            _canResend ? "You can resend now" : "Resend in $_seconds seconds", textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: _canResend ? resend : null,
                            child: Text("Resend"),
                          ),

                          SizedBox(height: 5),

                        ],),),



                        Row(children: [

                          Expanded(flex: 1 ,child: GestureDetector(onTap:() async {




                            if(otp_value.length == 6) {


                              SVProgressHUD.show(status: 'Verifying OTP Please Wait....');
                              if (otp_value == widget.mobile_number[8]) {
                                final flavor = FlavorConfig.instance.name;


                                print({ "name": widget.mobile_number[1],
                                  "surname": widget.mobile_number[2],
                                  "emailid": widget.mobile_number[7].isEmpty
                                      ? "-"
                                      : widget.mobile_number[7],
                                  "password": "",
                                  "gender": widget.mobile_number[6],
                                  "birthdate": widget.mobile_number[5] + "-" +
                                      widget.mobile_number[4] + "-" +
                                      widget.mobile_number[3],
                                  "mobile": widget.mobile_number[0],
                                  "profile_id": getProfileId(),
                                  "community_id": flavor == "appA" ? "20" : "2",
                                  "community_name": flavor == "appA"
                                      ? "SAMAST GUJARAT RAVAL DEV"
                                      : "BJP Matrimony",
                                  "mobile_reg_token": "",
                                  "web_reg_token": "",
                                  "joined_date": utils().getTodayDate(),
                                  "otp": widget.mobile_number[8]});


                                final _response = await Provider.of<ApiService>(
                                    context, listen: false).postRegisteration(
                                    { "name": widget.mobile_number[1],
                                      "surname": widget.mobile_number[2],
                                      "emailid": widget.mobile_number[7].isEmpty
                                          ? "-"
                                          : widget.mobile_number[7],
                                      "password": "",
                                      "gender": widget.mobile_number[6],
                                      "birthdate": widget.mobile_number[5] +
                                          "-" + widget.mobile_number[4] + "-" +
                                          widget.mobile_number[3],
                                      "mobile": widget.mobile_number[0],
                                      "profile_id": getProfileId(),
                                      "community_id": flavor == "appA"
                                          ? "20"
                                          : "2",
                                      "community_name": flavor == "appA"
                                          ? "SAMAST GUJARAT RAVAL DEV"
                                          : "BJP Matrimony",
                                      "mobile_reg_token": "",
                                      "web_reg_token": "",
                                      "joined_date": utils().getTodayDate(),
                                      "otp": widget.mobile_number[8]});

                                print(_response.body);

                                SVProgressHUD.dismiss();

                                if (_response.body["data"].length >= 1) {
                                  if (_response.body["data"][0]["success"]
                                      .toString() == "1") {

                                    DialogClass().showPremiumInfoDialog(context, "Signed Up Alert!" , "Signed up Succesfully" , "OK");
                                    navService.pushNamed("/login");


                                  } else
                                  if (_response.body["data"][0]["success"]
                                      .toString() == "0") {
                                    DialogClass().showDialog2(
                                        context, "Login Validation",
                                        "Mobile number you provided is already registered",
                                        "OK");
                                  }
                                }
                              } else {

                                SVProgressHUD.dismiss();
                                DialogClass().showAlertDialogChangeNumber(
                                    context, "OTP Verification Alert!",
                                    "No Such OPT exists");

                              }
                            }else{


                              DialogClass().showPremiumInfoDialog(context, "OTP Verification Alert!" , "Otp Not Entered" , "OK");



                            }




                          },child:RoundedContainer(text: Strings.verify, color: ColorsPallete.blue_2),)),
                          SizedBox(width: 10),
                          Expanded(flex: 1 ,child: GestureDetector(onTap:(){



                          },child:RoundedContainer(text: Strings.resend , color: ColorsPallete.Pink),))


                        ],),
                        SizedBox(height: 15),

                      ],)


                ),
              )),

              Positioned(top: MediaQuery.of(context).size.height*0.48, left:MediaQuery.of(context).size.width*0.20    ,child: ElevatedButton(onPressed: (){

                navService.goBack();

              }, child: Text("Change Mobile Number"))),



            ]))


        )));



  }




}