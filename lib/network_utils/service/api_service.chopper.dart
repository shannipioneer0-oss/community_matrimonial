// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ApiService extends ApiService {
  _$ApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ApiService;

  @override
  Future<Response<dynamic>> postSendOtpSms(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/send_otp_sms');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> verifyOtp(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/verify_otp');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> fetch_pictures(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/pictures_fetch');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response<dynamic>> profile_fetch(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/profile_fetch');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postBasicDetail(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/basic_detail');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response<dynamic>> deregister(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/deregister');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> select_version(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('adminpanel/role_community/select_version');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }



  @override
  Future<Response<dynamic>> postBasicDetailUpdate(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/basic_detail');
    final $body = requestBody;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postContactDetail(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/contact_detail');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postContactDetailUpdate(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/contact_detail');
    final $body = requestBody;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postInserteducation(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/insert_education');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postEducationUpdate(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/update_education');
    final $body = requestBody;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postFamilyInsert(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/insert_family');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postFamilyUpdate(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/update_family');
    final $body = requestBody;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postInsertHoroscope(
    List<int> fileBytes,
    String rashi,
    String birth_star,
    String gotra,
    String description,
    String birth_date,
    String birth_place,
    String birth_time,
    String birth_country,
    String horoscope_doc,
    String ismangalik,
    String profileId,
    String userId,
    String communityId,
    String timezone,
    String birth_location,
  ) {
    final Uri $url = Uri.parse('profile/insert_horoscope');
    final Map<String, String> $headers = {
      'Content-Type': 'multipart/form-data',
    };
    final List<PartValue> $parts = <PartValue>[
      PartValue<List<int>>(
        'sampleFile',
        fileBytes,
      ),
      PartValue<String>(
        'rashi',
        rashi,
      ),
      PartValue<String>(
        'birth_star',
        birth_star,
      ),
      PartValue<String>(
        'gotra',
        gotra,
      ),
      PartValue<String>(
        'believe_horoscope',
        description,
      ),
      PartValue<String>(
        'birth_date',
        birth_date,
      ),
      PartValue<String>(
        'birth_place',
        birth_place,
      ),
      PartValue<String>(
        'birth_time',
        birth_time,
      ),
      PartValue<String>(
        'birth_country',
        birth_country,
      ),
      PartValue<String>(
        'horoscope_doc',
        horoscope_doc,
      ),
      PartValue<String>(
        'ismangalik',
        ismangalik,
      ),
      PartValue<String>(
        'profileId',
        profileId,
      ),
      PartValue<String>(
        'userId',
        userId,
      ),
      PartValue<String>(
        'communityId',
        communityId,
      ),
      PartValue<String>(
        'timezone',
        timezone,
      ),
      PartValue<String>(
        'birth_location',
        birth_location,
      ),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postHoroscopeUpdate(
    List<int> fileBytes,
    String rashi,
    String birth_star,
    String gotra,
    String description,
    String birth_date,
    String birth_place,
    String birth_time,
    String birth_country,
    String horoscope_doc,
    String ismangalik,
    String birth_location,
    String timezone,
    String Id,
  ) {
    final Uri $url = Uri.parse('profile/update_horoscope');
    final Map<String, String> $headers = {
      'Content-Type': 'multipart/form-data',
    };
    final List<PartValue> $parts = <PartValue>[
      PartValue<List<int>>(
        'sampleFile',
        fileBytes,
      ),
      PartValue<String>(
        'rashi',
        rashi,
      ),
      PartValue<String>(
        'birth_star',
        birth_star,
      ),
      PartValue<String>(
        'gotra',
        gotra,
      ),
      PartValue<String>(
        'believe_horoscope',
        description,
      ),
      PartValue<String>(
        'birth_date',
        birth_date,
      ),
      PartValue<String>(
        'birth_place',
        birth_place,
      ),
      PartValue<String>(
        'birth_time',
        birth_time,
      ),
      PartValue<String>(
        'birth_country',
        birth_country,
      ),
      PartValue<String>(
        'horoscope_doc',
        horoscope_doc,
      ),
      PartValue<String>(
        'ismangalik',
        ismangalik,
      ),
      PartValue<String>(
        'birth_location',
        birth_location,
      ),
      PartValue<String>(
        'timezone',
        timezone,
      ),
      PartValue<String>(
        'Id',
        Id,
      ),
    ];
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postOccupationInsert(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/insert_occupation');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postOccupationUpdate(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/update_occupation');
    final $body = requestBody;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postLifeStyleInsert(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/insert_physical_lifestyle');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postLifestyleUpdate(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/update_physical_lifestyle');
    final $body = requestBody;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postPartnerPrefernceInsert(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/insert_partner');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postPartnerPrefernceUpdate(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/update_partner');
    final $body = requestBody;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> InsertPhotos(
    String pic1,
    String pic2,
    String pic3,
    String pic4,
    String pic5,
    String pic6,
    String pic7,
    String pic8,
    String pic9,
    String pic10,
    String profileId,
    String userId,
    String communityId,
    List<List<int>> fileBytesList,
  ) {
    final Uri $url = Uri.parse('profile/insert_photos');
    final Map<String, String> $headers = {
      'Content-Type': 'multipart/form-data',
    };
    final List<PartValue> $parts = <PartValue>[
      PartValue<String>(
        'pic1',
        pic1,
      ),
      PartValue<String>(
        'pic2',
        pic2,
      ),
      PartValue<String>(
        'pic3',
        pic3,
      ),
      PartValue<String>(
        'pic4',
        pic4,
      ),
      PartValue<String>(
        'pic5',
        pic5,
      ),
      PartValue<String>(
        'pic6',
        pic6,
      ),
      PartValue<String>(
        'pic7',
        pic7,
      ),
      PartValue<String>(
        'pic8',
        pic8,
      ),
      PartValue<String>(
        'pic9',
        pic9,
      ),
      PartValue<String>(
        'pic10',
        pic10,
      ),
      PartValue<String>(
        'profileId',
        profileId,
      ),
      PartValue<String>(
        'userId',
        userId,
      ),
      PartValue<String>(
        'communityId',
        communityId,
      ),
      PartValueFile<List<List<int>>>(
        'sampleFile',
        fileBytesList,
      ),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> UpdatePhotos(
    String pic1,
    String pic2,
    String pic3,
    String pic4,
    String pic5,
    String pic6,
    String pic7,
    String pic8,
    String pic9,
    String pic10,
    String profileId,
    List<List<int>> images,
  ) {
    final Uri $url = Uri.parse('profile/update_photos');
    final Map<String, String> $headers = {
      'Content-Type': 'multipart/form-data',
    };
    final List<PartValue> $parts = <PartValue>[
      PartValue<String>(
        'pic1',
        pic1,
      ),
      PartValue<String>(
        'pic2',
        pic2,
      ),
      PartValue<String>(
        'pic3',
        pic3,
      ),
      PartValue<String>(
        'pic4',
        pic4,
      ),
      PartValue<String>(
        'pic5',
        pic5,
      ),
      PartValue<String>(
        'pic6',
        pic6,
      ),
      PartValue<String>(
        'pic7',
        pic7,
      ),
      PartValue<String>(
        'pic8',
        pic8,
      ),
      PartValue<String>(
        'pic9',
        pic9,
      ),
      PartValue<String>(
        'pic10',
        pic10,
      ),
      PartValue<String>(
        'Id',
        profileId,
      ),
      PartValueFile<List<List<int>>>(
        'sampleFile',
        images,
      ),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> InsertProofs(
    String id_proof,
    String education_proof,
    String income_proof,
    String is_id_verify,
    String is_education_verify,
    String pic6,
    String profileId,
    String userId,
    String communityId,
    List<List<int>> images,
  ) {
    final Uri $url = Uri.parse('profile/insert_proofs');
    final Map<String, String> $headers = {
      'Content-Type': 'multipart/form-data',
    };
    final List<PartValue> $parts = <PartValue>[
      PartValue<String>(
        'id_proof',
        id_proof,
      ),
      PartValue<String>(
        'education_proof',
        education_proof,
      ),
      PartValue<String>(
        'income_proof',
        income_proof,
      ),
      PartValue<String>(
        'is_id_verify',
        is_id_verify,
      ),
      PartValue<String>(
        'is_education_verify',
        is_education_verify,
      ),
      PartValue<String>(
        'is_income_verify',
        pic6,
      ),
      PartValue<String>(
        'profileId',
        profileId,
      ),
      PartValue<String>(
        'userId',
        userId,
      ),
      PartValue<String>(
        'communityId',
        communityId,
      ),
      PartValueFile<List<List<int>>>(
        'sampleFile',
        images,
      ),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> UpdateProofs(
    String id_proof,
    String education_proof,
    String income_proof,
    String communityId,
    List<List<int>> fileBytes,
  ) {
    final Uri $url = Uri.parse('profile/update_proofs');
    final Map<String, String> $headers = {
      'Content-Type': 'multipart/form-data',
    };
    final List<PartValue> $parts = <PartValue>[
      PartValue<String>(
        'id_proof',
        id_proof,
      ),
      PartValue<String>(
        'education_proof',
        education_proof,
      ),
      PartValue<String>(
        'income_proof',
        income_proof,
      ),
      PartValue<String>(
        'Id',
        communityId,
      ),
      PartValue<List<List<int>>>(
        'sampleFile[]',
        fileBytes,
      ),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postExpressInterestInsert(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('activity/express_interest_insert');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postInterestRecievedUpdate(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('activity/interest_recieved_update');
    final $body = requestBody;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postInterestAcceptReject(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('activity/interest_accept_reject');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postshortlistInsert(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('activity/shortlist');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postViewotherProfile(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('activity/view_other_profile');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postViewotherContact(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('activity/view_other_contact');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }





  @override
  Future<Response<dynamic>> postInsertVideoData(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('activity/insert_video_data');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response<dynamic>> postPaidListMemberInsert(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('about_community/paid_list_member_insert');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postMatches(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('matches/');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postMatchJustJoined(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('matches/match_just_joined');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postMatchNearby(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('matches/match_nearby');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postShortlist(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('matches/shortlisted');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postMatchAstro(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('matches/match_astro');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postMatchPremium(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('matches/match_premium');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postViewProfile(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('matches/view_profile');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postViewContact(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('matches/view_contact');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postInterestSentRecieved(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('matches/interest_sent_recieved');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postCityFetch(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/city_fetch');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postCityFetchMultiple(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/city_fetch_multiple');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postEduDegree(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/edu_degree_fetch');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postInstituteReputed(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/institue_iit_fetch');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postMasterTable(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/master_table_fetch');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postMembershipFetch(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/membership_fetch');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postOccupationList(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/occupation_list_fetch');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postLoginUser(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/login');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postStateList(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/state');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postCountryList(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/country_fetch');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postSubcasteList(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/subcaste');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postProfileDetails(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/profiledetail_fetch');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postProfileDetailsFetchValuelabel(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/profiledetail_fetch_value_label');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postRegularSearch(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/regular_search');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postAdvancedSearch(Map<String, dynamic> requestBody, { @Header('Content-Type') String contentType = 'application/json'}) async {
    final Uri $url = Uri.parse('fetch_data/advanced_Search');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postCityFecthMultiple(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/city_fetch_multiple');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postInsertNotification(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/insert_notification');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postFetchNotification(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/fetch_notification');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postFetchNotificationInterest(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/fetch_notification_interest');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postInsertNotificationCount(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/insert_notification_count');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postFetchPrivacySettings(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/fetch_privacy_settings');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postInsertAlloedFromUser(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/insert_allowed_from_user');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postUpdateAllowedFromUser(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/update_allowed_from_user');
    final $body = requestBody;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postPremiumUserData(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/premium_user_data');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postViewOtherHoroscope(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('activity/view_other_horoscope');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postUpdatePaymentExpired(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/update_payment_isexpired');
    final $body = requestBody;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postDeleteAccount(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/delete_account');
    final $body = requestBody;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postHideAccount(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/hide_account');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response<dynamic>> getHideAccountSelect(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/hide_account_select');
    final $body = requestBody;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }



  @override
  Future<Response<dynamic>> postCreateOrder(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('payment/createOrder');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postVerifyPayment(
      Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('payment/verifyPayment');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postMatchScore(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/match_score');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postBirthChart(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/birth_chart');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response<dynamic>> postMembershipInsert(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('about_community/paid_list_member_insert');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response<dynamic>> postFetchAllowedFromUser(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/fetch_allowed_from_user');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response<dynamic>> postInsertSettings(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/insert_settings');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }



  @override
  Future<Response<dynamic>> postUpdateSettings(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/update_settings');
    final $body = requestBody;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }



  @override
  Future<Response<dynamic>> postChat(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('activity/chat');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }



  @override
  Future<Response<dynamic>> postChatList(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('activity/chat_list');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response<dynamic>> postAboutCommunity(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/about_community');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }



  @override
  Future<Response<dynamic>> postSaveSearch(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('activity/save_search_insert');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response<dynamic>> postSelectSavedSearch(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/select_saved_search');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }



  @override
  Future<Response<dynamic>> postUpdatePreferenceFilter(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('profile/update_filter_preference');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> postInsertStateOther(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('profile/insert_state_other');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response> postInsertCityOther(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('profile/insert_city_state');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> postInsertEducationOther(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('profile/insert_education_other');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> postInsertOccupationOther(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('profile/insert_occupation_other');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);

  }

  @override
  Future<Response> postRegisteration(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('signup');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getOtp(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('signup/getotp');
    final $body = requestBody;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response> postVerifyImageList(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('fetch_data/verify_image_list');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response> postUpdatePhotoVerification(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('fetch_data/update_photo_verification');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response> postVerifyDocList(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('fetch_data/verify_document_list');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response> postUpdateDocumentVerification(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('fetch_data/update_document_verification');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response> postUpdateVerifyUser(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('fetch_data/verify_user');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response> postUpdateEmailVerify(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('profile/update_email_verify');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }



  @override
  Future<Response> verifyOtpEmail(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('fetch_data/verify_otp_email');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response> insertHobbies(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('profile/insert_hobby');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }



  @override
  Future<Response> updateHobbies(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('profile/update_hobby');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }



  @override
  Future<Response> selectChiefMembers(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('adminpanel/role_community/select_chiefmembers_detail');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }




  @override
  Future<Response> selectAboutUs(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('adminpanel/role_community/select_aboutus_detail');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }




  @override
  Future<Response> selectContactUs(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('adminpanel/role_community/select_contactus_detail');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response> selectTermsCondition_Refund_Privacy(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('adminpanel/role_community/select_urls');
    final $body = requestBody;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> insert_family_member_details(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('profile/insert_family_member_details');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);

  }

  @override
  Future<Response> update_family_member_details(Map<String, dynamic> requestBody) {

    final Uri $url = Uri.parse('profile/update_family_member_details');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);

  }


  @override
  Future<Response<dynamic>> select_member_list_community(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('adminpanel/role_community/select_member_list_community');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> verify_payment_admin(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('adminpanel/user_content/verify_payment_admin');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response<dynamic>> select_launch(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/select_launch');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> update_launch(Map<String, dynamic> requestBody) {
    final Uri $url = Uri.parse('fetch_data/update_launch');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> select_free_membership(Map<String, dynamic> requestBody) {


    final Uri $url = Uri.parse('fetch_data/select_free_membership');
    final $body = requestBody;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );

    return client.send<dynamic, dynamic>($request);

  }



}
