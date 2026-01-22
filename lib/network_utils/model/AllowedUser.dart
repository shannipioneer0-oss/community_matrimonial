


class AllowedUser {
  int? success;
  List<Data>? data;

  AllowedUser({ this.success,  this.data});

  factory AllowedUser.fromJson(Map<String, dynamic> json) {
    return AllowedUser(
      success: json['success'] ?? 0,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Data.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}

class Data {
  String? fromId;
  String? isGrant;

  Data({this.fromId, this.isGrant});

  Data.fromJson(Map<String, dynamic> json) {
    fromId = json['from_id'];
    isGrant = json['is_grant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_id'] = this.fromId;
    data['is_grant'] = this.isGrant;
    return data;
  }
}