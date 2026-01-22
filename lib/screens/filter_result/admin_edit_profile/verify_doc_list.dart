


import 'package:community_matrimonial/app_utils/StylishDrawer.dart';
import 'package:community_matrimonial/network_utils/model/VerifyDocumentList.dart';
import 'package:community_matrimonial/network_utils/model/fetch_matches.dart';
import 'package:community_matrimonial/network_utils/model/verifyimagelist.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/verify_doc_list_row.dart';
import 'package:community_matrimonial/screens/filter_result/admin_edit_profile/verify_image_list_row.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:huge_listview/huge_listview.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../network_utils/service/api_service.dart';

class VerifyDocListEdit extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VerifydocListStateful(),
      builder: EasyLoading.init(),

    );
  }
}


class VerifydocListStateful extends StatefulWidget {


  @override
  VerifydocListState createState() => VerifydocListState();

}

class VerifydocListState  extends State<VerifydocListStateful>{


  int current_length = 16;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const int PAGE_SIZE = 16;
  final scroll = ItemScrollController();
  HugeListViewController controller = HugeListViewController(totalItemCount: int.parse(Strings.limit));
  String total_count = "0";
  String communityId = "";


  Future<List<Verifydoclist>> _loadPage(BuildContext context  ,int page, int pageSize) async {

    if(page == 0) {
      EasyLoading.show(status: 'Please wait...');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    communityId  =prefs.getString(SharedPrefs.communityId).toString();



    final _response = await Provider.of<ApiService>(context, listen: false).postVerifyDocList({"communityId": prefs.getString(SharedPrefs.communityId) , "limit":int.parse(Strings.limit),
      "offset":page*pageSize});


    print("body-----"+_response.body.toString());


    VerifyDocumentList searchResult = VerifyDocumentList.fromJson(_response.body);



    //  print(searchResult.getUsers()[0].name+"++++++");

    setState(() {

      //current_length = searchResult.data[0][0].length;
      // controller.totalItemCount = searchResult.getTotalRowCount()[0].totalRowCount;
      if(searchResult.data!.verifydoclist2![0].total!.toInt() > 0) {
        total_count =
            searchResult.data!.verifydoclist2![0].total.toString();
      }else{
        total_count = "0";
      }



    });

    EasyLoading.dismiss();

    return searchResult.data!.verifydoclist;

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(key: _scaffoldKey,

      appBar: AppBar(
          title: Text('Verify Images Results ('+total_count+")" , style: TextStyle(color: Colors.black87 , fontSize: 18),),
          toolbarOpacity: 1,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Image.asset("assets/images/back.png" , width: 50, height: 40,),
            onPressed: () {
              navService.goBack();
            },
          )),
      drawer: StylishDrawer(),
      body: HugeListView<Verifydoclist>(
        scrollController: scroll,
        listViewController: controller,
        pageSize: PAGE_SIZE,
        startIndex: 0,
        velocityThreshold: 10,
        firstShown: (item) => {

          if( item >= controller.totalItemCount - 5 &&  controller.totalItemCount <= int.parse(total_count)){

            print(item.toString()+"()"+controller.totalItemCount.toString()+"()"+total_count+"()"+current_length.toString()),

            // if(int.parse(total_count)-controller.totalItemCount-int.parse(Strings.limit) > 0  ){
            controller.totalItemCount =
                controller.totalItemCount + int.parse(Strings.limit),

            /*  }else{
               controller.totalItemCount = controller.totalItemCount + int.parse(total_count)-controller.totalItemCount,
            isscroll = false,

          },*/
            _loadPage(context ,  (controller.totalItemCount / int.parse(Strings.limit)).toInt() - 1  , PAGE_SIZE),

          } },
        pageFuture: (page) => _loadPage(context , page , PAGE_SIZE),

        itemBuilder: (context, index, Verifydoclist entry) {

          return VerifyDocListRow(fetchImages: entry, index: index, communityId: communityId,);

        },
        errorBuilder: (context, error) {

          print(error);
          return Center(child: Text("No Data Available"),);
        },
        thumbBuilder: DraggableScrollbarThumbs.SemicircleThumb,
        placeholderBuilder: (context, index) => Container(),
        alwaysVisibleThumb: false,
        emptyBuilder: (context) {
          return Center(child: Text("No Data Available"),);
        },

      ),

    );

  }





}