
import 'package:json_annotation/json_annotation.dart';

part 'fetch_matches.g.dart';


@JsonSerializable()
class User {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'whatsapp')
  String whatsapp;

  @JsonKey(name: 'mob_reg_token')
  String mobRegToken;

  @JsonKey(name: 'web_reg_token')
  String webRegToken;

  @JsonKey(name: 'fullname')
  String fullname;

  @JsonKey(name: 'handicap_detail')
  String handicap_detail;

  @JsonKey(name: 'profile_id')
  String profileId;

  @JsonKey(name: 'dob')
  String dob;

  @JsonKey(name: 'userId')
  String userId;

  @JsonKey(name: 'iit_nit')
  String iitNit;

  @JsonKey(name: 'is_admin_service')
  String isAdminService;

  @JsonKey(name: 'education')
  String education;

  @JsonKey(name: 'occupation')
  String occupation;

  @JsonKey(name: 'height')
  String height;

  @JsonKey(name: 'likes')
  String likes;

  @JsonKey(name: 'shortlist')
  String shortlist;

  @JsonKey(name: 'blocked_users')
  String blockedUsers;

  @JsonKey(name: 'pic')
  String pic;

  @JsonKey(name: 'verifypic1')
  String verifypic1;

  @JsonKey(name: 'oldpic1')
  String oldpic1;

  bool isshortlist = false;
  bool isinterstSent = false;

  User({
    required this.name,
    required this.mobRegToken,
    required this.webRegToken,
    required this.whatsapp,
    required this.fullname,
    required this.profileId,
    required this.dob,
    required this.userId,
    required this.iitNit,
    required this.isAdminService,
    required this.education,
    required this.occupation,
    required this.height,
    required this.likes,
    required this.shortlist,
    required this.blockedUsers,
    required this.isshortlist,
    required this.isinterstSent,
    required this.pic,
    required this.verifypic1,
    required this.oldpic1,
    required this.handicap_detail
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class TotalRowCount {
  @JsonKey(name: 'total_row_counts')
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
  List<User> listiusers =[];

  List<User> getUsers() {

    return data[0].expand((userMap) {

      print(userMap);

      return userMap.entries.map((entry) {

        print(entry.value);


        return User.fromJson(entry.value);
      });
    }).toList();
    
  }

  List<TotalRowCount> getTotalRowCount() {
    return data[1].map((userMap) {
      return TotalRowCount.fromJson(userMap['0']);
    }).toList();
  }

}
