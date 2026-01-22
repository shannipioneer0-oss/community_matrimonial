// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertResponse _$InsertResponseFromJson(Map<String, dynamic> json) =>
    InsertResponse(
      success: json['success'] as int,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$InsertResponseToJson(InsertResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
