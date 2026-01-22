class terms_conditions {
  int? success;
  List<Data>? data;

  terms_conditions({this.success, this.data});

  terms_conditions.fromJson(Map<String, dynamic> json) {
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
  String? termsConditions;

  Data({this.termsConditions});

  Data.fromJson(Map<String, dynamic> json) {
    termsConditions = json['terms_conditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['terms_conditions'] = this.termsConditions;
    return data;
  }
}