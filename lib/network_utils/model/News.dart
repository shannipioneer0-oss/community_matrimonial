class News1 {
  int? success;
  List<Data>? data;

  News1({this.success, this.data});

  News1.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? shortDetails;
  String? fullDetails;
  String? communityId;

  Data(
      {this.id,
        this.title,
        this.shortDetails,
        this.fullDetails,
        this.communityId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['title'];
    shortDetails = json['short_details'];
    fullDetails = json['full_details'];
    communityId = json['communityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['title'] = this.title;
    data['short_details'] = this.shortDetails;
    data['full_details'] = this.fullDetails;
    data['communityId'] = this.communityId;
    return data;
  }
}