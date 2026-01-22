// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marital_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaritalStatus _$MaritalStatusFromJson(Map<String, dynamic> json) =>
    MaritalStatus(
      success: json['success'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(
                    k, IdValueLabelItem.fromJson(e as Map<String, dynamic>)),
              ))
          .toList(),
    );

Map<String, dynamic> _$MaritalStatusToJson(MaritalStatus instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

IdValueLabelItem _$IdValueLabelItemFromJson(Map<String, dynamic> json) =>
    IdValueLabelItem(
      id: json['id'] as int,
      value: json['value'] as String,
      label: json['label'] as String,
    );

Map<String, dynamic> _$IdValueLabelItemToJson(IdValueLabelItem instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'value': instance.value,
      'label': instance.label,
    };
