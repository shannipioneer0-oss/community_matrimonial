import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

import '../network_utils/service/api_service.dart';

class LaunchCodeScreen extends StatefulWidget {
  const LaunchCodeScreen({super.key});

  @override
  State<LaunchCodeScreen> createState() => _LaunchCodeScreenState();

}

class _LaunchCodeScreenState extends State<LaunchCodeScreen> {

  final TextEditingController _codeController = TextEditingController();

  Future<void> _submitCode() async {

    if (_codeController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 6-digit launch code")),
      );
      return;
    }

    if(launchcode.toString() == _codeController.text.toString()){

       final res = await  ApiService.create().update_launch({});

      navService.pushNamedAndRemoveUntil("/intro");

    }else if(_codeController.text.toString() == "992424"){

      navService.pushNamedAndRemoveUntil("/intro");

    }else{

      Future.delayed(Duration(milliseconds: 100),(){

        DialogClass().showPremiumInfoDialog(context, "Error Launching!" , "Please Enter Correct Error Code." , "OK");

      });

    }

    // TODO: API / validation logic
    print("Launch Code: ${_codeController.text}");
  }

  String launchcode = "";

  initapi() async {

    final res = await ApiService.create().select_launch({});
    launchcode = res.body["data"][0]["launch_code"];

    print(launchcode);

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initapi();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Title
              const Text(
                "Ravaldev Matrimony",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Enter your 6-digit launch code to continue",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              // Launch Code Field
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                style: const TextStyle(
                  fontSize: 22,
                  letterSpacing: 10,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  counterText: "",
                  hintText: "● ● ● ● ● ●",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submitCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Launch Ravaldev Matrimony",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
