import 'dart:convert';

import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/network_utils/model/faqs.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Faqs {
  late final String question;
  late final String answer;
  late final String communityId;

  Faqs(this.question , this.answer);

}


class FaqsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FaqsScreens(),
      ),
    );
  }

}







class FaqsScreens extends StatefulWidget {

  @override
  FaqsScreensState createState() => FaqsScreensState();

}






class FaqsScreensState extends State<FaqsScreens> {

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

    initAboutusApi();

  }

  FAQModel? faqModel;

  List<Faqs> listfaqs = [];


  initAboutusApi() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context , listen: false).
    postAboutCommunity({
      "type":"faqs",   //about , contact , chief_members , privacy_policy , refund_policy , faqs
      "communityId": prefs.getString(SharedPrefs.communityId),
      "original": "en",
      "translate": ["en"]
    });

     print(_response.body.toString());


    setState(() {

      faqModel = FAQModel.fromJson(_response.body);

      faqModel!.data.forEach((faqGroup) {
        faqGroup.forEach((key, faq) {

          listfaqs.add(new Faqs(faq.question , faq.answer));

        });
      });

    });


  }



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('FAQs' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
            toolbarOpacity: 1,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
              onPressed: () {

                navService.goBack();

              },
            )),
        body: ListView.builder(
          itemCount: listfaqs.length,
          itemBuilder: (context, index) {
            final member = listfaqs[index];
            return   Card( margin: EdgeInsets.all(5),
                child:ListTile(

             title: Text(member!.question ,style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.pink),),
             subtitle: Text(member!.answer ,style: TextStyle(fontSize: 16 , color: Colors.black87),),

            ));



          },
        ),
      ),
    );

  }






}
