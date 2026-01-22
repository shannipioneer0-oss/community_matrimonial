

import 'package:json_annotation/json_annotation.dart';

part 'update_response.g.dart';

@JsonSerializable()
class UpdateResponse {
  @JsonKey(name: 'success')
  final int success;

  @JsonKey(name: 'message')
  final String message;

  UpdateResponse({required this.success, required this.message});

  factory UpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateResponseToJson(this);
}