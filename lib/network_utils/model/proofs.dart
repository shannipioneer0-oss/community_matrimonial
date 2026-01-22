



import 'package:json_annotation/json_annotation.dart';

part 'proofs.g.dart';

@JsonSerializable()
class Proofs {
  @JsonKey(name: 'success')
  int success;

  @JsonKey(name: 'data')
  List<DataItem> data;

  Proofs({
    required this.success,
    required this.data,
  });

  factory Proofs.fromJson(Map<String, dynamic> json) =>
      _$ProofsFromJson(json);

  Map<String, dynamic> toJson() => _$ProofsToJson(this);
}

@JsonSerializable()
class DataItem {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'id_proofs')
  String idProofs;

  @JsonKey(name: 'education_proof')
  String educationProof;

  @JsonKey(name: 'income_proof')
  String incomeProof;

  @JsonKey(name: 'is_id_verify')
  String isIdVerify;

  @JsonKey(name: 'is_education_verify')
  String isEducationVerify;

  @JsonKey(name: 'is_income_verify')
  String isIncomeVerify;

  @JsonKey(name: 'userId')
  String userId;

  @JsonKey(name: 'communityId')
  String communityId;

  @JsonKey(name: 'profileId')
  String profileId;

  DataItem({
    required this.id,
    required this.idProofs,
    required this.educationProof,
    required this.incomeProof,
    required this.isIdVerify,
    required this.isEducationVerify,
    required this.isIncomeVerify,
    required this.userId,
    required this.communityId,
    required this.profileId,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) =>
      _$DataItemFromJson(json);

  Map<String, dynamic> toJson() => _$DataItemToJson(this);
}
