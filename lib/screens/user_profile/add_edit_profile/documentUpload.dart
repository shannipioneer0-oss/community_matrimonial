

import 'dart:io';

import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/ImagePicker.dart';
import 'package:community_matrimonial/network_utils/model/proofs.dart';
import 'package:community_matrimonial/screens/user_profile/FancyBorderDashedImage.dart';
import 'package:community_matrimonial/screens/user_profile/FancyBorderedImage.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../network_utils/service/api_service.dart';

class DocumentsUpload extends StatelessWidget {

  final String type;
  DocumentsUpload({required this.type});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Documentsuploadstateful(type),
      builder: EasyLoading.init(),
    );
  }

}


class Documentsuploadstateful extends StatefulWidget {

  final String type;
  Documentsuploadstateful(this.type);

  @override
  Documentsuploadscreen createState() => Documentsuploadscreen();

}

class Documentsuploadscreen  extends State<Documentsuploadstateful>{

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String imagepath1 = "" ,  imagepath2 = "" , imagepath3 = "" ;
  List<String> listimagesPath = [];
  List<String> listimageuploadpath = [];
  List<String> listimage = ["0" ,"0" ,"0"];

  String path1 = "" , path2 = "" , path3 = "" ,update_id = "";
  String isverifyPic1 = "0" ,isverifyPic2 = "0" ,isverifyPic3 = "0";

  String getFileName(File file)  {
    String fileName = Uri.file(file.path).pathSegments.last;
    return fileName;
  }

  late ConnectivityResult _connectivityResult;
  @override
  void initState() {
    super.initState();

    EasyLoading.dismiss();

   initProofs();
   initLoader();

  }


  initLoader(){

    EasyLoading.instance
      ..displayDuration =const Duration(milliseconds: 4000)
      ..loadingStyle =EasyLoadingStyle.custom //This was missing in earlier code
      ..backgroundColor = Colors.red
      ..textColor = Colors.white
      ..indicatorColor = Colors.white
      ..maskColor = Colors.red
      ..indicatorType = EasyLoadingIndicatorType.hourGlass
      ..dismissOnTap = false
      ..userInteractions = false;

  }


 late  SharedPreferences prefs ;

  initProofs() async {

     prefs = await SharedPreferences.getInstance();

    setState(() {
      path1 = prefs.getString(SharedPrefs.id_proof) ?? "null";
      path2 = prefs.getString(SharedPrefs.education_proof) ?? "null";
      path3 = prefs.getString(SharedPrefs.income_proof) ?? "null";
    });

    print(path1+"-----========");


    final _response = await Provider.of<ApiService>(context, listen: false)
        .fetch_pictures(
        {
          "type": "proofs",
          "userId":prefs.getString(SharedPrefs.userId),                   // blog , caste , roles , all_staff
          "communityId": prefs.getString(SharedPrefs.communityId),
          "original": "en",
          "translate": ["en"]
        }
    );

    print(_response.body);

    Proofs proofs = Proofs.fromJson(_response.body);

    setState(() {

      isverifyPic1 =  proofs.data[0].isIdVerify.toString();
      isverifyPic2 =  proofs.data[0].isEducationVerify.toString();
      isverifyPic3 =  proofs.data[0].isIncomeVerify.toString();

      update_id = proofs.data[0].id.toString();

    });



  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(key: _scaffoldKey,
    appBar: AppBar(
    title: Text('Upload Documents\nRavaldev Matrimony' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
    toolbarOpacity: 1,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: IconButton(
    icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
    onPressed: () {

      navService.goBack();

    },
    ),
      actions: [
        ElevatedButton.icon(
          onPressed: () async {



            ConnectivityResult result = await Connectivity().checkConnectivity();
            setState(() {
              _connectivityResult = result;
            });
    if (_connectivityResult == ConnectivityResult.none) {
    DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");
    }else {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      print(listimagesPath.join(",")+"-----"+prefs.getString(SharedPrefs.id_proof).toString());

      if (!prefs.getString(SharedPrefs.id_proof).toString().contains("_")) {
        EasyLoading.show(status: 'Uploading , Please wait...');



        try {
          // Prepare the request
          var request = http.MultipartRequest('POST', Uri.parse(
              Strings.BASE_URL + "profile/insert_proofs"));


          if(listimagesPath.length == 1) {

            request.fields["id_proof"] =
                prefs.getString(SharedPrefs.profileid).toString() + "_" +
                    getFileName(File(listimagesPath[0]));

            request.fields["education_proof"] = "0";
            request.fields["income_proof"] =   "0";

            var file = await http.MultipartFile.fromPath(
              'sampleFile[]',
              listimagesPath[0],
            );

            request.files.add(file);
          }else if(listimagesPath.length == 2) {

            request.fields["id_proof"] =
                prefs.getString(SharedPrefs.profileid).toString() + "_" +
                    getFileName(File(listimagesPath[0]));

            request.fields["education_proof"] =
                prefs.getString(SharedPrefs.profileid).toString() + "_" +
                    getFileName(File(listimagesPath[1]));

            request.fields["income_proof"] =   "0";
            request.fields["imagesubpath"] = utils().imagePath(prefs.getString(SharedPrefs.communityId).toString());

            var file = await http.MultipartFile.fromPath(
        'sampleFile[]',
        listimagesPath[0],
      );


      var file2 = await http.MultipartFile.fromPath(
        'sampleFile[]',
        listimagesPath[1],
      );

      request.files.add(file);
      request.files.add(file2);

    }else if(listimagesPath.length == 3) {


            request.fields["id_proof"] =
                prefs.getString(SharedPrefs.profileid).toString() + "_" +
                    getFileName(File(listimagesPath[0]));

            request.fields["education_proof"] =
                prefs.getString(SharedPrefs.profileid).toString() + "_" +
                    getFileName(File(listimagesPath[1]));

            request.fields["income_proof"] =
                prefs.getString(SharedPrefs.profileid).toString() + "_" +
                    getFileName(File(listimagesPath[2]));



            var file = await http.MultipartFile.fromPath(
              'sampleFile[]',
              listimagesPath[0],
            );


            var file2 = await http.MultipartFile.fromPath(
              'sampleFile[]',
              listimagesPath[1],
            );


            var file3 = await http.MultipartFile.fromPath(
              'sampleFile[]',
              listimagesPath[2],
            );


            request.files.add(file);
            request.files.add(file2);
            request.files.add(file3);

          }




          request.fields["id_proof_old"] = prefs.getString(SharedPrefs.id_proof) ?? "";
          request.fields["education_proof_old"] = prefs.getString(SharedPrefs.education_proof) ?? "";
          request.fields["income_proof_old"] = prefs.getString(SharedPrefs.income_proof) ?? "";





          // Attach additional data
          request.fields["profileId"] =
              prefs.getString(SharedPrefs.profileid).toString();
          request.fields["userId"] =
              prefs.getString(SharedPrefs.userId).toString();
          request.fields["communityId"] =
              prefs.getString(SharedPrefs.communityId).toString();
          request.fields["imagesubpath"] = utils().imagePath(prefs.getString(SharedPrefs.communityId).toString());


          // Send the request
          var response = await request.send();

          print(response.stream.bytesToString());


          // Check the response
          if (response.statusCode == 200) {

    if(listimagesPath.length == 1) {
      prefs.setString(SharedPrefs.id_proof,
          prefs.getString(SharedPrefs.profileid).toString() + "_" +
              getFileName(File(listimagesPath[0])) ?? '');
    }
    else if(listimagesPath.length == 2) {

      prefs.setString(SharedPrefs.id_proof,
          prefs.getString(SharedPrefs.profileid).toString() + "_" +
              getFileName(File(listimagesPath[0])) ?? '');


      prefs.setString(SharedPrefs.education_proof,
          prefs.getString(SharedPrefs.profileid).toString() + "_" +
              getFileName(File(listimagesPath[1])) ?? '');
    }else if(listimagesPath.length == 2) {

      prefs.setString(SharedPrefs.id_proof,
          prefs.getString(SharedPrefs.profileid).toString() + "_" +
              getFileName(File(listimagesPath[0])) ?? '');


      prefs.setString(SharedPrefs.education_proof,
          prefs.getString(SharedPrefs.profileid).toString() + "_" +
              getFileName(File(listimagesPath[1])) ?? '');


      prefs.setString(SharedPrefs.income_proof,
          prefs.getString(SharedPrefs.profileid).toString() + "_" +
              getFileName(File(listimagesPath[2])) ?? '');

    }
          } else {
            print(
                'Failed to upload files. Status Code: ${response.statusCode}');

            EasyLoading.showError("Some Error Occured Try again");
          }

          EasyLoading.dismiss();
        } catch (e) {
          print('Error uploading files: $e');

          EasyLoading.dismiss();
        }
      } else {
        EasyLoading.show(status: 'Uploading , Please wait...');


        var request = http.MultipartRequest(
            'PATCH', Uri.parse(Strings.BASE_URL + "profile/update_proofs"));


        if (listimage[0] != "0") {
          request.fields["id_proof"] =
              prefs.getString(SharedPrefs.profileid).toString() + "_" +
                  getFileName(File(listimage[0]));

          request.fields["is_id_verify"] = "0";

          var file = await http.MultipartFile.fromPath('sampleFile[]', listimage[0],);
          request.files.add(file);
        } else {
          request.fields["id_proof"] =
              prefs.getString(SharedPrefs.id_proof) ?? "null";

          request.fields["is_id_verify"] = "-1";
        }

        if (listimage[1] != "0") {
          request.fields["education_proof"] =
              prefs.getString(SharedPrefs.profileid).toString() + "_" +
                  getFileName(File(listimage[1]));

          request.fields["is_education_verify"] = "0";

          var file = await http.MultipartFile.fromPath('sampleFile[]', listimage[1],);
          request.files.add(file);
        } else {
          request.fields["education_proof"] =
              prefs.getString(SharedPrefs.education_proof) ?? "null";

          request.fields["is_education_verify"] = "-1";
        }


        if (listimage[2] != "0") {
          request.fields["income_proof"] =
              prefs.getString(SharedPrefs.profileid).toString() + "_" +
                  getFileName(File(listimage[2]));

          request.fields["is_income_verify"] = "0";

          var file = await http.MultipartFile.fromPath('sampleFile[]', listimage[2],);
          request.files.add(file);
        } else {
          request.fields["income_proof"] =
              prefs.getString(SharedPrefs.income_proof) ?? "null";

          request.fields["is_income_verify"] = "-1";

        }

        request.fields["id_proof_old"] = prefs.getString(SharedPrefs.id_proof) ?? "";
        request.fields["education_proof_old"] = prefs.getString(SharedPrefs.education_proof) ?? "";
        request.fields["income_proof_old"] = prefs.getString(SharedPrefs.income_proof) ?? "";


        request.fields["profileId"] =
            prefs.getString(SharedPrefs.profileid).toString();
        request.fields["userId"] =
            prefs.getString(SharedPrefs.userId).toString();
        request.fields["communityId"] =
            prefs.getString(SharedPrefs.communityId).toString();
        request.fields["imagesubpath"] = utils().imagePath(prefs.getString(SharedPrefs.communityId).toString());

        request.fields["Id"] = update_id;


        var response = await request.send();

        print(await response.stream.bytesToString());

        // Check the response
        if (response.statusCode == 200) {
          if (listimage[0] != "0") {
            prefs.setString(SharedPrefs.id_proof,
                prefs.getString(SharedPrefs.profileid).toString() + "_" +
                    getFileName(File(listimage[0])) ?? '');
          } else {
            prefs.setString(SharedPrefs.id_proof, prefs.getString(SharedPrefs.id_proof).toString());
          }

          if (listimage[1] != "0") {
            prefs.setString(SharedPrefs.education_proof,
                prefs.getString(SharedPrefs.profileid).toString() + "_" +
                    getFileName(File(listimage[1])) ?? '');
          } else {
            prefs.setString(SharedPrefs.education_proof,
                prefs.getString(SharedPrefs.education_proof).toString());
          }


          if (listimage[2] != "0") {
            prefs.setString(SharedPrefs.income_proof,
                prefs.getString(SharedPrefs.profileid).toString() + "_" +
                    getFileName(File(listimage[2])) ?? '');
          } else {
            prefs.setString(SharedPrefs.income_proof,
                prefs.getString(SharedPrefs.income_proof).toString());
          }

          EasyLoading.dismiss();
        } else {
          EasyLoading.showError("Some Error Occured Try again");
        }
      }
    }},
          icon:  Icon(
            Icons.add,
            color: Colors.pink,
            size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ), label: Text("Save" , style: TextStyle(color: Colors.black87 , fontWeight: FontWeight.bold),),
        ),
      ],
    ),
    body:SingleChildScrollView(child: Column(children: [
      Container(width: MediaQuery.of(context).size.width , margin: EdgeInsets.only(left:18 , bottom: 10) ,child:Text("Identity Proof (Adhar Card ,Driving License ,Passport , Election Card etc can be added)" , textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),),
    Center(
    child:  DottedBorder(
    borderType: BorderType.RRect,
        radius: Radius.circular(12),
        padding: EdgeInsets.all(6),child:FancyBorderDashedImage(
       imagePath: imagepath1 == "" ? null : imagepath1, // Replace with your local image path
      imageUrl: Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+path1, // Replace with your network image URL
      borderRadius: 12.0,
      isverify:isverifyPic1.toString(),
      onEditPressed: () {


        ImagePickerWithCrop(callbackFunction: (String path) {

          setState(() {
            imagepath1 = path;
            listimage[0] = imagepath1;
          });

          if(!path1.contains("_")) {
            listimagesPath.insert(0, imagepath1);
          }


        }).selectImage(context);

      },
    ),
    ),),
      Container(width: MediaQuery.of(context).size.width , margin: EdgeInsets.only(left:18 , bottom: 10 ,top: 20) ,child:Text("Education Proof" , textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),),
      Center(
        child:  DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(12),
          padding: EdgeInsets.all(6),child:FancyBorderDashedImage(
          imagePath: imagepath2 == "" ? null : imagepath2, // Replace with your local image path
          imageUrl: Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+path2, // Replace with your network image URL
          borderRadius: 12.0,
            isverify:isverifyPic2.toString(),
          onEditPressed: () {



            ImagePickerWithCrop(callbackFunction: (String path) {

              setState(() {
                imagepath2 = path;
                listimage[1] = imagepath2;
              });

              if(!path2.contains("_")) {
                listimagesPath.insert(0, imagepath2);
              }


            }).selectImage(context);



          },
        ),
        ),),
      Container(width: MediaQuery.of(context).size.width , margin: EdgeInsets.only(left:18 , bottom: 10 ,top: 20) ,child:Text("Income Proof" , textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),),
      Center(
        child:  DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(12),
          padding: EdgeInsets.all(6),child:FancyBorderDashedImage(
          imagePath: imagepath3 == "" ? null : imagepath3, // Replace with your local image path
          imageUrl: Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+path3, // Replace with your network image URL
          borderRadius: 12.0,
            isverify:isverifyPic3.toString(),
          onEditPressed: () {


            ImagePickerWithCrop(callbackFunction: (String path) {

              setState(() {
                imagepath3 = path;
                listimage[2] = imagepath3;
              });

              if(!path3.contains("_")) {
                listimagesPath.insert(0, imagepath3);
              }


            }).selectImage(context);


          },
        ),
        ),),
    ],),

    ));


  }

}



class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    double dashWidth = 5;
    double dashSpace = 5;
    double currentX = 0;

    while (currentX < size.width) {
      path.moveTo(currentX, 0);
      path.lineTo(currentX + dashWidth, 0);
      currentX += dashWidth + dashSpace;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

