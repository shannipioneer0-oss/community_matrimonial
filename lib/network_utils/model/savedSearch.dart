class savedSearch {
  int? success;
  List<Data>? data;

  savedSearch({this.success, this.data});

  savedSearch.fromJson(Map<String, dynamic> json) {
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
  String? searchName;
  String? searchType;
  String? searchParams;
  String? userId;
  String? communityId;

  Data(
      {this.id,
        this.searchName,
        this.searchType,
        this.searchParams,
        this.userId,
        this.communityId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    searchName = json['search_name'];
    searchType = json['search_type'];
    searchParams = json['search_params'];
    userId = json['userId'];
    communityId = json['communityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['search_name'] = this.searchName;
    data['search_type'] = this.searchType;
    data['search_params'] = this.searchParams;
    data['userId'] = this.userId;
    data['communityId'] = this.communityId;
    return data;
  }
}