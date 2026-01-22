import 'package:json_annotation/json_annotation.dart';

part 'get_otp.g.dart';

@JsonSerializable()
class get_otp {
  final int success;
  final List<OtpMessage> message;

  get_otp({required this.success, required this.message});

  factory get_otp.fromJson(Map<String, dynamic> json) =>
      _$get_otpFromJson(json);

  Map<String, dynamic> toJson() => _$get_otpToJson(this);
}

@JsonSerializable()
class OtpMessage {
  final String otp;

  OtpMessage({required this.otp});

  factory OtpMessage.fromJson(Map<String, dynamic> json) =>
      _$OtpMessageFromJson(json);

  Map<String, dynamic> toJson() => _$OtpMessageToJson(this);
}