


import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

class VerifyScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VerifyScreenStateful(),
      builder: EasyLoading.init(),

    );
  }
}


class VerifyScreenStateful extends StatefulWidget {

  @override
  VerifyScreenState createState() => VerifyScreenState();

}

class VerifyScreenState  extends State<VerifyScreenStateful>{
  
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Verification' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
        toolbarOpacity: 1,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
          onPressed: () {

            navService.goBack();

          },
        )),
      body: Container(height: MediaQuery.of(context).size.height ,padding: EdgeInsets.all(10) , child: Center( child: Column(children: [


        ElevatedButton(
          onPressed: () {

            navService.pushNamed("/verifyimagelist");

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding inside the button
          ),
          child: Text('Verify Photos'),
        ),
        SizedBox(height: 20,),
        ElevatedButton(
          onPressed: () {

            navService.pushNamed("/verifydoclist");

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding inside the button
          ),
          child: Text('Verify Documents'),
        ),




      ],),)),
    );





    
  }
  
  
  
  
  
}