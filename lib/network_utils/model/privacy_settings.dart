


import 'package:json_annotation/json_annotation.dart';

part 'privacy_settings.g.dart';

@JsonSerializable()
class PrivacySettings {
  @JsonKey(name: 'Id')
  final int id;

  @JsonKey(name: 'phone_privacy')
  final String phonePrivacy;

  @JsonKey(name: 'photo_privacy')
  final String photoPrivacy;

  @JsonKey(name: 'horoscope_privacy')
  final String horoscopePrivacy;

  @JsonKey(name: 'userId')
  final String userId;

  @JsonKey(name: 'communityId')
  final String communityId;

  @JsonKey(name: 'profileId')
  final String profileId;

  PrivacySettings({
    required this.id,
    required this.phonePrivacy,
    required this.photoPrivacy,
    required this.horoscopePrivacy,
    required this.userId,
    required this.communityId,
    required this.profileId,
  });

  factory PrivacySettings.fromJson(Map<String, dynamic> json) =>
      _$PrivacySettingsFromJson(json);

  Map<String, dynamic> toJson() => _$PrivacySettingsToJson(this);
}
