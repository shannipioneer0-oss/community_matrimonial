import 'dart:ffi';

import 'package:hive/hive.dart';

part 'horoscope.g.dart';

@HiveType(typeId: 1)
class Horoscope extends HiveObject {
  @HiveField(0)
  int Id;
  @HiveField(1)
  String myId;
  @HiveField(2)
  String otheruserId;
  @HiveField(3)
  String birth_chart;
  @HiveField(4)
  String gunmilan;


  Horoscope({
    required this.Id,
    required this.myId,
    required this.otheruserId,
    required this.birth_chart,
    required this.gunmilan
  });
}
