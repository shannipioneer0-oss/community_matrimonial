
import 'package:json_annotation/json_annotation.dart';

part 'insert_response.g.dart';
// This will be generated

@JsonSerializable()
class InsertResponse {
  @JsonKey(name: 'success')
  final int success;

  @JsonKey(name: 'data')
  final Map<String, dynamic> data;

  InsertResponse({required this.success, required this.data});

  // Factory method to create an instance of InsertResponse from a JSON map
  factory InsertResponse.fromJson(Map<String, dynamic> json) =>
      _$InsertResponseFromJson(json);

  // Method to convert the Dart object to a JSON map
  Map<String, dynamic> toJson() => _$InsertResponseToJson(this);
}