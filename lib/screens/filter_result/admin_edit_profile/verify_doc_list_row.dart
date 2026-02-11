


import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/network_utils/model/VerifyDocumentList.dart';
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

class VerifyDocListClass{

  final String name , surname  ,mobile  ,gender ,profileId ,userId;
  final List<ImageList> imagelist ;
  VerifyDocListClass(this.name, this.surname, this.mobile, this.gender, this.profileId, this.userId , this.imagelist, );

}

class ImageList{

  final String newImage , oldImage  , verifyImage ;
  int istrue , indexlist;
  ImageList(this.newImage, this.oldImage, this.verifyImage, this.istrue , this.indexlist);

}

class VerifyDocListRow extends StatefulWidget {

  final Verifydoclist fetchImages;
  final int index;
  final String communityId;
  final SharedPreferences prefs;

  VerifyDocListRow({required this.fetchImages , required this.index, required this.communityId, required this.prefs});

  @override
  VerifyDocListRowStateful createState() => VerifyDocListRowStateful();
}


class VerifyDocListRowStateful extends State<VerifyDocListRow> {


  List<VerifyDocListClass> imageverifylist = [];
  List<ImageList> imagelist = [];


  @override
  void initState() {
    super.initState();
    if(widget.fetchImages.idProofs.toString() != "null"  && widget.fetchImages.idProofs != "" && widget.fetchImages.idProofs != "0" && (widget.fetchImages.isIdVerify == "0" || widget.fetchImages.isIdVerify == null || widget.fetchImages.isIdVerify == "2") ) {

      imagelist.add(ImageList(widget.fetchImages.idProofs.toString() ,widget.fetchImages.idProofOld.toString() , widget.fetchImages.isIdVerify.toString() , 0 , 1));
    }
    if(widget.fetchImages.educationProof.toString() != "null"  && widget.fetchImages.educationProof != "" && widget.fetchImages.educationProof != "0" && (widget.fetchImages.isEducationVerify == "0" || widget.fetchImages.isEducationVerify == null)) {
      imagelist.add(ImageList(widget.fetchImages.educationProof.toString(),widget.fetchImages.educationProofOld.toString() , widget.fetchImages.isEducationVerify.toString() , 0 , 2));
    }
    if(widget.fetchImages.incomeProof.toString() != "null"  && widget.fetchImages.incomeProof != "" && widget.fetchImages.incomeProof != "0" && (widget.fetchImages.isIncomeVerify == "0" ||  widget.fetchImages.isIncomeVerify == null)) {
      imagelist.add(ImageList(widget.fetchImages.incomeProof.toString() ,widget.fetchImages.incomeProofOld.toString() , widget.fetchImages.isIncomeVerify.toString() , 0 , 3));
    }


    setState(() {
      imageverifylist.add(VerifyDocListClass(widget.fetchImages.name.toString() , widget.fetchImages.surname.toString() , widget.fetchImages.mobile.toString() ,widget.fetchImages.gender.toString() ,widget.fetchImages.profileIdResult.toString() , widget.fetchImages.userId.toString() , imagelist ));

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

        return Column(children: [  Container(child:Row(children: [


          Container( decoration: BoxDecoration(
            border: Border.all(
              color: Colors.pink, // Border color
              width: 2.0, // Border width
            ),
            borderRadius: BorderRadius.circular(12), // Optional: Rounded corners
          ), child:Column(children: [ Text( e.indexlist == 1 ? "New Image\n (Identity)" : e.indexlist == 2 ? "New Image\n (Education)" : "New Image\n (Income)"  , textAlign: TextAlign.center,) ,SizedBox(height: 5,)  ,Image.network(Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(widget.prefs.getString(SharedPrefs.communityId).toString())+e.newImage ,width: MediaQuery.of(context).size.width*0.25, height: 150, errorBuilder: (context, error, stackTrace) {
            return Image.asset("assets/images/no_image.png" ,width: 30, height: 60,);
          },),],)),
          SizedBox(width: 10,),
          Container( decoration: BoxDecoration(
            border: Border.all(
              color: Colors.pink, // Border color
              width: 2.0, // Border width
            ),
            borderRadius: BorderRadius.circular(12), // Optional: Rounded corners
          ),child:Column(children: [ Text(e.indexlist == 1 ? "old Image\n (Identity)" : e.indexlist == 2 ? "Old Image\n (Education)" : "Old Image\n (Income)" , textAlign: TextAlign.center,) ,SizedBox(height: 5,)  ,Image.network(Strings.IMAGE_BASE_URL+"/uploads/"+utils().imagePath(widget.prefs.getString(SharedPrefs.communityId).toString())+e.oldImage ,width: MediaQuery.of(context).size.width*0.25, height: 150, errorBuilder: (context, error, stackTrace) {

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

        String isidverify = "-1" , iseducationverify = "-1" , isincomeverify = "-1";


        imageverifylist[0].imagelist.forEach((element) {

          if(element.indexlist == 1){
            isidverify = element.istrue.toString();
          }
          if(element.indexlist == 2){
            iseducationverify = element.istrue.toString();
          }
          if(element.indexlist == 3){
            isincomeverify = element.istrue.toString();
          }


        });

        final _response = await Provider.of<ApiService>(context, listen: false).postUpdateDocumentVerification({"isidverify": isidverify , "iseducationverify": iseducationverify , "isincomeverify": isincomeverify , "userId":widget.fetchImages.userId , "communityId":widget.communityId});

                print(_response.body);

        if (_response.body["data"]["affectedRows"] >= 1) {

          DialogClass().showDialog2(context, "Verification Success" , "Verification Process of Documents done For "+widget.fetchImages.name.toString()+" "+widget.fetchImages.surname.toString(), "Ok");

        }


      }, child:Text("Verify Documents" , style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),))))

    ],),)));

  }


}