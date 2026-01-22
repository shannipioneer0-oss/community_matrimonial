
class ChiefMembers1 {
  int? success;
  List<Data>? data;

  ChiefMembers1({this.success, this.data});

  ChiefMembers1.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? position;
  String? image;
  String? description;
  String? communityId;

  Data(
      {this.id,
        this.name,
        this.position,
        this.image,
        this.description,
        this.communityId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['name'];
    position = json['position'];
    image = json['image'];
    description = json['description'];
    communityId = json['communityId'];
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    data['image'] = this.image;
    data['description'] = this.description;
    data['communityId'] = this.communityId;

    return data;
  }

}