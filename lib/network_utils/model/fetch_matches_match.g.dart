// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_matches_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMatch _$UserMatchFromJson(Map<String, dynamic> json) => UserMatch(
      name: json['name'] as String,
      mobRegToken: json['mob_reg_token'] != null ?  json['mob_reg_token'] as String : "",
      webRegToken: json['web_reg_token'] != null ?   json['web_reg_token'] as String : "",
      fullname: json['fullname'] as String,
      profileId: json['profile_id'] !=null ? json['profile_id'] as String : "",
      dob: json['dob'] as String,
      userId: json['userId'] as String,
      iitNit: json['iit_nit'] as String?,
      isAdminService: json['is_admin_service'] as String?,
      education: json['education'] as String?,
      occupation: json['occupation'] != null ? json['occupation'] as String?  : "",
      height: json['height'] != null ? json['height'] as String? :"" ,
      likes: json['likes'] != null ? json['likes'] as String : "",
      shortlist: json['shortlist'] != null ? json['shortlist'] as String : "",
      blockedUsers:json['blocked_users'] != null ?  json['blocked_users'] as String : "",
      accept: json['accept'] as String?,
      reject: json['reject'] as String?,
      comments: json['comments'] as String?,
      pic: json['pic'] != null ? json['pic'] as String? : null,
      verifypic1: json['verifypic1'] != null ? json['verifypic1'] as String? : null,
      oldpic1: json['oldpic1'] != null ? json['oldpic1'] as String? : null,
      isinterstSent: json['isinterstSent'] != null ? json['isinterstSent']  as bool : false,
      isshortlist: json['isinterstSent'] != null ? json['isinterstSent'] as bool : false,
      whatsapp: json['whatsapp'] != null ? json['whatsapp'] as String : ""
    );

Map<String, dynamic> _$UserMatchToJson(UserMatch instance) => <String, dynamic>{
      'name': instance.name,
      'mob_reg_token': instance.mobRegToken,
      'web_reg_token': instance.webRegToken,
      'fullname': instance.fullname,
      'profile_id': instance.profileId,
      'dob': instance.dob,
      'userId': instance.userId,
      'iit_nit':  instance.iitNit ,
      'is_admin_service':  instance.isAdminService  ,
      'education': instance.education,
      'occupation': instance.occupation,
      'height': instance.height,
      'likes': instance.likes,
      'shortlist': instance.shortlist,
      'blocked_users': instance.blockedUsers,
      'accept': instance.accept,
      'reject': instance.reject,
      'comments': instance.comments,
      'pic': instance.pic,
       'isshortlist':instance.isshortlist,
      'isinterstSent':instance.isinterstSent
    };

TotalRowCount _$TotalRowCountFromJson(Map<String, dynamic> json) =>
    TotalRowCount(
      totalRowCount: !utils().containsEnglishDigits(json['total_row_count'].toString()) ?  int.parse(utils().marathiToEnglish(json['total_row_count']).toString()) as int : int.parse(json['total_row_count'].toString()),
    );

Map<String, dynamic> _$TotalRowCountToJson(TotalRowCount instance) =>
    <String, dynamic>{
      'total_row_count': instance.totalRowCount,
    };

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) => ResponseData(
      success: json['success'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList())
          .toList(),
    )
      ..incrementValue = json['incrementValue'] != null ? json['incrementValue'] as int : 0
      ..listiusers = (json['listiusers'] != null ? json['listiusers']  as List<dynamic> : [])
          .map((e) => UserMatch.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'incrementValue': instance.incrementValue,
      'listiusers': instance.listiusers,
    };
