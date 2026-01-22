// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pictures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pictures _$PicturesFromJson(Map<String, dynamic> json) => Pictures(
      success: json['success'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PicturesToJson(Pictures instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

DataItem _$DataItemFromJson(Map<String, dynamic> json) => DataItem(
      id: json['Id'] as int,
      pic1: json['pic1'] != null ? json['pic1'] as String : "",
      pic2: json['pic2'] != null ? json['pic2'] as String : "",
      pic3: json['pic3'] != null ? json['pic3'] as String : "",
      pic4: json['pic4'] !=null ? json['pic4'] as String : "",
      pic5: json['pic5'] != null ? json['pic5']  as String : "",
      pic6: json['pic6'] != null ? json['pic6'] as String : "",
      pic7: json['pic7'] != null ? json['pic7'] as String : "",
      pic8: json['pic8'] != null ? json['pic8'] as String : "",
      pic9: json['pic9'] != null ? json['pic9'] as String : "",
      pic10: json['pic10'] != null ? json['pic10'] as String : "",
      isVerifyPic1: json['isverifypic1'] as String,
      isVerifyPic2: json['isverifypic2'] as String,
      isVerifyPic3: json['isverifypic3'] as String,
      isVerifyPic4: json['isverifypic4'] as String,
      isVerifyPic5: json['isverifypic5'] as String,
      isVerifyPic6: json['isverifypic6'] as String,
      isVerifyPic7: json['isverifypic7'] as String,
      isVerifyPic8: json['isverifypic8'] as String,
      isVerifyPic9: json['isverifypic9'] as String,
      isVerifyPic10: json['isverifypic10'] as String,
      userId: json['userId'] as String,
      communityId: json['communityId'] as String,
      profileId: json['profileId'] as String,
    );

Map<String, dynamic> _$DataItemToJson(DataItem instance) => <String, dynamic>{
      'Id': instance.id,
      'pic1': instance.pic1,
      'pic2': instance.pic2,
      'pic3': instance.pic3,
      'pic4': instance.pic4,
      'pic5': instance.pic5,
      'pic6': instance.pic6,
      'pic7': instance.pic7,
      'pic8': instance.pic8,
      'pic9': instance.pic9,
      'pic10': instance.pic10,
      'isverifypic1': instance.isVerifyPic1,
      'isverifypic2': instance.isVerifyPic2,
      'isverifypic3': instance.isVerifyPic3,
      'isverifypic4': instance.isVerifyPic4,
      'isverifypic5': instance.isVerifyPic5,
      'isverifypic6': instance.isVerifyPic6,
      'isverifypic7': instance.isVerifyPic7,
      'isverifypic8': instance.isVerifyPic8,
      'isverifypic9': instance.isVerifyPic9,
      'isverifypic10': instance.isVerifyPic10,
      'userId': instance.userId,
      'communityId': instance.communityId,
      'profileId': instance.profileId,
    };
