import 'dart:ffi';
import 'dart:io' as f;
import 'dart:io';


import 'package:community_matrimonial/app_utils/Dialogs.dart';
import 'package:community_matrimonial/screens/chat/MessageDataStore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'models/message.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;



class ChatScreen extends StatefulWidget {

   final List list;
    ChatScreen(this.list);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  static TextEditingController _messageController = TextEditingController();
  late io.Socket socket;

  final MessageDataStore dataStore = MessageDataStore();

  ScrollController _controller = ScrollController();



  @override
  void initState() {
    super.initState();




    name = widget.list[2];
    other_user = widget.list[1];
    sender = widget.list[0];
    reciever = widget.list[1];

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollToEnd();
    });



    print(sender+"___"+reciever+"___"+widget.list[3]);


    connectToServer();


  }



  void _scrollToEnd() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }



  String other_userid = "";
  String self_id = "" , name = "" , other_user  ="";
  String room = "" , sender = "" , reciever = "" , replyId = "0";
  bool reply = false;
  Future<void> connectToServer() async {
    // Connect to the Node.js server

    print(other_user);

    socket = io.io('https://matrichatservice.shannishah.com/', <String, dynamic>{
      'transports': ['websocket'],
    });

    // Connect to the server
    socket.connect();

    socket.on('connect', (_) {

      self_id = socket.id.toString();


      if(int.parse(sender) > int.parse(reciever)){
        room = sender+"_"+reciever;
      }else{
        room = reciever+"_"+sender;
      }

      print("roomid"+room);

      socket.emit('joinRoom', {"roomId" : room , "username" : reciever});
      socket.emit('onpageopened', {
        'recieverSocketid': self_id ,
        'roomId':room,
        'reciever_id':sender
      });


      checkStatus_updatestatus();

    });

    socket.on('roomUsers', (data) {
      List<String> users = List<String>.from(data['users']);
      //String selfSocketId = data['selfSocketId'];

      print('Room Users: $users');

     // setState(() {
      if(users.length == 2) {
        other_userid =
        users.singleWhere((element) => element != self_id) == null ? "" : users
            .singleWhere((element) => element != self_id);
        print(other_userid+"======");
      }
        //selfSocketId = selfSocketId;
     // });


    });

    // Fetch offline messages and display
    //_fetchOfflineMessages();

    socket.on('deletechat' , (data){

      int index = MessageDataStore.box.values.toList().indexWhere((element) => element.Id == data["chat_id"]);

      print(index.toString()+"------");

      MessageDataStore.box.deleteAt(index);
    });

    // Listen for incoming messages from the server
    socket.on('receiveMessage' , (data) {

      print(data.toString()+"}}}}}}}");
      // Check if the message is for the current room
      if (data['room'] == room) {

        print(room+"_________________________");

        _insertMessage(data);
        _markAsRead(int.parse(data['chat_id']));
      }

    });


    // Listen for message read acknowledgment
    socket.on('messageReadAck', (data) {
      final messageId = data['messageId'];

      print(messageId);

      // Update the UI with the read status (you can handle it accordingly)
      _updateReadStatus(messageId);
    });

  }

  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }

  Future<void> _insertMessage(Map<String, dynamic> data) async {

    print(data.toString());

    DateTime now = DateTime.now();
    // Save the message to Hive
    await dataStore.addMessage(message: Message123(
        Id: int.parse(data['chat_id']),
        content: data['content'],
        sender: data['sender'].toString(),
        status: data['status'],
        datetime: data['date'] != null ? data['date'] : "",
        time: data['time'] != null ? data['time'] : '',
        replyId: data['replyId'] != null ? data['replyId'] : "",
        reciever_id: data['receiver_id'] != null ? data['receiver_id'].toString() : ""
    ));

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollToEnd();
    });


  }

  /*Future<void> _fetchOfflineMessages() async {
    // Fetch all messages from Hive
    final List<Message> messages = messageBox.values.toList();

    setState(() {

    });
  }*/



   checkStatus_updatestatus(){

   List<Message123> listtocheck =  MessageDataStore.box.values.toList().where((message) => (message.status == 'sent' || message.status == 'received') && message.sender == sender ).toList();

   listtocheck.forEach((element) {

     print(element.Id.toString()+"------"+self_id+"-----"+room);

     socket.emit('update_status',{
       "chat_id":element.Id,
       "recieverSocketid":self_id,
       "roomId":room
     });

   });



  }



  late ConnectivityResult _connectivityResult;
  Future<void> _sendMessage() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

   ConnectivityResult result = await Connectivity().checkConnectivity();
            setState(() {
              _connectivityResult = result;
            });
    if (_connectivityResult == ConnectivityResult.none) {

      DialogClass().showDialog2(context, "No Internet", "Sorry Internet is not available", "OK");

    }else {

      DateTime datetime = DateTime.now();
      String chat_id = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();

      String hour = "",
          minute = "" , seconds = "";
      if (datetime.hour
          .toString()
          .length == 1) {
        hour = "0" + datetime.hour.toString();
      } else {
        hour = datetime.hour.toString();
      }

      if (datetime.minute
          .toString()
          .length == 1) {
        minute = "0" + datetime.minute.toString();
      } else {
        minute = datetime.minute.toString();
      }


      if (datetime.second
          .toString()
          .length == 1) {
        seconds = "0" + datetime.second.toString();
      } else {
        seconds = datetime.second.toString();
      }

      String messageContent = "";

      if (reply == false) {
        messageContent = _messageController.text;
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        if (widget.list[0] == msgtocheck.sender) {
          messageContent = name + "__**" + msgtocheck.content + "__**" +
              _messageController.text;
        } else {
          messageContent = other_user + "__**" + msgtocheck.content + "__**" +
              _messageController.text;
        }

        setState(() {
          reply = false;
        });
      }

      if (messageContent.isNotEmpty) {
        String day = datetime.day.toString();
        String month = datetime.month.toString();
        if (day.length <= 1) {
          day = "0" + day;
        }

        if (month.length <= 1) {
          month = "0" + month;
        }

        // Send message to the server, specifying the room
        socket.emit('sendMessage', {
          'chat_id': chat_id,
          'receiverSocketId': other_userid,
          'room': room, // Update with your room ID
          'content': messageContent,
          'sender': sender,
          'receiver': reciever, // Update with the sender's username
          'date': day.toString() + "-" + month.toString() + "-" +
              datetime.year.toString(),
          'time': hour + ":" + minute + ":" + seconds,
          'replyId': replyId
        });


        print(reciever + "{}{}{}{}{}");
        // Save message offline with status 'sent'
        _insertMessage({
          'chat_id': chat_id,
          'content': messageContent,
          'sender': sender,
          'status': 'sent',
          'date': day.toString() + "-" + month.toString() + "-" +
              datetime.year.toString(),
          'time': hour + ":" + minute + ":" + seconds,
          'replyId': replyId,
          'receiver_id': reciever
        });

        // Clear the text field
        _messageController.clear();
      }
    }
  }

  void _markAsRead(int messageId) {
    // Send a request to the server to mark the message as read
    socket.emit('markAsRead', {
      'room': room,
      'messageId': messageId,
    });

  //0etState(() {
      // Update the UI with the read status (you can handle it accordingly)
      _updateReadStatus(messageId);
   //});
  }

  void _updateReadStatus(int messageId) {
    // Update the read status of the message in Hive
    print(messageId.toString()+"-------------"+MessageDataStore.box.values.toList()[MessageDataStore.box.values.length-1].Id.toString());

    MessageDataStore.box.values.toList()[MessageDataStore.box.values.length-1];


    final messageIndex = MessageDataStore.box.values.toList().indexWhere((message) => message.Id == messageId);

    print(messageIndex.toString()+"-------------");

    if (messageIndex != -1) {
      final updatedMessage = MessageDataStore.box.getAt(messageIndex);
      if (updatedMessage != null) {
        updatedMessage.status = 'read';
        MessageDataStore.box.putAt(messageIndex, updatedMessage);

        print(updatedMessage.status+"-------------");

      }
    }

    setState(() {
      // Update the UI with the read status (you can handle it accordingly)
    });
  }










































  void _prompt(String url) {
    print('Please go to the following URL and grant access:');
    print('  => $url');
    print('');
  }



  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Chat with '+widget.list[3]),
        actions: [GestureDetector(onTap: () async {


        }   ,child:Text("Upload"))],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: MessageDataStore.box.listenable(),
              builder: (context,  box, _) {


               // box.clear();


                for(int i=0; i<box.length; i++){
                  print(sender+"=-=-=-=-="+reciever);
                }

              List<Message123> list = box.values.toList();

                for(int i=0; i<list.length; i++){
                  print(list[i].content+"[][][]"+list[i].sender+"[][][]"+list[i].reciever_id);
                }

                /*return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final message = box.getAt(index);
                    return  ListTile(
                      title: Text(message!.content),
                      subtitle: Text(message.sender),
                      trailing: _buildTickWidget(message.status),
                      onTap: () {
                        // Mark the message as read when tapped
                        _markAsRead(message.Id);
                      },
                    );
                  },
                );*/

                for(int i=0; i<box.length; i++){

                  print(box.getAt(i)!.sender.toString()+"+++++"+box.getAt(i)!.reciever_id+"+++++"+reciever+"++++"+sender);
                }

                return  GroupedListView<Message123, String>(
                  controller: _controller,
                  elements: box.values.toList().where((element) => (element.sender == sender && element.reciever_id == reciever) ||  (element.sender == reciever && element.reciever_id == sender)).toList(),
                  groupBy: (element) => element.datetime,
                  groupSeparatorBuilder: (String groupByValue) { return  SizedBox(child:Container( key:Key(groupByValue)  , margin: EdgeInsets.only(top: 20 , left:MediaQuery.of(context).size.width*0.2 , right: MediaQuery.of(context).size.width*0.2)  , padding: EdgeInsets.all(10) , decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(20), // Adjust radius as needed
                  ), child:Text(  DateFormat('MMMM dd, yyyy, EEEE').format(DateTime(int.parse(groupByValue.split("-")[2]) , int.parse(groupByValue.split("-")[1]) , int.parse(groupByValue.split("-")[0]))) , textAlign: TextAlign.center ,style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),)); } ,

                    itemBuilder: (context,  element) {

                    print(widget.list[0]+"___"+element.content+"_____"+element.datetime);

                    return GestureDetector(onTap:(){

                      showPopup(context , element);

                    } ,child: Row(
                      mainAxisAlignment:
                      widget.list[0] == element.sender ? MainAxisAlignment.end : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                         Avatar(
                          image: "assets/images/",
                          size: 50,
                        ),
                        Flexible(
                          child: element.content.contains("__**") ? widget.list[0] == element.sender ? ReplyContainer(sender:  element.content.split("__**")[0] == name ? "You" : widget.list[3] , sender_msg: element.content.split("__**")[1], message: element.content.split("__**")[2], onReplyPressed: () {  }, isSender: widget.list[0] == element.sender,) :  ReplyContainer(sender: element.content.split("__**")[0] == name ? "You" : widget.list[3]   , sender_msg: element.content.split("__**")[1], message: element.content.split("__**")[2], onReplyPressed: () {  }, isSender: widget.list[0] == element.sender,) :  Container(
                            margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:  widget.list[0] == element.sender ? Colors.indigo.shade100 : Colors.indigo.shade50,
                              borderRadius:  widget.list[0] == element.sender
                                  ? BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              )
                                  : BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Text(element.content),


                          ),
                        ),

                        Column(children: [

                          widget.list[0] == element.sender ? _buildTickWidget(element.status) : Container()
                          ,
                          Container(margin: EdgeInsets.only(left: 5) ,child:Text(
                          element.time,
                          style: TextStyle(color: Colors.grey),
                        ))],)

                      ],
                    ));

                  },

                  itemComparator: (element1, element2) {

                    return element1.time.compareTo(element2.time);

                  },
                  useStickyGroupSeparators: false, // optional
                  floatingHeader: true, // optional
                  order: GroupedListOrder.ASC, // optional
                );





              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [

                Expanded(
                  child: reply == false ?   Container(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: TextField(
      controller: _messageController,
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
    filled: true,
    fillColor: Colors.pink.withOpacity(0.1),
    hintText: 'Enter your text',
    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.pink),
    ),
    ),
    ),
    ) : RoundedContainer(title: msgtocheck.sender == widget.list[0] ? "You" : other_user, subtitle: msgtocheck.content , onClosePressed: () {

                    setState(() {
                      reply = false;
                      replyId = "0";
                    });

                  },),
                ),
                IconButton(
                  icon: Icon(Icons.send , color: Colors.pink, size: 35),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );




  }

  Widget _buildTickWidget(String status) {
    switch (status) {
      case 'sent':
        return Icon(Icons.check, color: Colors.grey ,size: 20,); // Single tick
      case 'received':
        return Icon(Icons.done_all, color: Colors.grey ,size: 20); // Double tick
      case 'read':
        return Icon(Icons.done_all, color: Colors.green , size: 20); // Blue tick
      default:
        return Container();
    }
  }



   Message123 msgtocheck = Message123(Id: -1, content: "", sender: "", status: "", datetime: "", time: "", replyId: "", reciever_id: '');
  void showPopup(BuildContext context , Message123 msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            msg.sender == sender ? TextButton(
              onPressed: () {

                Navigator.of(context).pop();
                socket.emit('deletechat', {
                  'chat_id': msg.Id,
                  'recieverSocketid':other_userid
                });

                MessageDataStore.box.deleteAt(MessageDataStore.box.values.toList().indexWhere((element) => element.Id == msg.Id));

              },
              child: Text('Delete'),
            ) : Text(""),
            TextButton(
              onPressed: () {
                setState(() {
                  reply = true;
                  replyId = msg.Id.toString();
                  msgtocheck = msg;
                });

                Navigator.of(context).pop();

              },
              child: Text('Reply'),
            ),
          ],
        );
      },
    );
  }



  @override
  void dispose() {
    socket.disconnect();

    socket.close();
    socket.dispose();

    print("[][][]");
    super.dispose();
  }


}



class Avatar extends StatelessWidget {
  final double size;
  final image;
  final EdgeInsets margin;
  Avatar({this.image, this.size = 50, this.margin = const EdgeInsets.all(0)});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            image: NetworkImage(image),
          ),
        ),
      ),
    );
  }
}









class RoundedContainerWithText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Title',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Subtitle',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter text...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class RoundedContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onClosePressed;

  RoundedContainer({
    required this.title,
    required this.subtitle,
    required this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Adjust the width as needed
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16.0),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: onClosePressed,
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextField(
              controller: _ChatScreenState._messageController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.6),
                hintText: 'Enter your text',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.pink),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}







class ReplyContainer extends StatelessWidget {
  
  final bool isSender;
  final String sender;
  final String sender_msg;
  final String message;
  final VoidCallback onReplyPressed;

  ReplyContainer({
    required this.isSender,
    required this.sender,
    required this.sender_msg,
    required this.message,
    required this.onReplyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: isSender ? Colors.indigo.shade100 : Colors.indigo.shade50,
        borderRadius:  isSender
            ? BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        )
            : BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(8.0),
            child:Column(children: [

              Text(
                sender,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),

              Text(
                sender_msg,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                ),
              ),
            ],)
          ),
          SizedBox(height: 2.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // You can change the color here
              borderRadius: BorderRadius.circular(20), // Adjust radius as needed
            ),
            padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.only(top:10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(flex: 3 , child:Text(
                  message,
                  style: TextStyle(fontSize: 16.0),
                ),),

                 Expanded(flex: 1 ,child:IconButton(
                  icon: Icon(Icons.reply ,size: 20,),
                  onPressed: onReplyPressed,
                ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
