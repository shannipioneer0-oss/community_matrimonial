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

/*class ImageGallery extends StatelessWidget {

  final String type;
  ImageGallery({required this.type});

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: () async{

          print("testing123");

          return false;
        } , child:MaterialApp(
      home: ImageGalleryStateful(type),
      builder: EasyLoading.init(),
    ));
  }
}*/


class ImageGallery extends StatefulWidget {

  final String type;
  ImageGallery({required this.type});

  @override
  ImageGalleryScreen createState() => ImageGalleryScreen();

}

class ImageGalleryScreen  extends State<ImageGallery>{

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String imagepath1 = "" ,  imagepath2 = "" , imagepath3 = "" , imagepath4 = "" , imagepath5 = "" , imagepath6 = "" , imagepath7 = "";
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
  late Future<void> _prefsFuture;

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  initPrefsImages() async {


    setState(() {

      path1 = prefs!.getString(SharedPrefs.pic1) ?? "null";
      path2 = prefs!.getString(SharedPrefs.pic2) ?? "null";
      path3 = prefs!.getString(SharedPrefs.pic3) ?? "null";
      path4 = prefs!.getString(SharedPrefs.pic4) ?? "null";
      path5 = prefs!.getString(SharedPrefs.pic5) ?? "null";
      path6 = prefs!.getString(SharedPrefs.pic6) ?? "null";
      path7 = prefs!.getString(SharedPrefs.pic7) ?? "null";
      path8 = prefs.getString(SharedPrefs.pic8) ?? "null";

      print(path1+"-------"+imagepath1);

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

    print("123456");

    var _response;


      _response = await ApiService.create()
          .fetch_pictures(
          {
            "type": "pictures",
            "userId": prefs.getString(SharedPrefs.userId),
            // blog , caste , roles , all_staff
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


         isverifyPic7 = pictures.data[0].isVerifyPic7;


         isverifyPic8 = pictures.data[0].isVerifyPic8;

         update_id = pictures.data[0].id.toString();


         print(isverifyPic1 + "--" + isverifyPic2 + "---" + isverifyPic3 +
             "_______" + update_id);
       });





  }

  @override
  void initState() {
    super.initState();

    EasyLoading.dismiss();

    _prefsFuture = _initPrefs();

    Future.delayed(Duration(milliseconds: 800) , (){
      initPrefsImages();
    });


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

  Future<bool> _onWillPop(BuildContext context) async {


     await showDialog(context: context , builder: (context) {

            return AlertDialog(title: Text("Save Images") ,
              content: Text("Do you want to save images?"),
              actions: [ GestureDetector( onTap: (){

                Navigator.of(context).pop(false);
                navService.goBack();

              } ,child:Text("No" , style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold , color: Colors.purple),)),

                SizedBox(width: 10,),
                GestureDetector( onTap: () async {

                 ConnectivityResult result = await Connectivity().checkConnectivity();
            setState(() {
              _connectivityResult = result;
            });
                  if (_connectivityResult == ConnectivityResult.none) {

                    DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");

                  }else {

                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    if (prefs.getString(SharedPrefs.pic1) == null) {
                      EasyLoading.show(status: 'Uploading , Please wait...');

                      try {
                        // Prepare the request
                        var request = http.MultipartRequest('POST', Uri.parse(
                            Strings.BASE_URL + "profile/insert_photos"));

                        // Attach files
                        for (var i = 0; i < listimagesPath.length; i++) {

                          request.fields["pic" + (i + 1).toString()] =
                              prefs.getString(SharedPrefs.profileid).toString() + "_" +
                                  getFileName(File(listimagesPath[i]));

                          var file = await http.MultipartFile.fromPath(
                            'sampleFile[]',
                            listimagesPath[i],
                          );

                          request.files.add(file);

                        }

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
                          for (var i = 0; i < listimagesPath.length; i++) {
                            await prefs.setString("pic" + (i + 1).toString(),
                                prefs.getString(SharedPrefs.profileid).toString() + "_" +
                                    getFileName(File(listimagesPath[i])) ?? '');
                          }
                        } else {

                          print('Failed to upload files. Status Code: ${response.statusCode}');
                        }

                        Navigator.of(context).pop();
                        navService.goBack();

                        EasyLoading.dismiss();
                      } catch (e) {
                        print('Error uploading files: $e');

                        EasyLoading.dismiss();
                      }

                    } else {


                      EasyLoading.show(status: 'Uploading , Please wait...');


                      print("update_photos"+"____"+update_id);

                      var request = http.MultipartRequest('PATCH', Uri.parse(
                          Strings.BASE_URL + "profile/update_photos"));


                      for (int i = 0; i < listimage.length; i++) {
                        print(listimage[i]);

                        if (listimage[i] != "0") {
                          request.fields["pic" + (i + 1).toString()] =
                              prefs.getString(SharedPrefs.profileid).toString() + "_" +
                                  getFileName(File(listimage[i]));

                          var file = await http.MultipartFile.fromPath(
                            'sampleFile[]',
                            listimage[i],
                          );
                          request.files.add(file);

                          request.fields["isverifypic" + (i + 1).toString()] = "0";

                          print(listimage[i] + " - ---   uploads");

                        } else {
                          request.fields["pic" + (i + 1).toString()] =
                              prefs.getString("pic" + (i + 1).toString()) ?? "null";

                          request.fields["isverifypic" + (i + 1).toString()] = "-1";
                        }


                        request.fields["oldpic" + (i + 1).toString()] =
                            prefs.getString("pic" + (i + 1).toString()) ?? "null";

                      }

                      request.fields["profileId"] =
                          prefs.getString(SharedPrefs.profileid).toString();
                      request.fields["userId"] =
                          prefs.getString(SharedPrefs.userId).toString();
                      request.fields["communityId"] =
                          prefs.getString(SharedPrefs.communityId).toString();
                      request.fields["imagesubpath"] = utils().imagePath(prefs.getString(SharedPrefs.communityId).toString());

                      request.fields["Id"] = update_id;


                      var response = await request.send();

                     // print(await response.stream.bytesToString());

                      // Check the response
                      if (response.statusCode == 200) {
                        for (var i = 0; i < listimage.length; i++) {
                          if (listimage[i] != "0") {
                            await prefs.setString("pic" + (i + 1).toString(),
                                prefs.getString(SharedPrefs.profileid).toString() + "_" +
                                    getFileName(File(listimage[i])) ?? '');
                          } else {
                            await prefs.setString(
                                "pic" + (i + 1).toString(), prefs.getString("pic" + (i + 1)
                                .toString()) ?? "null");
                          }
                        }
                      } else {
                        print('Failed to upload files. Status Code: ${response.statusCode}');
                      }

                      Navigator.of(context).pop();
                      navService.goBack();
                      EasyLoading.dismiss();
                    }
                  }

                } ,child:Text("Yes" , style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold , color: Colors.purple),)),


              ],
            );

          },);

    return false;
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
    onWillPop:() => _onWillPop(context),
    child: Scaffold(key: _scaffoldKey,
    appBar: AppBar(
    title: Text('Image Gallery\nRavaldev Matrimony' , style: TextStyle(color: Colors.black87 , fontSize: 18),),
    toolbarOpacity: 1,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: IconButton(
    icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
    onPressed: () {

      showDialog(context: context, builder: (context) {

        return AlertDialog(title: Text("Save Images") ,
          content: Text("Do you want to save images?"),
          actions: [ GestureDetector( onTap: (){

            Navigator.of(context).pop();
            navService.goBack();

          } ,child:Text("No" , style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold , color: Colors.purple),)),

            SizedBox(width: 10,),
            GestureDetector( onTap: () async {

              ConnectivityResult result = await Connectivity().checkConnectivity();
            setState(() {
              _connectivityResult = result;
            });

              if (_connectivityResult == ConnectivityResult.none) {

                DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");

              }else {

                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (prefs.getString(SharedPrefs.pic1) == null) {
                  EasyLoading.show(status: 'Uploading , Please wait...');

                  try {
                    // Prepare the request
                    var request = http.MultipartRequest('POST', Uri.parse(
                        Strings.BASE_URL + "profile/insert_photos"));

                    // Attach files
                    for (var i = 0; i < listimagesPath.length; i++) {
                      request.fields["pic" + (i + 1).toString()] =
                          prefs.getString(SharedPrefs.profileid).toString() + "_" +
                              getFileName(File(listimagesPath[i]));

                      var file = await http.MultipartFile.fromPath(
                        'sampleFile[]',
                        listimagesPath[i],
                      );
                      request.files.add(file);
                    }

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

                    // print(response.stream.bytesToString());

                    // Check the response
                    if (response.statusCode == 200) {

                      if(listimagesPath.length > 0) {
                        for (var i = 0; i < listimagesPath.length; i++) {
                          await prefs.setString("pic" + (i + 1).toString(),
                              prefs.getString(SharedPrefs.profileid)
                                  .toString() + "_" +
                                  getFileName(File(listimagesPath[i])) ?? '');
                        }
                      }

                    } else {
                      print(
                          'Failed to upload files. Status Code: ${response.statusCode}');
                    }

                    Navigator.of(context).pop();
                    navService.goBack();

                    EasyLoading.dismiss();
                  } catch (e) {
                    print('Error uploading files: $e');

                    EasyLoading.dismiss();
                  }
                } else {
                  EasyLoading.show(status: 'Uploading , Please wait...');


                  print("update_photos"+"____"+update_id);

                  var request = http.MultipartRequest('PATCH', Uri.parse(
                      Strings.BASE_URL + "profile/update_photos"));


                  for (int i = 0; i < listimage.length; i++) {
                    print(listimage[i]);

                    if (listimage[i] != "0") {
                      request.fields["pic" + (i + 1).toString()] =
                          prefs.getString(SharedPrefs.profileid).toString() + "_" +
                              getFileName(File(listimage[i]));

                      var file = await http.MultipartFile.fromPath(
                        'sampleFile[]',
                        listimage[i],
                      );
                      request.files.add(file);

                      request.fields["isverifypic" + (i + 1).toString()] = "0";

                      print(listimage[i] + " - ---   uploads");
                    } else {
                      request.fields["pic" + (i + 1).toString()] =
                          prefs.getString("pic" + (i + 1).toString()) ?? "null";

                      request.fields["isverifypic" + (i + 1).toString()] = "-1";
                    }


                    request.fields["oldpic" + (i + 1).toString()] =
                        prefs.getString("pic" + (i + 1).toString()) ?? "null";

                  }

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
              for (var i = 0; i < listimage.length; i++) {
              if (listimage[i] != "0") {

              await prefs.setString("pic" + (i + 1).toString(),
              prefs.getString(SharedPrefs.profileid).toString() + "_" +
              getFileName(File(listimage[i])) ?? '');

              } else {

              await prefs.setString(
              "pic" + (i + 1).toString(), prefs.getString("pic" + (i + 1)
                  .toString()) ?? "null");
              }

              }
              } else {
              print('Failed to upload files. Status Code: ${response.statusCode}');
              }

                  Navigator.of(context).pop();
              navService.goBack();
              EasyLoading.dismiss();
            }
            }

            } ,child:Text("Yes" , style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold , color: Colors.purple),)),


          ],
        );

      },);

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
      if (prefs.getString(SharedPrefs.pic1) == null) {
        EasyLoading.show(status: 'Uploading , Please wait...');

        try {
          // Prepare the request
          var request = http.MultipartRequest('POST', Uri.parse(
              Strings.BASE_URL + "profile/insert_photos"));

          // Attach files
          for (var i = 0; i < listimagesPath.length; i++) {
            request.fields["pic" + (i + 1).toString()] =
                prefs.getString(SharedPrefs.profileid).toString() + "_" +
                    getFileName(File(listimagesPath[i]));

            var file = await http.MultipartFile.fromPath(
              'sampleFile[]',
              listimagesPath[i],
            );
            request.files.add(file);
          }

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
    if(listimagesPath.length > 0) {
      for (var i = 0; i < listimagesPath.length; i++) {
        await prefs.setString("pic" + (i + 1).toString(),
            prefs.getString(SharedPrefs.profileid).toString() + "_" +
                getFileName(File(listimagesPath[i])) ?? '');
      }
    }
          } else {
            print(
                'Failed to upload files. Status Code: ${response.statusCode}');
          }

          navService.goBack();

          EasyLoading.dismiss();
        } catch (e) {
          print('Error uploading files: $e');

          EasyLoading.dismiss();
        }
      } else {
        EasyLoading.show(status: 'Uploading , Please wait...');


        print("update_photos"+"____"+update_id);

        var request = http.MultipartRequest('PATCH', Uri.parse(
            Strings.BASE_URL + "profile/update_photos"));


        for (int i = 0; i < listimage.length; i++) {
          print(listimage[i]);

          if (listimage[i] != "0") {
            request.fields["pic" + (i + 1).toString()] =
                prefs.getString(SharedPrefs.profileid).toString() + "_" +
                    getFileName(File(listimage[i]));

            var file = await http.MultipartFile.fromPath(
              'sampleFile[]',
              listimage[i],
            );
            request.files.add(file);

            request.fields["isverifypic" + (i + 1).toString()] = "0";

            print(listimage[i] + " - ---   uploads");
          } else {
            request.fields["pic" + (i + 1).toString()] =
                prefs.getString("pic" + (i + 1).toString()) ?? "null";

            request.fields["isverifypic" + (i + 1).toString()] = "-1";
          }


          request.fields["oldpic" + (i + 1).toString()] =
              prefs.getString("pic" + (i + 1).toString()) ?? "null";

        }

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
          for (var i = 0; i < listimage.length; i++) {
            if (listimage[i] != "0") {
              await prefs.setString("pic" + (i + 1).toString(),
                  prefs.getString(SharedPrefs.profileid).toString() + "_" +
                      getFileName(File(listimage[i])) ?? '');
            } else {
              await prefs.setString(
                  "pic" + (i + 1).toString(), prefs.getString("pic" + (i + 1)
                  .toString()) ?? "null");
            }
          }
        } else {
          print('Failed to upload files. Status Code: ${response.statusCode}');
        }

        navService.goBack();
        EasyLoading.dismiss();
      }
    }

    },
        icon: const Icon(
          Icons.save,
          color: Colors.pink,
          size: 30.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
      ),
    ],
     ),
      body:FutureBuilder<void>(
    future: _prefsFuture,
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
    return const Center(child: Text("Failed to load preferences"));
    }


    return SingleChildScrollView(child: SafeArea(child: Column(children: [

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
    listimage[1] = imagepath2;
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
    imageUrl: Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+path7, // Replace with your network image URL
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
    imageUrl: Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+path8, // Replace with your network image URL
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

    ] ,),


    ));

    })));

  }






}