// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proofs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proofs _$ProofsFromJson(Map<String, dynamic> json) => Proofs(
      success: json['success'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProofsToJson(Proofs instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

DataItem _$DataItemFromJson(Map<String, dynamic> json) => DataItem(
      id: json['Id'] as int,
      idProofs: json['id_proofs'] as String,
      educationProof: json['education_proof'] as String,
      incomeProof: json['income_proof'] as String,
      isIdVerify: json['is_id_verify'] != null ? json['is_id_verify'] as String : "",
      isEducationVerify: json['is_education_verify'] != null ? json['is_education_verify'] as String : "",
      isIncomeVerify: json['is_income_verify'] != null ? json['is_income_verify'] as String : "",
      userId: json['userId'] as String,
      communityId: json['communityId'] as String,
      profileId: json['profileId'] as String,
    );

Map<String, dynamic> _$DataItemToJson(DataItem instance) => <String, dynamic>{
      'Id': instance.id,
      'id_proofs': instance.idProofs,
      'education_proof': instance.educationProof,
      'income_proof': instance.incomeProof,
      'is_id_verify': instance.isIdVerify,
      'is_education_verify': instance.isEducationVerify,
      'is_income_verify': instance.isIncomeVerify,
      'userId': instance.userId,
      'communityId': instance.communityId,
      'profileId': instance.profileId,
    };
