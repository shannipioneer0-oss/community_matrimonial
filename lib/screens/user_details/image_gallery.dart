


import 'package:community_matrimonial/network_utils/model/profile_details_model.dart';
import 'package:community_matrimonial/screens/user_details/InclinedPhoto.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_utils/Dialogs.dart';
import '../../utils/SharedPrefs.dart';
import '../../utils/utils.dart';

class ImageGalleryOther extends StatelessWidget {

  final List photoinfo;
  ImageGalleryOther(this.photoinfo);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageGalleryStateful(photoinfo),
    );
  }
}




class ImageGalleryStateful extends StatefulWidget {

  final List photo;
  ImageGalleryStateful(this.photo);

  @override
  ImageGalleryScreen createState() => ImageGalleryScreen();

}


class ImageGalleryScreen extends State<ImageGalleryStateful> {



  List<Widget> listpics = [];

 late SharedPreferences prefs;

  initprefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();

    _checkConnectivity();
    initprefs();


    Future.delayed(Duration(milliseconds: 500), ()
    {
      setState(() {
        if (widget.photo[0].pic1 != null && widget.photo[0].pic1!.isNotEmpty &&
            widget.photo[0].pic1 != "null") {
          listpics.add(Image.network(
            Strings.IMAGE_BASE_URL + "/uploads/" + utils().imagePath(
                prefs.getString(SharedPrefs.communityId).toString()) +
                widget.photo[0].pic1.toString(),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return RoundedContainer();
            },
          ));
        }
        if (widget.photo[0].pic2 != null && widget.photo[0].pic2!.isNotEmpty &&
            widget.photo[0].pic2 != "null") {
          listpics.add(Image.network(
            Strings.IMAGE_BASE_URL + "/uploads/" + utils().imagePath(
                prefs.getString(SharedPrefs.communityId).toString()) +
                widget.photo[0].pic2.toString(),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return RoundedContainer();
            },
          ));
        }

        if (widget.photo[0].pic3 != null && widget.photo[0].pic3!.isNotEmpty &&
            widget.photo[0].pic3 != "null") {
          listpics.add(Image.network(
            Strings.IMAGE_BASE_URL + "/uploads/" + utils().imagePath(
                prefs.getString(SharedPrefs.communityId).toString()) +
                widget.photo[0].pic3.toString(),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return RoundedContainer();
            },
          ));
        }

        if (widget.photo[0].pic4 != null && widget.photo[0].pic4!.isNotEmpty &&
            widget.photo[0].pic4 != "null") {

          listpics.add(Image.network(
            Strings.IMAGE_BASE_URL + "/uploads/" + utils().imagePath(
                prefs.getString(SharedPrefs.communityId).toString()) +
                widget.photo[0].pic4.toString(),
            fit: BoxFit.cover,
          ));

        }


        if (widget.photo[0].pic5 != null && widget.photo[0].pic5!.isNotEmpty &&
            widget.photo[0].pic5 != "null") {

          listpics.add(Image.network(
            Strings.IMAGE_BASE_URL + "/uploads/" + utils().imagePath(
                prefs.getString(SharedPrefs.communityId).toString()) +
                widget.photo[0].pic5.toString(),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return RoundedContainer();
            },
          ));

        }


        if (widget.photo[0].pic6 != null && widget.photo[0].pic6!.isNotEmpty &&
            widget.photo[0].pic6 != "null") {
          listpics.add(Image.network(
            Strings.IMAGE_BASE_URL + "/uploads/" + utils().imagePath(
                prefs.getString(SharedPrefs.communityId).toString()) +
                widget.photo[0].pic6.toString(),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return RoundedContainer();
            },
          ));
        }


        if (widget.photo[0].pic7 != null && widget.photo[0].pic7!.isNotEmpty &&
            widget.photo[0].pic7 != "null") {
          listpics.add(Image.network(
            Strings.IMAGE_BASE_URL + "/uploads/" + utils().imagePath(
                prefs.getString(SharedPrefs.communityId).toString()) +
                widget.photo[0].pic7.toString(),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return RoundedContainer();
            },
          ));
        }

        if (widget.photo[0].pic8 != null && widget.photo[0].pic8!.isNotEmpty &&
            widget.photo[0].pic8 != "null") {
          listpics.add(Image.network(
            Strings.IMAGE_BASE_URL + "/uploads/" + utils().imagePath(
                prefs.getString(SharedPrefs.communityId).toString()) +
                widget.photo[0].pic8.toString(),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return RoundedContainer();
            },
          ));
        }
      });

    });



  }


  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  Future<void> _checkConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = result;
    });
    if (_connectivityResult == ConnectivityResult.none) {
      DialogClass().showNoInternetAlert(context);
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        title: Text( listpics.length > 1 ? widget.photo[1]+" photos ("+listpics.length.toString()+")" : widget.photo[1]+" photos" , style: TextStyle(color: Colors.black87 , fontSize: 18),),
    toolbarOpacity: 1,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: IconButton(
    icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
    onPressed: () {

      navService.goBack();

    },
    )),
    body: listpics.length > 0 ? Container(child: ImageSlideshow(

      /// Width of the [ImageSlideshow].
      width: double.infinity,

      /// Height of the [ImageSlideshow].
      height: MediaQuery.of(context).size.height*0.7,

      /// The page to show when first creating the [ImageSlideshow].
      initialPage: 0,

      /// The color to paint the indicator.
      indicatorColor: Colors.pink,

      indicatorRadius: 5,

      /// The color to paint behind th indicator.
      indicatorBackgroundColor: Colors.grey,

      /// The widgets to display in the [ImageSlideshow].
      /// Add the sample image file into the images folder
      children: listpics,

      /// Called whenever the page in the center of the viewport changes.
      onPageChanged: (value) {
        print('Page changed: $value');
      },

      /// Auto scroll interval.
      /// Do not auto scroll with null or 0.
      autoPlayInterval: 20000,

      /// Loops back to first slide.
      isLoop: true,
    ),
    ) : Center(child: Text("No Images In Gallery" , style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold),),),


    );


  }




}