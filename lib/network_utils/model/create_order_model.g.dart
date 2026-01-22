// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderModel _$CreateOrderModelFromJson(Map<String, dynamic> json) =>
    CreateOrderModel(
      id: json['id'] as String,
      entity: json['entity'] as String,
      amount: json['amount'] as int,
      amountPaid: json['amountPaid'] as int,
      amountDue: json['amountDue'] as int,
      currency: json['currency'] as String,
      receipt: json['receipt'] as String,
      offerId: json['offerId'] as String,
      status: json['status'] as String,
      attempts: json['attempts'] as int,
      notes: Map<String, String>.from(json['notes'] as Map),
      createdAt: json['createdAt'] as int,
    );

Map<String, dynamic> _$CreateOrderModelToJson(CreateOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entity': instance.entity,
      'amount': instance.amount,
      'amountPaid': instance.amountPaid,
      'amountDue': instance.amountDue,
      'currency': instance.currency,
      'receipt': instance.receipt,
      'offerId': instance.offerId,
      'status': instance.status,
      'attempts': instance.attempts,
      'notes': instance.notes,
      'createdAt': instance.createdAt,
    };
