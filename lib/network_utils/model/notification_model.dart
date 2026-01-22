


import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: 'data')
  final List<List<Map<String, NotificationItem>>> data;

  NotificationModel({
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class NotificationItem {
  final int id;

  @JsonKey(name: 'notifi_type')
  final String notificationType;

  final String message;

  @JsonKey(name: 'sender_type')
  final String senderType;

  @JsonKey(name: 'sender_id')
  final String senderId;

  @JsonKey(name: 'reciever_id')
  final String receiverId;

  @JsonKey(name: 'communityId')
  final String communityId;

  NotificationItem({
    required this.id,
    required this.notificationType,
    required this.message,
    required this.senderType,
    required this.senderId,
    required this.receiverId,
    required this.communityId,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationItemToJson(this);


}
