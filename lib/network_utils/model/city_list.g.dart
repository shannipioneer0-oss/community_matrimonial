// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityList _$CityListFromJson(Map<String, dynamic> json) => CityList(
      success: json['success'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => CityData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CityListToJson(CityList instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

CityData _$CityDataFromJson(Map<String, dynamic> json) => CityData(
      id: json['Id'] as int,
      cityName: json['city_name'] as String,
    );

Map<String, dynamic> _$CityDataToJson(CityData instance) => <String, dynamic>{
      'Id': instance.id,
      'city_name': instance.cityName,
    };
