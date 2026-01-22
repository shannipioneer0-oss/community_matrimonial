import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/ImagePicker.dart';
import 'package:community_matrimonial/app_utils/MultiSelectDialog.dart';
import 'package:community_matrimonial/network_utils/model/pictures.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/user_profile/FancyBorderedImage.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:community_matrimonial/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

class ImageGalleryEdit extends StatelessWidget {

  final List list;
  ImageGalleryEdit(this.list);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageGalleryStateful(list),
      builder: EasyLoading.init(),
    );
  }
}


class ImageGalleryStateful extends StatefulWidget {

  final List list;
  ImageGalleryStateful(this.list);

  @override
  ImageGalleryScreen createState() => ImageGalleryScreen();

}

class ImageGalleryScreen  extends State<ImageGalleryStateful>{

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String imagepath1 = "" ,  imagepath2 = "" , imagepath3 = "" , imagepath4 = "" , imagepath5 = "" ,imagepath6 = "" ,imagepath7 = "";
  String imagepath8 = "" , imagepath9 = "" ;

  List<String> listimagesPath = [];
  List<String> listimageuploadpath = [];
  List<String> listimage = ["0" ,"0" ,"0" ,"0" ,"0" ,"0" ,"0" , "0"];

  String path1 = "" , path2 = "" , path3 = "", path4 = "", path5 = "" , path6 = "" ,path7 = "" ,path8 = "";
  String isverifyPic1 = "0" ,isverifyPic2 = "0" ,isverifyPic3 = "0" , isverifyPic4 = "0" ,isverifyPic5 = "0" ,isverifyPic6 = "0" ,isverifyPic7 = "0" , isverifyPic8 = "0" ;
  String update_id = "";
  late ConnectivityResult _connectivityResult;

  String getFileName(File file)  {
    String fileName = Uri.file(file.path).pathSegments.last;
    return fileName;
  }

  late SharedPreferences prefs;

  initPrefsImages() async {

     prefs = await SharedPreferences.getInstance();

    setState(() {

      path1 = widget.list[0] ?? "null";
      path2 = widget.list[1] ?? "null";
      path3 = widget.list[2] ?? "null";
      path4 = widget.list[3] ?? "null";
      path5 = widget.list[4] ?? "null";
      path6 = widget.list[5] ?? "null";
      path7 = widget.list[6] ?? "null";
      path8 = widget.list[7] ?? "null";

      print(path2+"-------"+imagepath1);

      if(path1 != "null"){
        listimageuploadpath.add("pic1");
      }
      if(path2 != "null"){
        listimageuploadpath.add("pic2");
      }
      if(path3 != "null"){
        listimageuploadpath.add("pic3");
      }
      if(path4 != "null"){
        listimageuploadpath.add("pic4");
      }
      if(path5 != "null"){
        listimageuploadpath.add("pic5");
      }
      if(path6 != "null"){
        listimageuploadpath.add("pic6");
      }
      if(path7 != "null"){
        listimageuploadpath.add("pic7");
      }
      if(path8 != "null"){
        listimageuploadpath.add("pic8");
      }

    });


    final _response = await Provider.of<ApiService>(context, listen: false)
        .fetch_pictures(
        {
          "type": "pictures",
          "userId": widget.list[9],                   // blog , caste , roles , all_staff
          "communityId": prefs.getString(SharedPrefs.communityId),
          "original": "en",
          "translate": ["en"]
        }
    );

    print(_response.body);

    Pictures pictures = Pictures.fromJson(_response.body);

    setState(() {


        isverifyPic1 = pictures.data[0].isVerifyPic1;


        isverifyPic2 = pictures.data[0].isVerifyPic2;


        isverifyPic3 = pictures.data[0].isVerifyPic3;


        isverifyPic4 = pictures.data[0].isVerifyPic4;



        isverifyPic5 = pictures.data[0].isVerifyPic5;



        isverifyPic6 = pictures.data[0].isVerifyPic6;


        isverifyPic7= pictures.data[0].isVerifyPic7;



        isverifyPic8 = pictures.data[0].isVerifyPic8;

        update_id =  pictures.data[0].id.toString();



        print(isverifyPic1+"--"+isverifyPic2+"---"+isverifyPic3+"_______"+update_id);


    });




  }

  @override
  void initState() {
    super.initState();

    initPrefsImages();
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




  @override
  Widget build(BuildContext context) {

    return Scaffold(key: _scaffoldKey,
    appBar: AppBar(
    title: Text('Image Gallery' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
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
      IconButton(
        onPressed: () async {


   ConnectivityResult result = await Connectivity().checkConnectivity();
            setState(() {
              _connectivityResult = result;
            });
    if (_connectivityResult == ConnectivityResult.none) {
    DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");
    }else {
      SharedPreferences prefs = await SharedPreferences.getInstance();

        EasyLoading.show(status: 'Uploading , Please wait...');


        print("update_photos"+"____"+update_id);

        var request = http.MultipartRequest('PATCH', Uri.parse(
            Strings.BASE_URL + "profile/update_photos"));


        for (int i = 0; i < listimage.length; i++) {
          print(listimage[i]);

          if (listimage[i] != "0") {
            request.fields["pic" + (i + 1).toString()] =
                widget.list[8] + "_" +
                    getFileName(File(listimage[i]));

            var file = await http.MultipartFile.fromPath(
              'sampleFile[]',
              listimage[i],
            );
            request.files.add(file);

            request.fields["isverifypic" + (i + 1).toString()] = "0";

            print(listimage[i] + " - ---   uploads");
          } else {
            request.fields["pic" + (i + 1).toString()] =  i == 0 ? path1 : i == 1 ? path2 : i == 2 ? path3 : i == 3 ? path4 : i == 4 ? path5 : i== 5 ? path6 : i == 6 ? path7 : path8 ?? "null";

            request.fields["isverifypic" + (i + 1).toString()] = "-1";
          }

          request.fields["oldpic" + (i + 1).toString()] =  i == 0 ? path1 : i == 1 ? path2 : i == 2 ? path3 : i == 3 ? path4 : i == 4 ? path5 : i== 5 ? path6 : i == 6 ? path7 : path8 ?? "null";
        }

        request.fields["profileId"] = widget.list[8];
        request.fields["userId"] =  widget.list[9];
        request.fields["communityId"] =
            prefs.getString(SharedPrefs.communityId).toString();
        request.fields["imagesubpath"] = utils().imagePath(prefs.getString(SharedPrefs.communityId).toString());

        request.fields["Id"] = update_id;


        var response = await request.send();

        print(await response.stream.bytesToString());

        // Check the response
        if (response.statusCode == 200) {

        } else {
          print('Failed to upload files. Status Code: ${response.statusCode}');
        }


        EasyLoading.dismiss();
      }


    },
        icon: const Icon(
          Icons.save,
          color: Colors.pink,
          size: 24.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
      ),
    ],
     ),
      body:  SafeArea(child: SingleChildScrollView(child:Column(children: [

        Row(children: [
          SizedBox(width:15),
          Expanded(flex: 1 ,child: FancyBorderedImage(
            imagePath: imagepath1 == "" || imagepath1 == "0" ? null : imagepath1 , // Replace with your local image path
            imageUrl: Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+path1, // Replace with your network image URL
            borderWidth: 4.0,
            borderRadius: 12.0,
            isverify:isverifyPic1.toString()
            ,onEditPressed: (){

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
          ),),
          SizedBox(width:10),
          Expanded(flex: 1 ,child: FancyBorderedImage(
            imagePath: imagepath2 == "" || imagepath2 == "0" ? null : imagepath2, // Replace with your local image path
            imageUrl: Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+path2, // Replace with your network image URL
            borderWidth: 4.0,
            borderRadius: 12.0,
            isverify:isverifyPic2.toString(),
            onEditPressed: (){


              ImagePickerWithCrop(callbackFunction: (String path) {

                setState(() {
                  imagepath2 = path;
                  listimage[1] =  imagepath2;
                });

               if(!path1.contains("_")) {
                 listimagesPath.insert(1, imagepath2);
               }

              }).selectImage(context);


            },
          ),),
          SizedBox(width:10),
          Expanded(flex: 1 ,child: FancyBorderedImage(
            imagePath: imagepath3 == "" || imagepath3 == "0" ? null : imagepath3, // Replace with your local image path
            imageUrl: Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+path3, // Replace with your network image URL
            borderWidth: 4.0,
            borderRadius: 12.0,
              isverify:isverifyPic3.toString(),
            onEditPressed: (){

              ImagePickerWithCrop(callbackFunction: (String path) {

                setState(() {
                  imagepath3 = path;
                  listimage[2] = imagepath3;
                });
    if(!path1.contains("_")) {
      listimagesPath.insert(2, imagepath3);
    }

              }).selectImage(context);

            },
          ),),
          SizedBox(width:15),

        ],),
        SizedBox(height: 20,),
        Row(children: [
          SizedBox(width:15),
          Expanded(flex: 1 ,child: FancyBorderedImage(
            imagePath: imagepath4 == "" || imagepath4 == "0"? null : imagepath4, // Replace with your local image path
            imageUrl: Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+path4, // Replace with your network image URL
            borderWidth: 4.0,
            borderRadius: 12.0,
              isverify:isverifyPic4.toString(),
            onEditPressed: (){

              ImagePickerWithCrop(callbackFunction: (String path) {

                setState(() {
                  imagepath4 = path;
                  listimage[3] = imagepath4;
                });
    if(!path1.contains("_")) {
      listimagesPath.insert(3, imagepath4);
    }

              }).selectImage(context);

            },
          ),),
          SizedBox(width:10),
          Expanded(flex: 1 ,child: FancyBorderedImage(
            imagePath: imagepath5 == "" || imagepath5 == "0" ? null : imagepath5, // Replace with your local image path
            imageUrl: Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+path5, // Replace with your network image URL
            borderWidth: 4.0,
            borderRadius: 12.0,
              isverify:isverifyPic5.toString(),
            onEditPressed: (){

              ImagePickerWithCrop(callbackFunction: (String path) {

                setState(() {
                  imagepath5 = path;
                  listimage[4] = imagepath5;
                });

    if(!path1.contains("_")) {
      listimagesPath.insert(4, imagepath5);
    }

              }).selectImage(context);



            },
          ),),
          SizedBox(width:10),
          Expanded(flex: 1 ,child: FancyBorderedImage(
            imagePath: imagepath6 == "" || imagepath6 == "0" ? null : imagepath6, // Replace with your local image path
            imageUrl: Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+path6, // Replace with your network image URL
            borderWidth: 4.0,
            borderRadius: 12.0,
              isverify:isverifyPic6.toString(),
            onEditPressed: (){


              ImagePickerWithCrop(callbackFunction: (String path) {

                setState(() {
                  imagepath6 = path;

                  listimage[5] = imagepath6;

                });

    if(!path1.contains("_")) {
      listimagesPath.insert(5, imagepath6);
    }

              }).selectImage(context);


            },
          ),),
          SizedBox(width:10),

        ],),
        SizedBox(height: 20,),
        Row(children: [
          SizedBox(width:15),
          Expanded(flex: 1 ,child: FancyBorderedImage(
            imagePath: imagepath7 == "" || imagepath7 == "0" ? null : imagepath7, // Replace with your local image path
            imageUrl: Strings.IMAGE_BASE_URL+"/uploads/matrimonial_photo/Matrimonial_Photo/"+path7, // Replace with your network image URL
            borderWidth: 4.0,
            borderRadius: 12.0,
              isverify:isverifyPic7.toString(),
            onEditPressed: (){

              ImagePickerWithCrop(callbackFunction: (String path) {

                setState(() {
                  imagepath7 = path;
                  listimage[6] = imagepath7;
                });
    if(!path1.contains("_")) {
      listimagesPath.insert(6, imagepath7);
    }

              }).selectImage(context);


            },
          ),),
          SizedBox(width:10),
          Expanded(flex: 1 ,child: FancyBorderedImage(
            imagePath: imagepath8 == "" || imagepath8 == "0" ? null : imagepath8, // Replace with your local image path
            imageUrl: Strings.IMAGE_BASE_URL+"/uploads/matrimonial_photo/Matrimonial_Photo/"+path8, // Replace with your network image URL
            borderWidth: 4.0,
            borderRadius: 12.0,
              isverify:isverifyPic8.toString(),
            onEditPressed: (){


              ImagePickerWithCrop(callbackFunction: (String path) {

                setState(() {
                  imagepath8 = path;
                  listimage[7] = imagepath8;
                });

    if(!path1.contains("_")) {
      listimagesPath.insert(7, imagepath8);
    }

              }).selectImage(context);

            },
          ),),
          SizedBox(width:15),


        ],),
        SizedBox(height: 20,),

      ],),


    )));

  }






}