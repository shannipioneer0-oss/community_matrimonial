


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
  SharedPreferences? prefs;

  Future<List<Verifydoclist>> _loadPage(BuildContext context , String text ,int page, int pageSize) async {

    if(page == 0) {
      EasyLoading.show(status: 'Please wait...');
    }

    prefs = await SharedPreferences.getInstance();

    communityId  = prefs!.getString(SharedPrefs.communityId).toString();



    final _response = await Provider.of<ApiService>(context, listen: false).postVerifyDocList({"communityId": prefs!.getString(SharedPrefs.communityId) , "query":text , "limit":int.parse(Strings.limit),
      "offset":page*pageSize});


    print("body-----"+_response.body.toString());


    VerifyDocumentList searchResult = VerifyDocumentList.fromJson(_response.body);



    //  print(searchResult.getUsers()[0].name+"++++++");

    setState(() {

      //current_length = searchResult.data[0][0].length;
      // controller.totalItemCount = searchResult.getTotalRowCount()[0].totalRowCount;

      print(searchResult.data!.verifydoclist2![0].total.toString()+"====-----______");

      if(searchResult.data!.verifydoclist2![0].total!.toInt() > 0) {
        total_count = searchResult.data!.verifydoclist2![0].total.toString();
      }else{
        total_count = "0";
      }



    });

    EasyLoading.dismiss();

    return searchResult.data!.verifydoclist;

  }

  final ScrollController scrollController = ScrollController();

  List<Verifydoclist> list = [];

  int page = 0;
  bool isLoading = false;
  bool hasMore = true;
  String text = "";


  Future<void> loadMore() async {

    if (isLoading || !hasMore) return;

    isLoading = true;

    print("1111111");

    final newData = await _loadPage(context, text, page, PAGE_SIZE);

    print("222222");

    setState(() {
      page++;

      list.addAll(newData);

      print(list.length.toString()+"=====-----");

      if (newData.length < PAGE_SIZE) {
        hasMore = false;
      }

      isLoading = false;
    });

  }




  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        loadMore();
      }
    });

    loadMore();
  }



  TextEditingController _controller = new TextEditingController();



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
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Search",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(width: 8),

                ElevatedButton(
                  onPressed: () {

                    setState(() {
                      text = _controller.text;
                      page = 0;
                      list.clear();
                      hasMore = true;
                      isLoading = false;
                    });

                    loadMore();

                  },
                  child: Text("Search"),
                )
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: list.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {

                if (index == list.length) {
                  return Center(child: CircularProgressIndicator());
                }

                final entry = list[index];

                return entry.name != null && entry.surname != null ? VerifyDocListRow(fetchImages: entry, index: index, communityId: communityId, prefs: prefs!,) : Container();


              },
            ),
          )
        ],
      )

    );

  }





}