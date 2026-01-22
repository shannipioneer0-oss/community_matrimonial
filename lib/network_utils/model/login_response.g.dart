// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      id: json['Id'] as int,
      name: json['name'] as String,
      surname: json['surname'] as String,
      emailid: json['emailid'] as String,
      gender: json['gender'] as String,
      birthdate: json['birthdate'] as String,
      mobile: json['mobile'] as String,
      profileId: json['profile_id'] as String,
      userVerify: json['user_verify'] as String,
      emailVerify: json['email_verify'] as String,
      mobileVerify: json['mobile_verify'] as String,
      communityId: json['community_id'] as String,
      communityName: json['community_name'] as String,
      deleteAccount: json['delete_account'] as String,
      deleteAccountReason: json['delete_account_reason'] as String,
      mobileRegToken: json['mobile_reg_token'] as String,
      webRegToken: json['web_reg_token'] as String,
      joinedDate: json['joined_date'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'emailid': instance.emailid,
      'gender': instance.gender,
      'birthdate': instance.birthdate,
      'mobile': instance.mobile,
      'profile_id': instance.profileId,
      'user_verify': instance.userVerify,
      'email_verify': instance.emailVerify,
      'mobile_verify': instance.mobileVerify,
      'community_id': instance.communityId,
      'community_name': instance.communityName,
      'delete_account': instance.deleteAccount,
      'delete_account_reason': instance.deleteAccountReason,
      'mobile_reg_token': instance.mobileRegToken,
      'web_reg_token': instance.webRegToken,
      'joined_date': instance.joinedDate,
    };
