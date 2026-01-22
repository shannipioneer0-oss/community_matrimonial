// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstituteModel _$InstituteModelFromJson(Map<String, dynamic> json) =>
    InstituteModel(
      id: json['Id'] as int,
      instituteName: json['institute_name'] as String,
      instituteHindi: json['institute_hindi'] as String,
      instituteGuj: json['institute_guj'] as String,
      instituteMarathi: json['institute_marathi'] as String,
      instituteTamil: json['institute_tamil'] as String,
      instituteUrdu: json['institute_urdu'] as String,
    );

Map<String, dynamic> _$InstituteModelToJson(InstituteModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'institute_name': instance.instituteName,
      'institute_hindi': instance.instituteHindi,
      'institute_guj': instance.instituteGuj,
      'institute_marathi': instance.instituteMarathi,
      'institute_tamil': instance.instituteTamil,
      'institute_urdu': instance.instituteUrdu,
    };

InstituteList _$InstituteListFromJson(Map<String, dynamic> json) =>
    InstituteList(
      success: json['success'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(
                    k, InstituteModel.fromJson(e as Map<String, dynamic>)),
              ))
          .toList(),
    );

Map<String, dynamic> _$InstituteListToJson(InstituteList instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
