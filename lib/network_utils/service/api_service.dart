import 'package:chopper/chopper.dart';
import 'package:community_matrimonial/utils/Strings.dart';
import 'package:http/http.dart' show MultipartFile;

// this is necessary for the generated code to find your class
part 'api_service.chopper.dart';


@ChopperApi()
abstract class ApiService extends ChopperService {
  // helper methods that help you instantiate your service
  static ApiService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(Strings.BASE_URL),
      services: [_$ApiService()],
      converter: JsonConverter(),
    );
    return _$ApiService(client);
  }

  @Post(path: 'fetch_data/send_otp_sms')
  Future<Response> postSendOtpSms(@Body() Map<String , dynamic> requestBody);

  @Post(path: 'fetch_data/about_community')
  Future<Response> postAboutCommunity(@Body() Map<String , dynamic> requestBody);

  @Post(path: 'fetch_data/verify_otp')
  Future<Response> verifyOtp(@Body() Map<String , dynamic> requestBody);

  @Post(path: 'fetch_data/pictures_fetch')
  Future<Response> fetch_pictures(@Body() Map<String , dynamic> requestBody);

  @Post(path: 'fetch_data/profile_fetch')
  Future<Response> profile_fetch(@Body() Map<String , dynamic> requestBody);

  @Post(path: 'fetch_data/deregister')
  Future<Response> deregister(@Body() Map<String , dynamic> requestBody);

  @Post(path: 'profile/basic_detail')
  Future<Response> postBasicDetail(@Body() Map<String, dynamic> requestBody);

  @Patch(path: 'profile/basic_detail')
  Future<Response> postBasicDetailUpdate(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/contact_detail')
  Future<Response> postContactDetail(@Body() Map<String, dynamic> requestBody);

  @Patch(path: 'profile/contact_detail')
  Future<Response> postContactDetailUpdate(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/insert_education')
  Future<Response> postInserteducation(@Body() Map<String, dynamic> requestBody);

  @Patch(path: 'profile/update_education')
  Future<Response> postEducationUpdate(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/insert_family')
  Future<Response> postFamilyInsert(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/insert_settings')
  Future<Response> postInsertSettings(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/insert_state_other')
  Future<Response> postInsertStateOther(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/insert_city_state')
  Future<Response> postInsertCityOther(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/insert_education_other')
  Future<Response> postInsertEducationOther(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/insert_occupation_other')
  Future<Response> postInsertOccupationOther(@Body() Map<String, dynamic> requestBody);

  @Patch(path: 'profile/update_family')
  Future<Response> postFamilyUpdate(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'signup/')
  Future<Response> postRegisteration(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/insert_horoscope', headers: {'Content-Type': 'multipart/form-data'},)
  @multipart
  Future<Response> postInsertHoroscope(
      @Part('sampleFile') List<int> fileBytes,
      @Part('rashi') String rashi,
      @Part('birth_star') String birth_star,
      @Part('gotra') String gotra,
      @Part('believe_horoscope') String description,
      @Part('birth_date') String birth_date,
      @Part('birth_place') String birth_place,
      @Part('birth_time') String birth_time,
      @Part('birth_country') String birth_country,
      @Part('horoscope_doc') String horoscope_doc,
      @Part('ismangalik') String ismangalik,
      @Part('profileId') String profileId,
      @Part('userId') String userId,
      @Part('communityId') String communityId,
      @Part('timezone') String timezone,
      @Part('birth_location') String birth_location,
      );

  @Patch(path: 'profile/update_horoscope' , headers: {'Content-Type': 'multipart/form-data'},)
  @multipart
  Future<Response> postHoroscopeUpdate(@Part('sampleFile') List<int> fileBytes,
      @Part('rashi') String rashi,
      @Part('birth_star') String birth_star,
      @Part('gotra') String gotra,
      @Part('believe_horoscope') String description,
      @Part('birth_date') String birth_date,
      @Part('birth_place') String birth_place,
      @Part('birth_time') String birth_time,
      @Part('birth_country') String birth_country,
      @Part('horoscope_doc') String horoscope_doc,
      @Part('ismangalik') String ismangalik,
      @Part('birth_location') String birth_location,
      @Part('timezone') String timezone,
      @Part('Id') String Id);


  @Post(path: 'profile/insert_occupation')
  Future<Response> postOccupationInsert(@Body() Map<String, dynamic> requestBody);

  @Patch(path: 'profile/update_occupation')
  Future<Response> postOccupationUpdate(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/insert_physical_lifestyle')
  Future<Response> postLifeStyleInsert(@Body() Map<String, dynamic> requestBody);

  @Patch(path: 'profile/update_physical_lifestyle')
  Future<Response> postLifestyleUpdate(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/insert_partner')
  Future<Response> postPartnerPrefernceInsert(@Body() Map<String, dynamic> requestBody);

  @Patch(path: 'profile/update_partner')
  Future<Response> postPartnerPrefernceUpdate(@Body() Map<String, dynamic> requestBody);


  @Post(path: 'profile/insert_photos', headers: {
    'Content-Type': 'multipart/form-data', // <-- important
  },)
  @multipart
  Future<Response> InsertPhotos(
      @Part('pic1') String pic1,
      @Part('pic2') String pic2,
      @Part('pic3') String pic3,
      @Part('pic4') String pic4,
      @Part('pic5') String pic5,
      @Part('pic6') String pic6,
      @Part('pic7') String pic7,
      @Part('pic8') String pic8,
      @Part('pic9') String pic9,
      @Part('pic10') String pic10,
      @Part('profileId') String profileId,
      @Part('userId') String userId,
      @Part('communityId') String communityId,
      @PartFile('sampleFile') List<List<int>> fileBytesList
      );

  @Post(path: 'profile/update_photos', headers: {'Content-Type': 'multipart/form-data'},)
  @multipart
  Future<Response> UpdatePhotos(
      @Part('pic1') String pic1,
      @Part('pic2') String pic2,
      @Part('pic3') String pic3,
      @Part('pic4') String pic4,
      @Part('pic5') String pic5,
      @Part('pic6') String pic6,
      @Part('pic7') String pic7,
      @Part('pic8') String pic8,
      @Part('pic9') String pic9,
      @Part('pic10') String pic10,
      @Part('Id') String profileId,
      @PartFile('sampleFile') List<List<int>> images,
      );


  @Post(path: 'profile/insert_proofs', headers: {'Content-Type': 'multipart/form-data'},)
  @multipart
  Future<Response> InsertProofs(
      @Part('id_proof') String id_proof,
      @Part('education_proof') String education_proof,
      @Part('income_proof') String income_proof,
      @Part('is_id_verify') String is_id_verify,
      @Part('is_education_verify') String is_education_verify,
      @Part('is_income_verify') String pic6,
      @Part('profileId') String profileId,
      @Part('userId') String userId,
      @Part('communityId') String communityId,
      @PartFile('sampleFile') List<List<int>> images,
      );


  @Post(path: 'profile/update_proofs', headers: {'Content-Type': 'multipart/form-data'},)
  @multipart
  Future<Response> UpdateProofs(
      @Part('id_proof') String id_proof,
      @Part('education_proof') String education_proof,
      @Part('income_proof') String income_proof,
      @Part('Id') String communityId,
      @Part('sampleFile[]') List<List<int>> fileBytes,
      );

  @Post(path: 'activity/express_interest_insert')
  Future<Response> postExpressInterestInsert(@Body() Map<String, dynamic> requestBody);

  @Patch(path: 'activity/interest_recieved_update')
  Future<Response> postInterestRecievedUpdate(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'activity/interest_accept_reject')
  Future<Response> postInterestAcceptReject(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'activity/shortlist')
  Future<Response> postshortlistInsert(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'activity/view_other_profile')
  Future<Response> postViewotherProfile(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'activity/view_other_contact')
  Future<Response> postViewotherContact(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'activity/insert_video_data')
  Future<Response> postInsertVideoData(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'about_community/paid_list_member_insert')
  Future<Response> postPaidListMemberInsert(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'matches/')
  Future<Response> postMatches(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'matches/match_just_joined')
  Future<Response> postMatchJustJoined(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'matches/match_nearby')
  Future<Response> postMatchNearby(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'matches/shortlisted')
  Future<Response> postShortlist(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'matches/match_astro')
  Future<Response> postMatchAstro(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'matches/match_premium')
  Future<Response> postMatchPremium(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'matches/view_profile')
  Future<Response> postViewProfile(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'matches/view_contact')
  Future<Response> postViewContact(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'matches/interest_sent_recieved')
  Future<Response> postInterestSentRecieved(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/city_fetch')
  Future<Response> postCityFetch(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/city_fetch_multiple')
  Future<Response> postCityFetchMultiple(@Body() Map<String, dynamic> requestBody);


  @Post(path: 'fetch_data/edu_degree_fetch')
  Future<Response> postEduDegree(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/institue_iit_fetch')
  Future<Response> postInstituteReputed(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/master_table_fetch')
  Future<Response> postMasterTable(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/membership_fetch')
  Future<Response> postMembershipFetch(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/occupation_list_fetch')
  Future<Response> postOccupationList(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/login')
  Future<Response> postLoginUser(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/state')
  Future<Response> postStateList(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/country_fetch')
  Future<Response> postCountryList(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/subcaste')
  Future<Response> postSubcasteList(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/profiledetail_fetch')
  Future<Response> postProfileDetails(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/profiledetail_fetch_value_label')
  Future<Response> postProfileDetailsFetchValuelabel(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/regular_search')
  Future<Response> postRegularSearch(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/advanced_Search')
  Future<Response> postAdvancedSearch(@Body() Map<String, dynamic> requestBody , {
    @Header('Content-Type') String contentType = 'application/json'
  });

  @Post(path: 'fetch_data/city_fetch_multiple')
  Future<Response> postCityFecthMultiple(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/insert_notification')
  Future<Response> postInsertNotification(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/fetch_notification')
  Future<Response> postFetchNotification(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/fetch_notification_interest')
  Future<Response> postFetchNotificationInterest(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/insert_notification_count')
  Future<Response> postInsertNotificationCount(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/fetch_privacy_settings')
  Future<Response> postFetchPrivacySettings(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/insert_allowed_from_user')
  Future<Response> postInsertAlloedFromUser(@Body() Map<String, dynamic> requestBody);

  @Patch(path: 'profile/update_allowed_from_user')
  Future<Response> postUpdateAllowedFromUser(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/premium_user_data')
  Future<Response> postPremiumUserData(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'activity/view_other_horoscope')
  Future<Response> postViewOtherHoroscope(@Body() Map<String, dynamic> requestBody);

  @Patch(path: 'profile/update_payment_isexpired')
  Future<Response> postUpdatePaymentExpired(@Body() Map<String, dynamic> requestBody);

  @Patch(path: 'profile/delete_account')
  Future<Response> postDeleteAccount(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/hide_account')
  Future<Response> postHideAccount(@Body() Map<String, dynamic> requestBody);

  @Get(path: 'profile/hide_account_select')
  Future<Response> getHideAccountSelect(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'payment/createOrder')
  Future<Response> postCreateOrder(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'payment/verifyPayment')
  Future<Response> postVerifyPayment(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/match_score')
  Future<Response> postMatchScore(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/birth_chart')
  Future<Response> postBirthChart(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'about_community/paid_list_member_insert')
  Future<Response> postMembershipInsert(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/fetch_allowed_from_user')
  Future<Response> postFetchAllowedFromUser(@Body() Map<String, dynamic> requestBody);

  @Patch(path: 'profile/update_settings')
  Future<Response> postUpdateSettings(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'activity/chat')
  Future<Response> postChat(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'activity/chat_list')
  Future<Response> postChatList(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'activity/save_search_insert')
  Future<Response> postSaveSearch(@Body() Map<String, dynamic> requestBody);
  
  @Post(path: 'fetch_data/select_saved_search')
  Future<Response> postSelectSavedSearch(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/update_filter_preference')
  Future<Response> postUpdatePreferenceFilter(@Body() Map<String, dynamic> requestBody);

  @Get(path: 'signup/getotp')
  Future<Response> getOtp(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/verify_image_list')
  Future<Response> postVerifyImageList(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/update_photo_verification')
  Future<Response> postUpdatePhotoVerification(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/verify_document_list')
  Future<Response> postVerifyDocList(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/update_document_verification')
  Future<Response> postUpdateDocumentVerification(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/verify_user')
  Future<Response> postUpdateVerifyUser(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/update_email_verify')
  Future<Response> postUpdateEmailVerify(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'fetch_data/verify_otp_email')
  Future<Response> verifyOtpEmail(@Body() Map<String , dynamic> requestBody);

  @Post(path: 'profile/insert_hobby')
  Future<Response> insertHobbies(@Body() Map<String , dynamic> requestBody);

  @Post(path: 'profile/update_hobby')
  Future<Response> updateHobbies(@Body() Map<String , dynamic> requestBody);

  @Post(path: 'adminpanel/role_community/select_chiefmembers_detail')
  Future<Response> selectChiefMembers(@Body() Map<String , dynamic> requestBody);

  @Post(path: 'adminpanel/role_community/select_aboutus_detail')
  Future<Response> selectAboutUs(@Body() Map<String , dynamic> requestBody);

  @Post(path: 'adminpanel/role_community/select_contactus_detail')
  Future<Response> selectContactUs(@Body() Map<String , dynamic> requestBody);

  @Get(path: 'adminpanel/role_community/select_urls')
  Future<Response> selectTermsCondition_Refund_Privacy(@Body() Map<String , dynamic> requestBody);

  @Post(path: 'profile/insert_family_member_details')
  Future<Response> insert_family_member_details(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'profile/update_family_member_details')
  Future<Response> update_family_member_details(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'adminpanel/role_community/select_member_list_community')
  Future<Response> select_member_list_community(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'adminpanel/role_community/select_version')
  Future<Response> select_version(@Body() Map<String, dynamic> requestBody);

  @Post(path: 'adminpanel/user_content/verify_payment_admin')
  Future<Response> verify_payment_admin(@Body() Map<String, dynamic> requestBody);



}