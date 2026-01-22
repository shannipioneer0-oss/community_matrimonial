class ChatUserList {
  int? success;
  List<Data>? data;

  ChatUserList({this.success, this.data});

  ChatUserList.fromJson(Map<String, dynamic> json) {
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
  String? surname;
  String? pic1;
  String? content;
  String? date;
  String? time;

  Data({this.id, this.name, this.surname, this.pic1, this.content  , this.date , this.time});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['name'];
    surname = json['surname'];
    pic1 = json['pic1'];
    content = json['content'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['pic1'] = this.pic1;
    data['content'] = this.content;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}