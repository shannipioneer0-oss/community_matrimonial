import 'package:json_annotation/json_annotation.dart';

part 'user_plan_data.g.dart';

@JsonSerializable()
class UserPlanData {
  @JsonKey(name: 'validity_days')
  final String? validityDays;

  @JsonKey(name: 'isexpired')
  final String? isExpired;

  @JsonKey(name: 'planId')
  final int? planId;

  @JsonKey(name: 'num_express_interests')
  final String? numExpressInterests;

  @JsonKey(name: 'num_pdf')
  final String? numPdf;

  @JsonKey(name: 'number_contacts')
  final String? numberContacts;

  @JsonKey(name: 'number_horoscope')
  final String? numberHoroscope;

  @JsonKey(name: 'userId')
  final String? userId;

  @JsonKey(name: 'num_contact')
  final int? numContact;

  @JsonKey(name: 'num_horoscope')
  final int? numHoroscope;

  @JsonKey(name: 'num_likes')
  final int? numLikes;

  @JsonKey(name: 'remaining_days')
  final int? remainingDays;

  UserPlanData({
    this.validityDays,
    this.isExpired,
    this.planId,
    this.numExpressInterests,
    this.numPdf,
    this.numberContacts,
    this.numberHoroscope,
    this.userId,
    this.numContact,
    this.numHoroscope,
    this.numLikes,
    this.remainingDays,
  });

  factory UserPlanData.fromJson(Map<String, dynamic> json) =>
      _$UserPlanDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserPlanDataToJson(this);
}
