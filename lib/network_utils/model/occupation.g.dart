// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occupation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Occupation _$OccupationFromJson(Map<String, dynamic> json) => Occupation(
      id: json['Id'] as int,
      occupationName: json['occupation'] as String,
      occupationHindi: json['occup_hindi'] as String,
      occupationGuj: json['occup_guj'] as String,
      occupationMarathi: json['occup_marathi'] as String,
      occupationTamil: json['occup_tamil'] as String,
      occupationUrdu: json['occup_urdu'] as String,
    );

Map<String, dynamic> _$OccupationToJson(Occupation instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'occupation': instance.occupationName,
      'occup_hindi': instance.occupationHindi,
      'occup_guj': instance.occupationGuj,
      'occup_marathi': instance.occupationMarathi,
      'occup_tamil': instance.occupationTamil,
      'occup_urdu': instance.occupationUrdu,
    };

OccupationData _$OccupationDataFromJson(Map<String, dynamic> json) =>
    OccupationData(
      success: json['success'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) =>
                    MapEntry(k, Occupation.fromJson(e as Map<String, dynamic>)),
              ))
          .toList(),
    );

Map<String, dynamic> _$OccupationDataToJson(OccupationData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
