// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
      id: json['Id'] as int,
      country_name: json['country_name'] as String,
      code: json['code'] as String,
      show_hide: json['show_hide'] as String,
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'country_name': instance.country_name,
      'code': instance.code,
      'show_hide': instance.show_hide,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      success: json['success'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(
                    k, CountryModel.fromJson(e as Map<String, dynamic>)),
              ))
          .toList(),
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
