// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edu_degree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EduDegree _$EduDegreeFromJson(Map<String, dynamic> json) => EduDegree(
      id: json['Id'] as int,
      degreeName: json['degree_name'] as String,
      degreeHindi: json['degree_hindi'] as String,
      degreeGuj: json['degree_guj'] as String,
      degreeMarathi: json['degree_marathi'] as String,
      degreeTamil: json['degree_tamil'] as String,
      degreeUrdu: json['degree_urdu'] as String,
    );

Map<String, dynamic> _$EduDegreeToJson(EduDegree instance) => <String, dynamic>{
      'Id': instance.id,
      'degree_name': instance.degreeName,
      'degree_hindi': instance.degreeHindi,
      'degree_guj': instance.degreeGuj,
      'degree_marathi': instance.degreeMarathi,
      'degree_tamil': instance.degreeTamil,
      'degree_urdu': instance.degreeUrdu,
    };

DegreesList _$DegreesListFromJson(Map<String, dynamic> json) => DegreesList(
      success: json['success'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) =>
                    MapEntry(k, EduDegree.fromJson(e as Map<String, dynamic>)),
              ))
          .toList(),
    );

Map<String, dynamic> _$DegreesListToJson(DegreesList instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
