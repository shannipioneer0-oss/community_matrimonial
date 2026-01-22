// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDetailsModel _$ProfileDetailsModelFromJson(Map<String, dynamic> json) =>
    ProfileDetailsModel(
      personalInfo: (json['personalInfo'] as List<dynamic>?)
          ?.map((e) => BasicInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      contactInfo: (json['contactInfo'] as List<dynamic>?)
          ?.map((e) => ContactInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      physicalInfo: (json['physicalInfo'] as List<dynamic>?)
          ?.map((e) => PhysicalInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      educationInfo: (json['educationInfo'] as List<dynamic>?)
          ?.map((e) => EducationInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      occupationInfo: (json['occupationInfo'] as List<dynamic>?)
          ?.map((e) => OccupationInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      familyInfo: (json['familyInfo'] as List<dynamic>?)
          ?.map((e) => FamilyInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      astroInfo: (json['astroInfo'] as List<dynamic>?)
          ?.map((e) => AstroInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      photoInfo: (json['photoInfo'] as List<dynamic>?)
          ?.map((e) => PhotoInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      partnerPreferences: (json['partnerPreferences'] as List<dynamic>?)
          ?.map((e) => PartnerPreferences.fromJson(e as Map<String, dynamic>))
          .toList(),
      verificationInfo: (json['verificationInfo'] as List<dynamic>?)
          ?.map((e) => VerificationInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      preferencesInfo: (json['preferencesInfo'] as List<dynamic>?)
          ?.map((e) => PreferencesInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      likesInfo: (json['likesInfo'] as List<dynamic>?)
          ?.map((e) => LikesInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      blockedUsersInfo: (json['blockedUsersInfo'] as List<dynamic>?)
          ?.map((e) => BlockedUsersInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      privacySettings: (json['privacySettings'] as List<dynamic>?)
          ?.map((e) => PrivacySettings.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileDetailsModelToJson(
        ProfileDetailsModel instance) =>
    <String, dynamic>{
      'personalInfo': instance.personalInfo,
      'contactInfo': instance.contactInfo,
      'physicalInfo': instance.physicalInfo,
      'educationInfo': instance.educationInfo,
      'occupationInfo': instance.occupationInfo,
      'familyInfo': instance.familyInfo,
      'astroInfo': instance.astroInfo,
      'photoInfo': instance.photoInfo,
      'partnerPreferences': instance.partnerPreferences,
      'verificationInfo': instance.verificationInfo,
      'preferencesInfo': instance.preferencesInfo,
      'likesInfo': instance.likesInfo,
      'blockedUsersInfo': instance.blockedUsersInfo,
      'privacySettings': instance.privacySettings,
    };

BasicInfo _$BasicInfoFromJson(Map<String, dynamic> json) => BasicInfo(
      id: json['Id'] as int?,
      fullname: json['fullname'] as String?,
      createdBy: json['created_by'] as String?,
      age: json['dob'] as String?,
      maritalStatus: json['marital_status'] as String?,
      caste: json['caste'] as String?,
      subcaste: json['subcaste'] as String?,
      languageKnown: json['language_known'] as String?,
      motherTongue: json['mother_tongue'] as String?,
    );

Map<String, dynamic> _$BasicInfoToJson(BasicInfo instance) => <String, dynamic>{
      'Id': instance.id,
      'fullname': instance.fullname,
      'created_by': instance.createdBy,
      'age': instance.age,
      'marital_status': instance.maritalStatus,
      'caste': instance.caste,
      'subcaste': instance.subcaste,
      'language_known': instance.languageKnown,
      'mother_tongue': instance.motherTongue,
    };

ContactInfo _$ContactInfoFromJson(Map<String, dynamic> json) => ContactInfo(
      mobileNumber: json['mobile_number'] as String?,
      whatsappNumber: json['whatsapp_number'] as String?,
      permanentAddress: json['permanent_adddress'] as String?,
      emailid: json['emailid'] as String?,
      alternateMobile: json['alternate_mobile'] as String?,
      alternateEmail: json['alternate_email'] as String?,
      workingAddress: json['working_address'] as String?,
      contactTime: json['contact_time'] as String?,
      permCountry: json['perm_country'] as String?,
      permState: json['perm_state'] as String?,
      permCity: json['perm_city'] as String?,
      workCountry: json['work_country'] as String?,
      workState: json['work_state'] as String?,
      workCity: json['work_city'] as String?,
    );

Map<String, dynamic> _$ContactInfoToJson(ContactInfo instance) =>
    <String, dynamic>{
      'mobile_number': instance.mobileNumber,
      'whatsapp_number': instance.whatsappNumber,
      'permanent_adddress': instance.permanentAddress,
      'emailid': instance.emailid,
      'alternate_mobile': instance.alternateMobile,
      'alternate_email': instance.alternateEmail,
      'working_address': instance.workingAddress,
      'contact_time': instance.contactTime,
      'perm_country': instance.permCountry,
      'perm_state': instance.permState,
      'perm_city': instance.permCity,
      'work_country': instance.workCountry,
      'work_state': instance.workState,
      'work_city': instance.workCity,
    };

PhysicalInfo _$PhysicalInfoFromJson(Map<String, dynamic> json) => PhysicalInfo(
      weight: json['weight'] as String?,
      height: json['height'] as String?,
      skintone: json['skintone'] as String?,
      bloodGroup: json['blood_group'] as String?,
      fitness: json['fitness'] as String?,
      bodyType: json['body_type'] as String?,
      isHandicap: json['is_handicap'] as String?,
      handicapDetail: json['handicap_detail'] as String?,
      dietType: json['diet_type'] as String?,
      drinkType: json['drink_type'] as String?,
      smokeType: json['smoke_type'] as String?,
    );

Map<String, dynamic> _$PhysicalInfoToJson(PhysicalInfo instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'height': instance.height,
      'skintone': instance.skintone,
      'blood_group': instance.bloodGroup,
      'fitness': instance.fitness,
      'body_type': instance.bodyType,
      'is_handicap': instance.isHandicap,
      'handicap_detail': instance.handicapDetail,
      'diet_type': instance.dietType,
      'drink_type': instance.drinkType,
      'smoke_type': instance.smokeType,
    };

EducationInfo _$EducationInfoFromJson(Map<String, dynamic> json) =>
    EducationInfo(
      isFromAdminService: json['is_from_admin_service'] as String?,
      adminPositionName: json['admin_position_name'] as String?,
      isFromIITIIMNIT: json['is_from_iit_iim_nit'] as String?,
      instituteName: json['institute_name'] as String?,
      education: json['education'] as String?,
      educationDetail: json['education_detail'] as String?,
    );

Map<String, dynamic> _$EducationInfoToJson(EducationInfo instance) =>
    <String, dynamic>{
      'is_from_admin_service': instance.isFromAdminService,
      'admin_position_name': instance.adminPositionName,
      'is_from_iit_iim_nit': instance.isFromIITIIMNIT,
      'institute_name': instance.instituteName,
      'education': instance.education,
      'education_detail': instance.educationDetail,
    };

OccupationInfo _$OccupationInfoFromJson(Map<String, dynamic> json) =>
    OccupationInfo(
      occupation: json['occupation'] as String?,
      occupationDetail: json['occupation_detail'] as String?,
      annualIncome: json['annual_income'] as String?,
      employmentType: json['employment_type'] as String?,
      officeAddress: json['office_address'] as String?,
    );

Map<String, dynamic> _$OccupationInfoToJson(OccupationInfo instance) =>
    <String, dynamic>{
      'occupation': instance.occupation,
      'occupation_detail': instance.occupationDetail,
      'annual_income': instance.annualIncome,
      'employment_type': instance.employmentType,
      'office_address': instance.officeAddress,
    };

FamilyInfo _$FamilyInfoFromJson(Map<String, dynamic> json) => FamilyInfo(
      familyStatus: json['family_status'] as String?,
      familyType: json['family_type'] as String?,
      familyValue: json['family_value'] as String?,
      noBrother: json['no_brother'] as String?,
      noSister: json['no_sister'] as String?,
      marriedBrother: json['married_brother'] as String?,
      marriedSister: json['married_sister'] as String?,
      fatherName: json['father_name'] as String?,
      motherName: json['mother_name'] as String?,
      fatherOccupation: json['father_occupation'] as String?,
      motherOccupation: json['mother_occupation'] as String?,
      houseOwned: json['house_owned'] as String?,
      houseType: json['house_type'] as String?,
      parentsStayOptions: json['parents_stay_options'] as String?,
      detailFamily: json['detail_family'] as String?,
    );

Map<String, dynamic> _$FamilyInfoToJson(FamilyInfo instance) =>
    <String, dynamic>{
      'family_status': instance.familyStatus,
      'family_type': instance.familyType,
      'family_value': instance.familyValue,
      'no_brother': instance.noBrother,
      'no_sister': instance.noSister,
      'married_brother': instance.marriedBrother,
      'married_sister': instance.marriedSister,
      'father_name': instance.fatherName,
      'mother_name': instance.motherName,
      'father_occupation': instance.fatherOccupation,
      'mother_occupation': instance.motherOccupation,
      'house_owned': instance.houseOwned,
      'house_type': instance.houseType,
      'parents_stay_options': instance.parentsStayOptions,
      'detail_family': instance.detailFamily,
    };

AstroInfo _$AstroInfoFromJson(Map<String, dynamic> json) => AstroInfo(
      astroRashi: json['astro_rashi'] as String?,
      birthStar: json['birth_star'] as String?,
      gotra: json['gotra'] as String?,
      believeHoroscope: json['believe_horoscope'] as String?,
      birthDate: json['birth_date'] as String?,
      birthPlace: json['birth_place'] as String?,
      birthTime: json['birth_time'] as String?,
      birthCountry: json['birth_country'] as String?,
      horoscopeDoc: json['horoscope_doc'] as String?,
      birthLocation: json['birth_location'] as String?,
      timezone: json['timezone'] as String?,
      isMangalik: json['is_mangalik'] as String?,
    );

Map<String, dynamic> _$AstroInfoToJson(AstroInfo instance) => <String, dynamic>{
      'astro_rashi': instance.astroRashi,
      'birth_star': instance.birthStar,
      'gotra': instance.gotra,
      'believe_horoscope': instance.believeHoroscope,
      'birth_date': instance.birthDate,
      'birth_place': instance.birthPlace,
      'birth_time': instance.birthTime,
      'birth_country': instance.birthCountry,
      'horoscope_doc': instance.horoscopeDoc,
      'birth_location': instance.birthLocation,
      'timezone': instance.timezone,
      'is_mangalik': instance.isMangalik,
    };

PhotoInfo _$PhotoInfoFromJson(Map<String, dynamic> json) => PhotoInfo(
      id: json['Id'] as int?,
      pic1: json['pic1'] as String?,
      pic2: json['pic2'] as String?,
      pic3: json['pic3'] as String?,
      pic4: json['pic4'] as String?,
      pic5: json['pic5'] as String?,
      pic6: json['pic6'] as String?,
      pic7: json['pic7'] as String?,
      isVerifyPic1: json['isverifypic1'] as String?,
      isVerifyPic2: json['isverifypic2'] as String?,
      isVerifyPic3: json['isverifypic3'] as String?,
      isVerifyPic4: json['isverifypic4'] as String?,
      isVerifyPic5: json['isverifypic5'] as String?,
      isVerifyPic6: json['isverifypic6'] as String?,
      isVerifyPic7: json['isverifypic7'] as String?,
      isVerifyPic8: json['isverifypic8'] as String?,
      isVerifyPic9: json['isverifypic9'] as String?,
      isVerifyPic10: json['isverifypic10'] as String?,
      userId: json['userId'] as String?,
      communityId: json['communityId'] as String?,
      profileId: json['profileId'] as String?,
    );

Map<String, dynamic> _$PhotoInfoToJson(PhotoInfo instance) => <String, dynamic>{
      'Id': instance.id,
      'pic1': instance.pic1,
      'pic2': instance.pic2,
      'pic3': instance.pic3,
      'pic4': instance.pic4,
      'pic5': instance.pic5,
      'pic6': instance.pic6,
      'pic7': instance.pic7,
      'isverifypic1': instance.isVerifyPic1,
      'isverifypic2': instance.isVerifyPic2,
      'isverifypic3': instance.isVerifyPic3,
      'isverifypic4': instance.isVerifyPic4,
      'isverifypic5': instance.isVerifyPic5,
      'isverifypic6': instance.isVerifyPic6,
      'isverifypic7': instance.isVerifyPic7,
      'isverifypic8': instance.isVerifyPic8,
      'isverifypic9': instance.isVerifyPic9,
      'isverifypic10': instance.isVerifyPic10,
      'userId': instance.userId,
      'communityId': instance.communityId,
      'profileId': instance.profileId,
    };

PartnerPreferences _$PartnerPreferencesFromJson(Map<String, dynamic> json) =>
    PartnerPreferences(
      ageRange: json['age_range'] as String?,
      heightRange: json['height_range'] as String?,
      maritalStatus: json['marital_status'] as String?,
      caste: json['caste'] as String?,
      subcaste: json['subcaste'] as String?,
      skintone: json['skintone'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      educationList: json['education_list'] as String?,
      occupation: json['occupation'] as String?,
      familyValue: json['family_value'] as String?,
      dietType: json['diet_type'] as String?,
      bodyType: json['body_type'] as String?,
      drinkType: json['drink_type'] as String?,
      smokeType: json['smoke_type'] as String?,
      annualIncome: json['annual_income'] as String?,
      partnerDetails: json['partner_details'] as String?,
    );

Map<String, dynamic> _$PartnerPreferencesToJson(PartnerPreferences instance) =>
    <String, dynamic>{
      'age_range': instance.ageRange,
      'height_range': instance.heightRange,
      'marital_status': instance.maritalStatus,
      'caste': instance.caste,
      'subcaste': instance.subcaste,
      'skintone': instance.skintone,
      'state': instance.state,
      'city': instance.city,
      'education_list': instance.educationList,
      'occupation': instance.occupation,
      'family_value': instance.familyValue,
      'diet_type': instance.dietType,
      'body_type': instance.bodyType,
      'drink_type': instance.drinkType,
      'smoke_type': instance.smokeType,
      'annual_income': instance.annualIncome,
      'partner_details': instance.partnerDetails,
    };

VerificationInfo _$VerificationInfoFromJson(Map<String, dynamic> json) =>
    VerificationInfo(
      id: json['Id'] as String?,
      idProofs: json['id_proofs'] as String?,
      educationProof: json['education_proof'] as String?,
      incomeProof: json['income_proof'] as String?,
      isIdVerify: json['is_id_verify'] as String?,
      isEducationVerify: json['is_education_verify'] as String?,
      isIncomeVerify: json['is_income_verify'] as String?,
      userId: json['userId'] as String?,
      communityId: json['communityId'] as String?,
      profileId: json['profileId'] as String?,
      userVerify: json['user_verify'] as String?,
      emailVerify: json['email_verify'] as String?,
      mobileVerify: json['mobile_verify'] as String?,
    );

Map<String, dynamic> _$VerificationInfoToJson(VerificationInfo instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'id_proofs': instance.idProofs,
      'education_proof': instance.educationProof,
      'income_proof': instance.incomeProof,
      'is_id_verify': instance.isIdVerify,
      'is_education_verify': instance.isEducationVerify,
      'is_income_verify': instance.isIncomeVerify,
      'userId': instance.userId,
      'communityId': instance.communityId,
      'profileId': instance.profileId,
      'user_verify': instance.userVerify,
      'email_verify': instance.emailVerify,
      'mobile_verify': instance.mobileVerify,
    };

PreferencesInfo _$PreferencesInfoFromJson(Map<String, dynamic> json) =>
    PreferencesInfo(
      shortlist: json['shortlist'] as String?,
    );

Map<String, dynamic> _$PreferencesInfoToJson(PreferencesInfo instance) =>
    <String, dynamic>{
      'shortlist': instance.shortlist,
    };

LikesInfo _$LikesInfoFromJson(Map<String, dynamic> json) => LikesInfo(
      likes: json['likes'] as String?,
    );

Map<String, dynamic> _$LikesInfoToJson(LikesInfo instance) => <String, dynamic>{
      'likes': instance.likes,
    };

BlockedUsersInfo _$BlockedUsersInfoFromJson(Map<String, dynamic> json) =>
    BlockedUsersInfo(
      blockedUsers: json['blocked_users'] as String?,
    );

Map<String, dynamic> _$BlockedUsersInfoToJson(BlockedUsersInfo instance) =>
    <String, dynamic>{
      'blocked_users': instance.blockedUsers,
    };

PrivacySettings _$PrivacySettingsFromJson(Map<String, dynamic> json) =>
    PrivacySettings(
      id: json['Id'] as int?,
      phonePrivacy: json['phone_privacy'] as String?,
      photoPrivacy: json['photo_privacy'] as String?,
      horoscopePrivacy: json['horoscope_privacy'] as String?,
      userId: json['userId'] as String?,
      communityId: json['communityId'] as String?,
      profileId: json['profileId'] as String?,
      user_verify: json['user_verify'] as String?,
      mobile_verify: json['mobile_verify'] as String?,
      email_verify: json['email_verify'] as String?,
    );

Map<String, dynamic> _$PrivacySettingsToJson(PrivacySettings instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'phone_privacy': instance.phonePrivacy,
      'photo_privacy': instance.photoPrivacy,
      'horoscope_privacy': instance.horoscopePrivacy,
      'userId': instance.userId,
      'communityId': instance.communityId,
      'profileId': instance.profileId,
      'user_verify': instance.user_verify,
      'email_verify': instance.email_verify,
      'mobile_verify': instance.mobile_verify,
    };
