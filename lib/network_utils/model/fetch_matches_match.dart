


import 'package:community_matrimonial/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fetch_matches_match.g.dart';


@JsonSerializable()
class UserMatch {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'mob_reg_token')
  String mobRegToken;

  @JsonKey(name: 'web_reg_token')
  String webRegToken;

  @JsonKey(name: 'whatsapp')
  String whatsapp;

  @JsonKey(name: 'fullname')
  String fullname;

  @JsonKey(name: 'profile_id')
  String profileId;

  @JsonKey(name: 'dob')
  String dob;

  @JsonKey(name: 'userId')
  String userId;

  @JsonKey(name: 'iit_nit')
  String? iitNit;

  @JsonKey(name: 'is_admin_service')
  String? isAdminService;

  @JsonKey(name: 'education')
  String? education;

  @JsonKey(name: 'occupation')
  String? occupation;

  @JsonKey(name: 'height')
  String? height;

  @JsonKey(name: 'likes')
  String likes;

  @JsonKey(name: 'shortlist')
  String shortlist;

  @JsonKey(name: 'blocked_users')
  String blockedUsers;

  @JsonKey(name: 'accept')
  String? accept;

  @JsonKey(name: 'reject')
  String? reject;

  @JsonKey(name: 'comments')
  String? comments;

  @JsonKey(name: 'pic')
  String? pic;

  @JsonKey(name: 'verifypic1')
  String? verifypic1;

  @JsonKey(name: 'oldpic1')
  String? oldpic1;

  bool isshortlist = false;
  bool isinterstSent = false;


  UserMatch({
    required this.name,
    required this.mobRegToken,
    required this.webRegToken,
    required this.whatsapp,
    required this.fullname,
    required this.profileId,
    required this.dob,
    required this.userId,
     this.iitNit,
     this.isAdminService,
     this.education,
     this.occupation,
     this.height,
    required this.likes,
    required this.shortlist,
    required this.blockedUsers,
     this.accept,
     this.reject,
     this.comments,
    this.pic,
    this.verifypic1,
    this.oldpic1,
    required this.isshortlist,
    required this.isinterstSent
  });

  factory UserMatch.fromJson(Map<String, dynamic> json) => _$UserMatchFromJson(json);

  Map<String, dynamic> toJson() => _$UserMatchToJson(this);
}

@JsonSerializable()
class TotalRowCount {
  @JsonKey(name: 'total_row_count')
  int totalRowCount;

  TotalRowCount({
    required this.totalRowCount,
  });


  factory TotalRowCount.fromJson(Map<String, dynamic> json) =>
      _$TotalRowCountFromJson(json);

  Map<String, dynamic> toJson() => _$TotalRowCountToJson(this);
}

@JsonSerializable()
class ResponseData {
  @JsonKey(name: 'success')
  int success;

  @JsonKey(name: 'data')
  List<List<Map<String, dynamic>>> data;

  ResponseData({
    required this.success,
    required this.data,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);

  int incrementValue = 0;
  List<UserMatch> listiusers = [];

  List<UserMatch> getUsers() {

    return data[0].expand((userMap) {
      return userMap.entries.map((entry) {
        return UserMatch.fromJson(entry.value);
      });
    }).toList();


  }

  List<TotalRowCount> getTotalRowCount() {
    return data[1].map((userMap) {
      return TotalRowCount.fromJson(userMap['0']);
    }).toList();
  }

}
