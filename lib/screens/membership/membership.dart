
import 'package:carousel_slider/carousel_slider.dart';
import 'package:community_matrimonial/main.dart';
import 'package:community_matrimonial/network_utils/model/create_order_model.dart';
import 'package:community_matrimonial/network_utils/model/membership_model.dart';
import 'package:community_matrimonial/utils/Colors.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:material_dialogs/material_dialogs.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_utils/Dialogs.dart';
import '../../network_utils/service/api_service.dart';


class Membership extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MembershipStateful(),
    );
  }
}


class MembershipStateful extends StatefulWidget {

  @override
  MembershipScreen createState() => MembershipScreen();

}


class MembershipScreen extends State<MembershipStateful>{

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> MembershipItem = [];

  final Connectivity _connectivity = Connectivity();
  late Stream<ConnectivityResult> _connectionStream;

  @override
  void initState() {
    super.initState();

    _connectionStream = _connectivity.onConnectivityChanged as Stream<ConnectivityResult>;
    _connectionStream.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");
      }
    });


    initMmebership();

  }





  int count = 0;

  initMmebership() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context, listen: false).postMembershipFetch({
      "userId":prefs.getString(SharedPrefs.userId),
      "communityId":prefs.getString(SharedPrefs.communityId),
      "original": "en",
      "translate": [prefs.getString(SharedPrefs.translate)]
    });


    MembershipData model = MembershipData.fromJson(_response.body);
    MembershipOrder order = MembershipOrder();

    if(_response.body["data"][1][0].toString() == "{}") {
       order = MembershipOrder();
    }else{
      order = MembershipOrder.fromJson(_response.body["data"][1][0]["0"]);
    }


    for(int i=0; i<model.data[0][0].length; i++){

      setState(() {
        MembershipItem.add(MembershipCardStateful( membership_model: model.data[0][0][count.toString()]!, order: order,) ,);
        count = count +1;
      });


    }


  }

  @override
  Widget build(BuildContext context) {

   return Scaffold(key: _scaffoldKey,
     appBar: AppBar(
         title: Text('Subscription Plans' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
         toolbarOpacity: 1,
         backgroundColor: Colors.transparent,
         elevation: 0.0,
         leading: IconButton(
           icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
           onPressed: () {

             navService.goBack();

           },
         )),
     body: CarouselSlider(
         items: MembershipItem,
         options: CarouselOptions(
           height: MediaQuery.of(context).size.height*0.9,
           viewportFraction: 1,
           initialPage: 0,
           enableInfiniteScroll: true,
           reverse: false,
           autoPlay: true,
           autoPlayInterval: Duration(seconds: 5),
           autoPlayAnimationDuration: Duration(milliseconds: 800),
           autoPlayCurve: Curves.fastOutSlowIn,
           enlargeCenterPage: true,
           enlargeFactor: 0,
           scrollDirection: Axis.horizontal,
         )
     ),
   );


  }


}



class MembershipCardStateful extends StatefulWidget {

  final MembershipModel membership_model;
  final MembershipOrder order;
  String orderid = "";

  MembershipCardStateful({required this.membership_model , required this.order});

  @override
  MembershipCard createState() => MembershipCard();

}



class MembershipCard extends State<MembershipCardStateful> {

  final apiService = ApiService.create();



  String orderid = "";

  /*Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {




    SharedPreferences prefs = await SharedPreferences.getInstance();

       final _response = await apiService.postVerifyPayment({
         "order_id":orderid,
         "razorpay_payment_id":response.paymentId,
         "razorpay_signature": response.signature
       });

       print(_response.body.toString()+"[[[[]]]]");

       if(_response.body["status"] == "success"){

         print({
           "member_name": prefs.getString(SharedPrefs.fullname),
           "package_name": widget.membership_model.id,
           "payment_method": "RazorPay",
           "amount": widget.membership_model.planPrice,
           "status": "done",
           "code": orderid,
           "date": utils().getTodayDate(),
           "userId": prefs.getString(SharedPrefs.userId),
           "communityId": prefs.getString(SharedPrefs.communityId)
         });

           final _response = apiService.
           postPaidListMemberInsert({
             "member_name": prefs.getString(SharedPrefs.fullname),
             "package_name": widget.membership_model.id,
             "payment_method": "RazorPay",
             "amount": widget.membership_model.planPrice,
             "status": "done",
             "code": orderid,
             "date": utils().getTodayDate(),
             "userId": prefs.getString(SharedPrefs.userId),
             "communityId": prefs.getString(SharedPrefs.communityId)
           });




             Future.delayed(Duration(milliseconds: 500) ,(){
               DialogClass().showDialog2(context , "Success Alert!", "Payment is successfull", "OK");
             });








         

       }else{

       }



    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    DialogClass().showDialog2(context, "Error Alert!", "There is some error occuring during payment please try again" , "OK");

  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }*/

 // Razorpay _razorpay = Razorpay();

  String gender = "";

  @override
  void initState() {
    super.initState();

    initprefs();

    /*_razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);*/

  }

  initprefs() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      gender = prefs.getString(SharedPrefs.gender).toString().toLowerCase();
    });

  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child:Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: MediaQuery.of(context).size.height*0.82,
      margin: EdgeInsets.only(top: 20 , bottom: 20),
      decoration: BoxDecoration(
        color: ColorsPallete.Pink_light.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: ColorsPallete.Pink2,
          width: 0.5,
        ),
      ),
      child:Container(margin: EdgeInsets.only(top: 25 , left: 20)  ,child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

        Container(width: MediaQuery.of(context).size.width  ,child:Text(widget.membership_model.planName, textAlign: TextAlign.left, style: TextStyle(fontSize: 20 , color: ColorsPallete.blue_2),),),

        Container(margin: EdgeInsets.only(top: 15) ,child: Row(children: [ widget.membership_model.planName.toLowerCase() == "complimentary" ? Text("Rs. "+widget.membership_model.planPrice , style: TextStyle(fontSize: 28 , fontWeight: FontWeight.bold , color: ColorsPallete.blue_2),) : Text( gender == "male" ? "Rs. "+widget.membership_model.planPrice.split(",")[0] : "Rs. "+widget.membership_model.planPrice.split(",")[1] , style: TextStyle(fontSize: 28 , fontWeight: FontWeight.bold , color: ColorsPallete.blue_2),) , Text(" /"+widget.membership_model.validityDays+" days" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold , color: ColorsPallete.greyColor)) ],),),

        Container(margin: EdgeInsets.only(top: 15) , width: MediaQuery.of(context).size.width  ,child:Text(widget.membership_model.details, textAlign: TextAlign.left, style: TextStyle(fontSize: 16 , color: Colors.black87),),),

        Container(margin: EdgeInsets.only(top: 15 ,right: 20) , width: MediaQuery.of(context).size.width*0.9, height: 0.7, color: ColorsPallete.blue_2,),

          Container(margin: EdgeInsets.only(top: 35) ,child: Row(children: [ Image.asset("assets/images/green_tick.png", width: 20, height: 20,), SizedBox(width: 20,) ,Text("Unlimited Profile Views" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: ColorsPallete.blue_2),) ],),),

          Container(margin: EdgeInsets.only(top: 8) ,child: Row(children: [ Image.asset("assets/images/green_tick.png", width: 20, height: 20,), SizedBox(width: 20,) ,Text("View Gallery Photos" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: ColorsPallete.blue_2),) ],),),

        Container(margin: EdgeInsets.only(top: 8) ,child: Row(children: [ Image.asset("assets/images/green_tick.png", width: 20, height: 20,), SizedBox(width: 20,) ,Text("Express Interest to "+widget.membership_model.numberExpressInterest+" Members" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: ColorsPallete.blue_2),) ],),),

        Container(margin: EdgeInsets.only(top: 8) ,child: Row(children: [ Image.asset("assets/images/green_tick.png", width: 20, height: 20,), SizedBox(width: 20,) ,Text("Shortlist upto 35 Members" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: ColorsPallete.blue_2),) ],),),

        Container(margin: EdgeInsets.only(top: 8) ,child: Row(children: [ Image.asset("assets/images/green_tick.png", width: 20, height: 20,), SizedBox(width: 20,) ,Text("Access "+widget.membership_model.numberContacts+" Contacts" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: ColorsPallete.blue_2),) ],),),

/*        Container(margin: EdgeInsets.only(top: 8) ,child: Row(children: [ Image.asset("assets/images/green_tick.png", width: 20, height: 20,), SizedBox(width: 20,) ,Text("Access "+widget.membership_model.numberHoroscope+" Horoscopes" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: ColorsPallete.blue_2),) ],),),

        Container(margin: EdgeInsets.only(top: 8) ,child: Row(children: [ Image.asset("assets/images/green_tick.png", width: 20, height: 20,), SizedBox(width: 20,) ,Text("Chat Access" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: ColorsPallete.blue_2),) ],),),

         Container(margin: EdgeInsets.only(top: 8) ,child: Row(children: [ Image.asset("assets/images/green_tick.png", width: 20, height: 20,), SizedBox(width: 20,) ,Text("Video Calls with "+widget.membership_model.numberVideo+"Members" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: ColorsPallete.blue_2),) ],),),

          Container(margin: EdgeInsets.only(top: 8) ,child: Row(children: [ Image.asset("assets/images/green_tick.png", width: 20, height: 20,), SizedBox(width: 20,) ,Text("Pdf access upto "+widget.membership_model.numPdfAccess+" Members" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: ColorsPallete.blue_2),) ],),),*/

          Expanded(flex: 1 ,child: Container()),
          Container(alignment: Alignment.bottomCenter , width: MediaQuery.of(context).size.width , margin: EdgeInsets.only(bottom: 20 ,right: 20)  ,child:ElevatedButton(
            onPressed: () async {


              print(await utils().isvalidFreeDate().toString()+"-=-=-");

              if(await utils().isvalidFreeDate() == false) {

                if (widget.order.packageName != null) {

                  DialogClass().showDialog2(context, "Membership Plan",
                      "You Already subscribed to one of the packages ,if you need to update Please contact support",
                      "Ok");

                } else {
                  SharedPreferences prefs2 = await SharedPreferences
                      .getInstance();


                  String userId = prefs2.getString(SharedPrefs.userId)
                      .toString();
                  String communityId = prefs2.getString(SharedPrefs.communityId)
                      .toString();

                  launchUrl(Uri.parse(
                      "https://matrimonial.pioerp.com/payment_options?userId=" +
                          userId + "&communityId=" + communityId + "&admin=0"));

                  // _razorpay.open(options);

                }

              }else{


                DialogClass().showDialog2(context, "Free Membership",
                    "You are under free membership , so no need to upgrade",
                    "Ok");


              }



            },
            style: ElevatedButton.styleFrom(

              backgroundColor: ColorsPallete.Pink2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side:  widget.order != "{}" && widget.order.packageName.toString() == widget.membership_model.id.toString() ?
                BorderSide(width: 4) : BorderSide(width: 0)
              ),


            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child:Container(width: MediaQuery.of(context).size.width*0.6 ,child: Text(
                widget.order != "{}" && widget.order.packageName.toString() == widget.membership_model.id.toString() ? "Your Selected Package"   : 'Upgrade Membership',
               textAlign: TextAlign.center , style: TextStyle(fontSize: 18 , color: Colors.white),
              ),
            ),),
          ),),



        ],
      ),
    ))) ;
  }

  @override
  void dispose() {
    // Cancel any active work here
    // For example, if there are any ongoing asynchronous operations, cancel them here
    super.dispose();
  }

}
