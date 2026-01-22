// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateModel _$StateModelFromJson(Map<String, dynamic> json) => StateModel(
      id: json['Id'] as int,
      stateName: json['state_name'] as String,
      stateHindi: json['state_hindi'] ,
      stateGuj: json['state_guj'],
      stateMarathi: json['state_marathi'],
      stateTamil: json['state_tamil'],
      stateUrdu: json['state_urdu'],
      countryId: json['country_id'],
    );

Map<String, dynamic> _$StateModelToJson(StateModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'state_name': instance.stateName,
      'state_hindi': instance.stateHindi,
      'state_guj': instance.stateGuj,
      'state_marathi': instance.stateMarathi,
      'state_tamil': instance.stateTamil,
      'state_urdu': instance.stateUrdu,
      'country_id': instance.countryId,
    };

StateData _$StateDataFromJson(Map<String, dynamic> json) => StateData(
      success: json['success'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) =>
                    MapEntry(k, StateModel.fromJson(e as Map<String, dynamic>)),
              ))
          .toList(),
    );

Map<String, dynamic> _$StateDataToJson(StateData instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
