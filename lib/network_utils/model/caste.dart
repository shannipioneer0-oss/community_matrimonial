
import 'package:json_annotation/json_annotation.dart';

part 'caste.g.dart';

@JsonSerializable()
class caste {
  @JsonKey(name: 'success')
  int success;

  @JsonKey(name: 'data')
  List<Map<String, ItemDetails>> data;

  caste({
    required this.success,
    required this.data,
  });


  factory caste.fromJson(Map<String, dynamic> json) =>
      _$casteFromJson(json);

  Map<String, dynamic> toJson() => _$casteToJson(this);
}

@JsonSerializable()
class DataItem {
  @JsonKey(name: '0')
  ItemDetails itemDetails;

  DataItem({required this.itemDetails});

  factory DataItem.fromJson(Map<String, dynamic> json) =>
      _$DataItemFromJson(json);

  Map<String, dynamic> toJson() => _$DataItemToJson(this);
}

@JsonSerializable()
class ItemDetails {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'caste')
  String caste;

  @JsonKey(name: 'religion_id')
  String religionId;

  @JsonKey(name: 'communityId')
  String communityId;

  ItemDetails({
    required this.id,
    required this.caste,
    required this.religionId,
    required this.communityId,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailsToJson(this);
}

