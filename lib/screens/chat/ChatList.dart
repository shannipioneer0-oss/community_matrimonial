import 'dart:ffi';
import 'dart:io' as f;
import 'dart:io';


import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/app_utils/StylishDrawer.dart';
import 'package:community_matrimonial/network_utils/model/chatuser_list.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/screens/chat/MessageDataStore.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../../utils/SharedPrefs.dart';
import 'models/message.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatListStateful(),
      builder: EasyLoading.init(),
    );
  }
}


class ChatListStateful extends StatefulWidget {


  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatListStateful> {

  final Connectivity _connectivity = Connectivity();
  late Stream<ConnectivityResult> _connectionStream;

  @override
  void initState() {
    super.initState();

    _checkConnectivity();

    initChatList();
    initOfflinemessages();

  }



  initOfflinemessages() async {

    Directory? externalDir = await getExternalStorageDirectory();

    if (externalDir != null) {
      // Create a custom directory within the external storage
      String customDirPath = '${externalDir.path}/Storage';

      print(customDirPath);
      Directory customDir = Directory(customDirPath);

      // Ensure the custom directory exists
      if (!customDir.existsSync()) {
        customDir.createSync(recursive: true);
      }

      Directory directory = Directory(customDirPath);
      await Hive.initFlutter(customDirPath);

    }

    bool isRegistered = Hive.isAdapterRegistered(0);

    if(isRegistered == false){
      Hive.registerAdapter<Message123>(MessageAdapter());
    }


    /// Open box
    await Hive.openBox<Message123>("messages");

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


  List<Data> listdata = [];
  initChatList() async {

    EasyLoading.show(status: 'Please wait...');

    SharedPreferences prefs = await SharedPreferences.getInstance();

   final _response = await Provider.of<ApiService>(context, listen: false).postChatList({"from_id":prefs.getString(SharedPrefs.userId),});

   ChatUserList chatuserlist =  ChatUserList.fromJson(_response.body);

   setState(() {
     listdata = chatuserlist.data!;
   });

   EasyLoading.dismiss();


  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Your Chat List'),
       ),
       drawer : StylishDrawer(),
      body: listdata.length > 0 ? ListView.builder(
        itemCount: listdata.length,
        itemBuilder: (context, index) {
          return Column(children: [
            ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(Strings.IMAGE_BASE_URL+"/uploads/"+listdata[index].pic1.toString()),
            ),
            title: Text(listdata[index].name.toString()+" "+listdata[index].surname.toString()),
            subtitle: Text( listdata[index].content.toString() == "null" ?  "No Chat Data"  : listdata[index].content.toString().contains("__**") ?  listdata[index].content.toString().split("__**")[2] : listdata[index].content.toString()  , maxLines: 1 , style: TextStyle(overflow: TextOverflow.ellipsis , color: Colors.grey),),
            trailing: Text( listdata[index].date.toString().toString() == "null" ? "" : listdata[index].date.toString() == DateFormat('dd-MM-yyyy').format(DateTime.now()) ? listdata[index].time.toString() : listdata[index].date.toString() , style: TextStyle(overflow: TextOverflow.ellipsis , color: Colors.grey)),
            onTap: () async {

              SharedPreferences prefs = await SharedPreferences.getInstance();
              navService.pushNamed("/chat_screen" ,args: [prefs.getString(SharedPrefs.userId).toString() , listdata[index].id.toString() , prefs.getString(SharedPrefs.fullname).toString() , listdata[index].name.toString()+" "+listdata[index].surname.toString()]);

            },
          ) ,
            Divider(color: Colors.brown, thickness: 0.1,)
          ],);
        }
      ) : Center(child: Text("No Chat to Display"),),
    );






  }




}