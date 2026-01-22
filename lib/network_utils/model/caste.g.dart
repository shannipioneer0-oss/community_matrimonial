// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caste.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

caste _$casteFromJson(Map<String, dynamic> json) => caste(
      success: json['success'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(
                    k, ItemDetails.fromJson(e as Map<String, dynamic>)),
              ))
          .toList(),
    );

Map<String, dynamic> _$casteToJson(caste instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

DataItem _$DataItemFromJson(Map<String, dynamic> json) => DataItem(
      itemDetails: ItemDetails.fromJson(json['0'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataItemToJson(DataItem instance) => <String, dynamic>{
      '0': instance.itemDetails,
    };

ItemDetails _$ItemDetailsFromJson(Map<String, dynamic> json) => ItemDetails(
      id: json['Id'] as int,
      caste: json['caste'] as String,
      religionId: json['religion_id'] as String,
      communityId: json['communityId'] as String,
    );

Map<String, dynamic> _$ItemDetailsToJson(ItemDetails instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'caste': instance.caste,
      'religion_id': instance.religionId,
      'communityId': instance.communityId,
    };
