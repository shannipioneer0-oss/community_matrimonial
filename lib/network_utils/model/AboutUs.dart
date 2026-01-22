
class AboutUs1 {
  int? success;
  List<Data>? data;

  AboutUs1({this.success, this.data});

  AboutUs1.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? description;
  String? communityId;

  Data({this.id, this.description, this.communityId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    description = json['description'];
    communityId = json['communityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['description'] = this.description;
    data['communityId'] = this.communityId;
    return data;
  }
}