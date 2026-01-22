import 'package:json_annotation/json_annotation.dart';

part 'city_list.g.dart';

@JsonSerializable()
class CityList {
  @JsonKey(name: 'success')
  final int success;

  @JsonKey(name: 'data')
  final List<CityData> data;

  CityList({
    required this.success,
    required this.data,
  });

  factory CityList.fromJson(Map<String, dynamic> json) =>
      _$CityListFromJson(json);

  Map<String, dynamic> toJson() => _$CityListToJson(this);
}

@JsonSerializable()
class CityData {
  @JsonKey(name: 'Id')
  final int id;

  @JsonKey(name: 'city_name')
  final String cityName;

  CityData({
    required this.id,
    required this.cityName,
  });

  factory CityData.fromJson(Map<String, dynamic> json) =>
      _$CityDataFromJson(json);

  Map<String, dynamic> toJson() => _$CityDataToJson(this);

}