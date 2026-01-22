// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_plan_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPlanData _$UserPlanDataFromJson(Map<String, dynamic> json) => UserPlanData(
      validityDays: json['validity_days'] as String?,
      isExpired: json['isexpired'] as String?,
      planId: json['planId'] as int?,
      numExpressInterests: json['num_express_interests'] as String?,
      numPdf: json['num_pdf'] as String?,
      numberContacts: json['number_contacts'] as String?,
      numberHoroscope: json['number_horoscope'] as String?,
      userId: json['userId'] as String?,
      numContact: json['num_contact'] as int?,
      numHoroscope: json['num_horoscope'] as int?,
      numLikes: json['num_likes'] as int?,
      remainingDays: json['remaining_days'] as int?,
    );

Map<String, dynamic> _$UserPlanDataToJson(UserPlanData instance) =>
    <String, dynamic>{
      'validity_days': instance.validityDays,
      'isexpired': instance.isExpired,
      'planId': instance.planId,
      'num_express_interests': instance.numExpressInterests,
      'num_pdf': instance.numPdf,
      'number_contacts': instance.numberContacts,
      'number_horoscope': instance.numberHoroscope,
      'userId': instance.userId,
      'num_contact': instance.numContact,
      'num_horoscope': instance.numHoroscope,
      'num_likes': instance.numLikes,
      'remaining_days': instance.remainingDays,
    };
