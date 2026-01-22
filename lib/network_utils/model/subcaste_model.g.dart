// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcaste_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubcasteModel _$SubcasteModelFromJson(Map<String, dynamic> json) =>
    SubcasteModel(
      id: json['Id'] as int,
      subcaste: json['subcaste'] as String,
      casteId: json['casteId'] as String,
      communityId: json['communityId'] as String,
    );

Map<String, dynamic> _$SubcasteModelToJson(SubcasteModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'subcaste': instance.subcaste,
      'casteId': instance.casteId,
      'communityId': instance.communityId,
    };

SubcasteData _$SubcasteDataFromJson(Map<String, dynamic> json) => SubcasteData(
      success: json['success'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(
                    k, SubcasteModel.fromJson(e as Map<String, dynamic>)),
              ))
          .toList(),
    );

Map<String, dynamic> _$SubcasteDataToJson(SubcasteData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
