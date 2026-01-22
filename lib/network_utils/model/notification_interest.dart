

import 'package:json_annotation/json_annotation.dart';

part 'notification_interest.g.dart';

@JsonSerializable()
class NotificationInterest {
  final List<List<InterestItem>> data;

  NotificationInterest({
    required this.data,
  });

  factory NotificationInterest.fromJson(Map<String, dynamic> json) =>
      _$NotificationInterestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationInterestToJson(this);
}

@JsonSerializable()
class InterestItem {
  final InterestDetails interestDetails;

  InterestItem({
    required this.interestDetails,
  });

  factory InterestItem.fromJson(Map<String, dynamic> json) =>
      _$InterestItemFromJson(json);

  Map<String, dynamic> toJson() => _$InterestItemToJson(this);
}

@JsonSerializable()
class InterestDetails {
  final String fullname;
  final String age;

  @JsonKey(name: 'marital_status')
  final String maritalStatus;

  @JsonKey(name: 'degree_name')
  final String degreeName;

  @JsonKey(name: 'occupation_name')
  final String occupationName;

  InterestDetails({
    required this.fullname,
    required this.age,
    required this.maritalStatus,
    required this.degreeName,
    required this.occupationName,
  });

  factory InterestDetails.fromJson(Map<String, dynamic> json) =>
      _$InterestDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$InterestDetailsToJson(this);
}
