class refund_policy {
  int? success;
  List<Data>? data;

  refund_policy({this.success, this.data});

  refund_policy.fromJson(Map<String, dynamic> json) {
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
  String? refundPolicy;

  Data({this.refundPolicy});

  Data.fromJson(Map<String, dynamic> json) {
    refundPolicy = json['refund_policy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refund_policy'] = this.refundPolicy;
    return data;
  }
}