// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_matches.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      mobRegToken: json['mob_reg_token'] != null ? json['mob_reg_token']  as String : "",
      webRegToken: json['web_reg_token'] != null ? json['web_reg_token'] as String : "",
      fullname: json['fullname'] as String,
      profileId: json['profile_id'] as String,
      dob: json['dob'] as String,
      userId: json['userId'] as String,
      iitNit: json['iit_nit'] != null ? json['iit_nit'] as String : "",
      isAdminService: json['is_admin_service'] != null ? json['is_admin_service'] as String : "" ,
      education: json['education'] != null ? json['education'] as String : "",
      occupation: json['occupation'] != null ? json['occupation'] as String : "",
      height: json['height'] != null ? json['height']as String : "",
      likes: json['likes'] != null ? json['likes'] as String : "",
      shortlist: json['shortlist'] != null ?  json['shortlist'] as String : "",
      blockedUsers: json['blocked_users'] != null ? json['blocked_users'] as String : "",
      isshortlist: json['isshortlist'] != null ? json['isshortlist'] as bool : false,
      isinterstSent: json['isinterstSent'] != null ? json['isinterstSent']  as bool :false,
      pic: json['pic'] !=null ? json['pic'] : "",
      whatsapp: json["whatsapp"] != null ? json["whatsapp"] : "",
      verifypic1: json["verifypic1"] != null ? json["verifypic1"] : "",
      oldpic1: json["oldpic1"] != null ? json["oldpic1"] : "",
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'mob_reg_token': instance.mobRegToken,
      'web_reg_token': instance.webRegToken,
      'fullname': instance.fullname,
      'profile_id': instance.profileId,
      'dob': instance.dob,
      'userId': instance.userId,
      'iit_nit': instance.iitNit,
      'is_admin_service': instance.isAdminService,
      'education': instance.education,
      'occupation': instance.occupation,
      'height': instance.height,
      'likes': instance.likes,
      'shortlist': instance.shortlist,
      'blocked_users': instance.blockedUsers,
      'isshortlist':instance.isshortlist,
      'isinterstSent':instance.isinterstSent,
       'pic':instance.pic
    };

TotalRowCount _$TotalRowCountFromJson(Map<String, dynamic> json) =>
    TotalRowCount(
      totalRowCount: json['total_row_counts'] as int,
    );

Map<String, dynamic> _$TotalRowCountToJson(TotalRowCount instance) =>
    <String, dynamic>{
      'total_row_counts': instance.totalRowCount,
    };

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) => ResponseData(
      success: json['success'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList())
          .toList(),
    )
      ..incrementValue = json['incrementValue'] != null ? json['incrementValue']  as int : 0
      ..listiusers = (json['listiusers'] != null ? json['listiusers'] as List<dynamic> : [])
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'incrementValue': instance.incrementValue,
      'listiusers': instance.listiusers,
    };
