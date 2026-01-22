

import 'package:json_annotation/json_annotation.dart';

part 'pictures.g.dart';

@JsonSerializable()
class Pictures {
  @JsonKey(name: 'success')
  int success;

  @JsonKey(name: 'data')
  List<DataItem> data;

  Pictures({
    required this.success,
    required this.data,
  });

  factory Pictures.fromJson(Map<String, dynamic> json) =>
      _$PicturesFromJson(json);

  Map<String, dynamic> toJson() => _$PicturesToJson(this);
}

@JsonSerializable()
class DataItem {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'pic1')
  String pic1;

  @JsonKey(name: 'pic2')
  String pic2;

  @JsonKey(name: 'pic3')
  String pic3;

  @JsonKey(name: 'pic4')
  String pic4;

  @JsonKey(name: 'pic5')
  String pic5;

  @JsonKey(name: 'pic6')
  String pic6;

  @JsonKey(name: 'pic7')
  String pic7;

  @JsonKey(name: 'pic8')
  String pic8;

  @JsonKey(name: 'pic9')
  String? pic9;

  @JsonKey(name: 'pic10')
  String? pic10;

  @JsonKey(name: 'isverifypic1')
  String isVerifyPic1;

  @JsonKey(name: 'isverifypic2')
  String isVerifyPic2;

  @JsonKey(name: 'isverifypic3')
  String isVerifyPic3;

  @JsonKey(name: 'isverifypic4')
  String isVerifyPic4;

  @JsonKey(name: 'isverifypic5')
  String isVerifyPic5;

  @JsonKey(name: 'isverifypic6')
  String isVerifyPic6;

  @JsonKey(name: 'isverifypic7')
  String isVerifyPic7;

  @JsonKey(name: 'isverifypic8')
  String isVerifyPic8;

  @JsonKey(name: 'isverifypic9')
  String isVerifyPic9;

  @JsonKey(name: 'isverifypic10')
  String isVerifyPic10;

  @JsonKey(name: 'userId')
  String userId;

  @JsonKey(name: 'communityId')
  String communityId;

  @JsonKey(name: 'profileId')
  String profileId;

  DataItem({
    required this.id,
    required this.pic1,
    required this.pic2,
    required this.pic3,
    required this.pic4,
    required this.pic5,
    required this.pic6,
    required this.pic7,
    required this.pic8,
    this.pic9,
    this.pic10,
    required this.isVerifyPic1,
    required this.isVerifyPic2,
    required this.isVerifyPic3,
    required this.isVerifyPic4,
    required this.isVerifyPic5,
    required this.isVerifyPic6,
    required this.isVerifyPic7,
    required this.isVerifyPic8,
    required this.isVerifyPic9,
    required this.isVerifyPic10,
    required this.userId,
    required this.communityId,
    required this.profileId,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) =>
      _$DataItemFromJson(json);

  Map<String, dynamic> toJson() => _$DataItemToJson(this);
}
