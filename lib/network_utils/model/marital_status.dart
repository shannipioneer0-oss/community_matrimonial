
import 'package:json_annotation/json_annotation.dart';

part 'marital_status.g.dart';

@JsonSerializable()
class MaritalStatus {
  @JsonKey(name: 'success')
  int success;

  @JsonKey(name: 'data')
  List<Map<String, IdValueLabelItem>> data;

  MaritalStatus({
    required this.success,
    required this.data,
  });


  factory MaritalStatus.fromJson(Map<String, dynamic> json) =>
      _$MaritalStatusFromJson(json);

  Map<String, dynamic> toJson() => _$MaritalStatusToJson(this);
}

@JsonSerializable()
class IdValueLabelItem {
  @JsonKey(name: 'Id')
  int id;


  @JsonKey(name: 'value')
  String value;

  @JsonKey(name: 'label')
  String label;

  IdValueLabelItem({
    required this.id,
    required this.value,
    required this.label,
  });


  factory IdValueLabelItem.fromJson(Map<String, dynamic> json) =>
      _$IdValueLabelItemFromJson(json);

  Map<String, dynamic> toJson() => _$IdValueLabelItemToJson(this);
}
