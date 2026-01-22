import 'dart:ffi';

import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
class Message123 extends HiveObject {
  @HiveField(0)
   int Id;
  @HiveField(1)
   String content;
  @HiveField(2)
   String sender;
  @HiveField(3)
   String status;
  @HiveField(4)
   String datetime;
  @HiveField(5)
  String time;
  @HiveField(6)
  String replyId;
  @HiveField(7)
  String reciever_id;

  Message123({
    required this.Id,
    required this.content,
    required this.sender,
    required this.status,
    required this.datetime,
    required this.time,
    required this.replyId,
    required this.reciever_id
  });
}
