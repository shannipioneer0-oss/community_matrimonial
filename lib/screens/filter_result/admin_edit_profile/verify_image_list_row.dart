


import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/network_utils/model/verifyimagelist.dart';
import 'package:community_matrimonial/screens/filter/StylishCheckbox.dart';
import 'package:community_matrimonial/screens/user_profile/AcceptReject.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../network_utils/service/api_service.dart';
import '../../../utils/SharedPrefs.dart';
import '../../../utils/utils.dart';

class VerifyImageListClass{

  final String name , surname  ,mobile  ,gender ,profileId ,userId;
  final List<ImageList> imagelist ;
  VerifyImageListClass(this.name, this.surname, this.mobile, this.gender, this.profileId, this.userId , this.imagelist, );

}

class ImageList{

 final String newImage , oldImage  , verifyImage ;
  int istrue , indexlist;
 ImageList(this.newImage, this.oldImage, this.verifyImage, this.istrue , this.indexlist);

}

class VerifyImageListRow extends StatefulWidget {

  final Verifyimagelist fetchImages;
  final int index;
  final String communityId;
  final SharedPreferences prefs;

  VerifyImageListRow({required this.fetchImages , required this.index, required this.communityId, required this.prefs});

  @override
  VerifyImageListRowStateful createState() => VerifyImageListRowStateful();
}


class VerifyImageListRowStateful extends State<VerifyImageListRow> {


  List<VerifyImageListClass> imageverifylist = [];
  List<ImageList> imagelist = [];


   @override
  void initState() {
    super.initState();

    if(widget.fetchImages.pic1.toString() != "null"  && widget.fetchImages.pic1 != "" && widget.fetchImages.isverifypic1 == "0") {
      imagelist.add(ImageList(widget.fetchImages.pic1.toString() ,widget.fetchImages.oldpic1.toString() , widget.fetchImages.isverifypic1.toString() , 0 , 1));
    }
    if(widget.fetchImages.pic2.toString() != "null"  && widget.fetchImages.pic2 != "" && widget.fetchImages.isverifypic2 == "0") {
      imagelist.add(ImageList(widget.fetchImages.pic2.toString(),widget.fetchImages.oldpic2.toString() , widget.fetchImages.isverifypic2.toString() , 0 , 2));
    }
    if(widget.fetchImages.pic3.toString() != "null"  && widget.fetchImages.pic3 != "" && widget.fetchImages.isverifypic3 == "0") {
      imagelist.add(ImageList(widget.fetchImages.pic3.toString() ,widget.fetchImages.oldpic3.toString() , widget.fetchImages.isverifypic3.toString() , 0 , 3));
    }
    if(widget.fetchImages.pic4.toString() != "null"  && widget.fetchImages.pic4 != "" && widget.fetchImages.isverifypic4 == "0") {
      imagelist.add(ImageList(widget.fetchImages.pic4.toString() ,widget.fetchImages.oldpic4.toString() , widget.fetchImages.isverifypic4.toString() , 0 , 4));
    }
    if(widget.fetchImages.pic5.toString() != "null"  && widget.fetchImages.pic5 != "" && widget.fetchImages.isverifypic5 == "0") {
      imagelist.add(ImageList(widget.fetchImages.pic5.toString() ,widget.fetchImages.oldpic5.toString(), widget.fetchImages.isverifypic5.toString() , 0 , 5));
    }
    if(widget.fetchImages.pic6.toString() != "null"  && widget.fetchImages.pic6 != "" && widget.fetchImages.isverifypic6 == "0") {
      imagelist.add(ImageList(widget.fetchImages.pic6.toString() ,widget.fetchImages.oldpic6.toString() , widget.fetchImages.isverifypic6.toString() , 0 , 6));
    }
    if(widget.fetchImages.pic7.toString() != "null"  && widget.fetchImages.pic7 != "" && widget.fetchImages.isverifypic7 == "0") {

      imagelist.add(ImageList(widget.fetchImages.pic7.toString() ,widget.fetchImages.oldpic7.toString() , widget.fetchImages.isverifypic7.toString() , 0 , 7));
    }
    if(widget.fetchImages.pic8.toString() != "null"  && widget.fetchImages.pic8 != "" && widget.fetchImages.isverifypic8 == "0") {
      imagelist.add(ImageList(widget.fetchImages.pic8.toString() ,widget.fetchImages.oldpic8.toString() , widget.fetchImages.isverifypic8.toString(), 0 , 8));
    }

    setState(() {
      imageverifylist.add(VerifyImageListClass(widget.fetchImages.name.toString() , widget.fetchImages.surname.toString() , widget.fetchImages.mobile.toString() ,widget.fetchImages.gender.toString() ,widget.fetchImages.profileIdResult.toString() , widget.fetchImages.userId.toString() , imagelist ));

    });

  }


  @override
  Widget build(BuildContext context) {



      return Container(padding: EdgeInsets.all(10) ,child:Card(elevation: 5 ,child:Container(padding: EdgeInsets.all(10) ,child: Column(crossAxisAlignment: CrossAxisAlignment.start ,  children: [

        Text(imageverifylist[0].name+" "+imageverifylist[0].surname ,style: TextStyle(fontSize: 17 ,fontWeight: FontWeight.bold , color: Colors.black87),),
        SizedBox(height: 5,),
        Text("Profile Id : "+imageverifylist[0].profileId+" -- Gender : "+imageverifylist[0].gender ,style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold , color: Colors.black87),),
        SizedBox(height: 10,),

        Column(crossAxisAlignment: CrossAxisAlignment.start , children: imageverifylist[0].imagelist.map((e) {

          print(e.newImage+"--"+e.oldImage+" ----- "+imageverifylist[0].profileId);

          return Column(children: [  Container(child:Row(children: [

            Container( decoration: BoxDecoration(
              border: Border.all(
                color: Colors.pink, // Border color
                width: 2.0, // Border width
              ),
              borderRadius: BorderRadius.circular(12), // Optional: Rounded corners
            ), child:Column(children: [ Text("New Image" , textAlign: TextAlign.center,) ,SizedBox(height: 5,)  ,Image.network(Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(widget.prefs.getString(SharedPrefs.communityId).toString())+e.newImage ,width: MediaQuery.of(context).size.width*0.25, height: 150, errorBuilder: (context, error, stackTrace) {
              return Image.asset("assets/images/no_image.png" ,width: 30, height: 60,);
            },),],)),
            SizedBox(width: 10,),
            Container( decoration: BoxDecoration(
              border: Border.all(
                color: Colors.pink, // Border color
                width: 2.0, // Border width
              ),
              borderRadius: BorderRadius.circular(12), // Optional: Rounded corners
            ),child:Column(children: [ Text("Old Image" , textAlign: TextAlign.center,) ,SizedBox(height: 5,)  ,Image.network(Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(widget.prefs.getString(SharedPrefs.communityId).toString())+e.oldImage ,width: MediaQuery.of(context).size.width*0.25, height: 150, errorBuilder: (context, error, stackTrace) {

              return Image.asset("assets/images/user_image.png" , width: MediaQuery.of(context).size.width*0.25, height: 150 , color: Colors.black54,);
            },),

          ],) ,) ,

            SizedBox(width: 20,),
             AcceptReject((value) {

               imageverifylist[0].imagelist[imageverifylist[0].imagelist.indexOf(e)].istrue = value;

             }) ],)),

            SizedBox(height: 20,),




          ]);

        }).toList(),

        ),

        Container(alignment: Alignment.bottomCenter  ,child: Container( height: 35 ,color: Colors.pinkAccent ,child:TextButton(onPressed: () async {

          String isverify1 = "-1" , isverify2 = "-1" , isverify3 = "-1" , isverify4 = "-1" , isverify5 = "-1";
          String  isverify6 = "-1" ,  isverify7 = "-1" , isverify8 = "-1";

          imageverifylist[0].imagelist.forEach((element) {

               if(element.indexlist == 1){
                 isverify1 = element.istrue.toString();
               }
               if(element.indexlist == 2){
                 isverify2 = element.istrue.toString();
               }
               if(element.indexlist == 3){
                 isverify3 = element.istrue.toString();
               }
               if(element.indexlist == 4){
                 isverify4 = element.istrue.toString();
               }
               if(element.indexlist == 5){
                 isverify5 = element.istrue.toString();
               }
               if(element.indexlist == 6){
                 isverify6 = element.istrue.toString();
               }
               if(element.indexlist == 7){
                 isverify7 = element.istrue.toString();
               }
               if(element.indexlist == 8){
                 isverify8 = element.istrue.toString();
               }

          });

          final _response = await Provider.of<ApiService>(context, listen: false).postUpdatePhotoVerification({"isverifypic1": isverify1 , "isverifypic2": isverify2 , "isverifypic3": isverify3 , "isverifypic4": isverify4 ,
            "isverifypic5": isverify5 , "isverifypic6": isverify6 ,"isverifypic7": isverify7 , "isverifypic8": isverify8 , "userId":widget.fetchImages.userId , "communityId":widget.communityId});



       if (_response.body["data"]["affectedRows"] >= 1) {

         DialogClass().showDialog2(context, "Verification Success" , "Verification Process of Photos done For "+widget.fetchImages.name.toString()+" "+widget.fetchImages.surname.toString(), "Ok");

       }


        }, child:Text("Verify Photos" , style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),))))

      ],),)));

  }


}