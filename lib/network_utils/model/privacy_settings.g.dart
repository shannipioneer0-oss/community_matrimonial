// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivacySettings _$PrivacySettingsFromJson(Map<String, dynamic> json) =>
    PrivacySettings(
      id: json['Id'] != null ? json['Id']  as int : -1,
      phonePrivacy: json['phone_privacy'] != null ? json['phone_privacy'] as String : "",
      photoPrivacy: json['photo_privacy'] != null ? json['photo_privacy'] as String : "",
      horoscopePrivacy: json['horoscope_privacy'] != null ?  json['horoscope_privacy'] as String : "",
      userId: json['userId'] != null ?  json['userId'] as String : "",
      communityId: json['communityId'] != null ? json['communityId'] as String : "",
      profileId: json['profileId'] != null ? json['profileId'] as String : "",
    );

Map<String, dynamic> _$PrivacySettingsToJson(PrivacySettings instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'phone_privacy': instance.phonePrivacy,
      'photo_privacy': instance.photoPrivacy,
      'horoscope_privacy': instance.horoscopePrivacy,
      'userId': instance.userId,
      'communityId': instance.communityId,
      'profileId': instance.profileId,
    };
