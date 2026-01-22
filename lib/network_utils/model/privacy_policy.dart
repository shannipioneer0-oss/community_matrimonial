class privacy_policy {
  int? success;
  List<Data>? data;

  privacy_policy({this.success, this.data});

  privacy_policy.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? privacyPolicy;

  Data({this.privacyPolicy});

  Data.fromJson(Map<String, dynamic> json) {
    privacyPolicy = json['privacy_policy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['privacy_policy'] = this.privacyPolicy;
    return data;
  }
}