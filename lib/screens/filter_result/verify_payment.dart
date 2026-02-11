import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/SharedPrefs.dart';

class ImageApprovalCard {


  void showImageApprovalDialog(BuildContext context2, String imageUrl , String payment_method ,String userId) {
    showDialog(
      context: context2,
      barrierDismissible: false, // prevent outside click
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

               Align(alignment: Alignment.topRight  ,child:Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )),

                SizedBox(height: 10,),

                // Title
                 Text(
                  "Payment Method : "+payment_method,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                  ),
                ),

                const SizedBox(height: 16),

                // Image
                payment_method.toLowerCase() != "bank transfer"  ? Container(child: InteractiveViewer(
        panEnabled: true,        // allow dragging
        scaleEnabled: true,      // allow pinch zoom
        minScale: 0.5,           // zoom out limit
        maxScale: 4.0,           // zoom in limit
        child:ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    height: MediaQuery.of(context).size.height*0.55,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),),) : Text(
                  "Payment Method is bank transfer .so may be reciept is not available",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                  ),
                ),

                 SizedBox(height: 20),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    // Reject
                    ElevatedButton.icon(
                      onPressed: () async {


                        final res1 = await DialogClass().showPremiumInfoDialog(context , "Reject Payment" , "Are you sure you want to reject payment" , "Ok");

                        if(res1 == true || res1 == false) {
                          SharedPreferences prefs2 = await SharedPreferences
                              .getInstance();
                          String communityId = prefs2.getString(SharedPrefs
                              .communityId).toString();

                          final res = await ApiService.create()
                              .verify_payment_admin({
                            "userId": userId,
                            "communityId": communityId,
                            "isverify": "2"
                          });

                          print(res.body);

                          if (res.body["data"]["affectedRows"] == 1) {
                            ScaffoldMessenger.of(context2).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Payment Found Illegal ,Rejected"),
                                duration: Duration(seconds: 3),
                              ),
                            );

                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                          }

                        }
                        print("Rejected");
                      },
                      icon: const Icon(Icons.close ,color: Colors.white, ),
                      label: const Text("Reject" ,style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),

                    // Accept
                    ElevatedButton.icon(
                      onPressed: () async {


                        final res1 = await DialogClass().showPremiumInfoDialog(context , "Accept Payment" , "Are you sure you want to Verify and accept the payment" , "Ok");

                        if(res1 == true || res1 == false) {
                          SharedPreferences prefs2 = await SharedPreferences
                              .getInstance();
                          String communityId = prefs2.getString(SharedPrefs
                              .communityId).toString();

                          final res = await ApiService.create()
                              .verify_payment_admin({
                            "userId": userId,
                            "communityId": communityId,
                            "isverify": "1"
                          });

                          print(res.body);

                          if (res.body["data"]["affectedRows"] == 1) {
                            ScaffoldMessenger.of(context2).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Payment Found Valid , Hence Verified"),
                                duration: Duration(seconds: 3),
                              ),
                            );

                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                          }
                        }

                      },
                      icon: const Icon(Icons.check ,color: Colors.white,),
                      label: const Text("Accept", style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
