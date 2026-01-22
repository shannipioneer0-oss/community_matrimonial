// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      data: (json['data'] as List<dynamic>)
        .map((e) => (e as List<dynamic>)
        .map((e) => (e as Map<String, dynamic>).map(
          (k, e) => MapEntry(
          k, NotificationItem.fromJson(e as Map<String, dynamic>)),
    ))
        .toList())
        .toList(),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    NotificationItem(
      id: json['Id']  != null ? json['Id']  as int : 0,
      notificationType: json['notifi_type'] != null ? json['notifi_type'] as String : "",
      message: json['message'] != null ?  json['message'] as String : "",
      senderType: json['sender_type'] != null ? json['sender_type'] as String : "",
      senderId: json['sender_id'] !=null ?  json['sender_id'] as String : "",
      receiverId: json['reciever_id'] != null ? json['reciever_id'] as String : "",
      communityId: json['communityId'] !=null ?  json['communityId'] as String : "",
    );


Map<String, dynamic> _$NotificationItemToJson(NotificationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notifi_type': instance.notificationType,
      'message': instance.message,
      'sender_type': instance.senderType,
      'sender_id': instance.senderId,
      'reciever_id': instance.receiverId,
      'communityId': instance.communityId,
    };
