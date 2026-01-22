// GENERATED CODE - DO NOT MODIFY BY HAND

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_otp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

get_otp _$get_otpFromJson(Map<String, dynamic> json) => get_otp(
  success: json['success'] as int,
  message: (json['message'] as List<dynamic>)
      .map((e) => OtpMessage.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$get_otpToJson(get_otp instance) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message.map((e) => e.toJson()).toList(),
};

OtpMessage _$OtpMessageFromJson(Map<String, dynamic> json) => OtpMessage(
  otp: json['otp'] as String,
);

Map<String, dynamic> _$OtpMessageToJson(OtpMessage instance) =>
    <String, dynamic>{
      'otp': instance.otp,
    };