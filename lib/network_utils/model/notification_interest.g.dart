// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_interest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationInterest _$NotificationInterestFromJson(
        Map<String, dynamic> json) =>
    NotificationInterest(
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => InterestItem.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$NotificationInterestToJson(
        NotificationInterest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

InterestItem _$InterestItemFromJson(Map<String, dynamic> json) => InterestItem(
      interestDetails: InterestDetails.fromJson(
          json['interestDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InterestItemToJson(InterestItem instance) =>
    <String, dynamic>{
      'interestDetails': instance.interestDetails,
    };

InterestDetails _$InterestDetailsFromJson(Map<String, dynamic> json) =>
    InterestDetails(
      fullname: json['fullname'] as String,
      age: json['age'] as String,
      maritalStatus: json['marital_status'] as String,
      degreeName: json['degree_name'] as String,
      occupationName: json['occupation_name'] as String,
    );

Map<String, dynamic> _$InterestDetailsToJson(InterestDetails instance) =>
    <String, dynamic>{
      'fullname': instance.fullname,
      'age': instance.age,
      'marital_status': instance.maritalStatus,
      'degree_name': instance.degreeName,
      'occupation_name': instance.occupationName,
    };
