// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipModel _$MembershipModelFromJson(Map<String, dynamic> json) =>
    MembershipModel(
      id: int.parse(json['Id'].toString()) as int,
      image: json['image'] != null ? json['image'] as String : "",
      planName: json['plan_name'] != null ? json['plan_name'] as String : "",
      planPrice: json['plan_price'] != null ? json['plan_price'] as String : "",
      details: json['details'] != null ? json['details'] as String : "",
      validityDays: json['validity_days'] != null ? json['validity_days'] as String : "",
      profileDisplay: json['profile_display'] != null ? json['profile_display'] as String : "",
      galleryView: json['gallery_view'] != null ? json['gallery_view'] as String : "",
      chatOption: json['chatoption'] != null ? json['chatoption'] as String : "",
      expressInterest: json['express_interest'] != null ? json['express_interest'] as String : "",
      numberExpressInterest: json['number_express_interest'] != null ? json['number_express_interest'] as String : "",
      horoscopeView: json['horoscopeview'] != null ? json['horoscopeview'] as String : "",
      pdfAccess: json['pdf_access'] != null ? json['pdf_access'] as String : "",
      numPdfAccess: json['num_pdf_access'] != null ? json['num_pdf_access'] as String : "",
      verifiedPhoneNumbers: json['verified_phonenumbers'] != null ? json['verified_phonenumbers'] as String : "",
      allowedContacts: json['allowed_contacts'] != null ? json['allowed_contacts'] as String : "",
      numberContacts: json['number_contacts'] != null ? json['number_contacts'] as String : "",
      numberHoroscope: json['number_horoscope'] != null ? json['number_horoscope'] as String : "",
      numberChat: json['number_chat'] != null ? json['number_chat'] as String : "",
      numberVideo: json['number_video'] != null ? json['number_video'] as String : "",
      verifiedIdDocs: json['verified_id_docs'] != null ? json['verified_id_docs'] as String : "",
      communityId: json['communityId'] != null ? json['communityId'] as String : "",
      isHidden: json['ishidden'] != null ? json['ishidden'] as String : "",
    );

Map<String, dynamic> _$MembershipModelToJson(MembershipModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'image': instance.image,
      'plan_name': instance.planName,
      'plan_price': instance.planPrice,
      'details': instance.details,
      'validity_days': instance.validityDays,
      'profile_display': instance.profileDisplay,
      'gallery_view': instance.galleryView,
      'chatoption': instance.chatOption,
      'express_interest': instance.expressInterest,
      'number_express_interest': instance.numberExpressInterest,
      'horoscopeview': instance.horoscopeView,
      'pdf_access': instance.pdfAccess,
      'num_pdf_access': instance.numPdfAccess,
      'verified_phonenumbers': instance.verifiedPhoneNumbers,
      'allowed_contacts': instance.allowedContacts,
      'number_contacts': instance.numberContacts,
      'number_horoscope': instance.numberHoroscope,
      'number_chat': instance.numberChat,
      'number_video': instance.numberVideo,
      'verified_id_docs': instance.verifiedIdDocs,
      'communityId': instance.communityId,
      'ishidden': instance.isHidden,
    };

MembershipOrder _$MembershipOrderFromJson(Map<String, dynamic> json) =>
    MembershipOrder(
      id: int.parse(json['Id'].toString()) as int,
      memberName: json['member_name'] as String,
      packageName: json['package_name'] as String,
      paymentMethod: json['payment_method'] as String,
      amount: json['amount'] as String,
      status: json['status'] as String,
      code: json['code']  == "null" ? "" : json['code'] ,
      date: json['date'] as String,
      isExpired: json['isexpired'] as String,
      userId: json['userId'] as String,
      communityId: json['communityId'] as String,
    );

Map<String, dynamic> _$MembershipOrderToJson(MembershipOrder instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'member_name': instance.memberName,
      'package_name': instance.packageName,
      'payment_method': instance.paymentMethod,
      'amount': instance.amount,
      'status': instance.status,
      'code': instance.code,
      'date': instance.date,
      'isexpired': instance.isExpired,
      'userId': instance.userId,
      'communityId': instance.communityId,
    };

MembershipData _$MembershipDataFromJson(Map<String, dynamic> json) =>
    MembershipData(
      success: json['success'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => (e as Map<String, dynamic>).map(
                    (k, e) => MapEntry(
                        k, MembershipModel.fromJson(e as Map<String, dynamic>)),
                  ))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$MembershipDataToJson(MembershipData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
