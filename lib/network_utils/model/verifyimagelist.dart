class VerifyImageList {
  int? success;
  Data? data;

  VerifyImageList({this.success, this.data});

  VerifyImageList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Verifyimagelist> verifyimagelist = [];
  List<Verifyimagelist2> verifyimagelist2 = [];

  Data({required this.verifyimagelist, required this.verifyimagelist2});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['verifyimagelist'] != null) {
      verifyimagelist = <Verifyimagelist>[];
      json['verifyimagelist'].forEach((v) {
        verifyimagelist!.add(new Verifyimagelist.fromJson(v));
      });
    }
    if (json['verifyimagelist2'] != null) {
      verifyimagelist2 = <Verifyimagelist2>[];
      json['verifyimagelist2'].forEach((v) {
        verifyimagelist2!.add(new Verifyimagelist2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.verifyimagelist != null) {
      data['verifyimagelist'] =
          this.verifyimagelist!.map((v) => v.toJson()).toList();
    }
    if (this.verifyimagelist2 != null) {
      data['verifyimagelist2'] =
          this.verifyimagelist2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Verifyimagelist {
  int? id;
  String? pic1;
  String? pic2;
  String? pic3;
  String? pic4;
  String? pic5;
  String? pic6;
  String? pic7;
  String? pic8;
  Null? pic9;
  Null? pic10;
  String? isverifypic1;
  String? isverifypic2;
  String? isverifypic3;
  String? isverifypic4;
  String? isverifypic5;
  String? isverifypic6;
  String? isverifypic7;
  String? isverifypic8;
  String? isverifypic9;
  String? isverifypic10;
  String? oldpic1;
  String? oldpic2;
  String? oldpic3;
  String? oldpic4;
  String? oldpic5;
  String? oldpic6;
  String? oldpic7;
  String? oldpic8;
  String? userId;
  String? communityId;
  String? profileId;
  String? name;
  String? surname;
  String? gender;
  String? mobile;
  String? profileIdResult;

  Verifyimagelist(
      {this.id,
        this.pic1,
        this.pic2,
        this.pic3,
        this.pic4,
        this.pic5,
        this.pic6,
        this.pic7,
        this.pic8,
        this.pic9,
        this.pic10,
        this.isverifypic1,
        this.isverifypic2,
        this.isverifypic3,
        this.isverifypic4,
        this.isverifypic5,
        this.isverifypic6,
        this.isverifypic7,
        this.isverifypic8,
        this.isverifypic9,
        this.isverifypic10,
        this.oldpic1,
        this.oldpic2,
        this.oldpic3,
        this.oldpic4,
        this.oldpic5,
        this.oldpic6,
        this.oldpic7,
        this.oldpic8,
        this.userId,
        this.communityId,
        this.profileId,
        this.name,
        this.surname,
        this.gender,
        this.mobile,
        this.profileIdResult});

  Verifyimagelist.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    pic1 = json['pic1'];
    pic2 = json['pic2'];
    pic3 = json['pic3'];
    pic4 = json['pic4'];
    pic5 = json['pic5'];
    pic6 = json['pic6'];
    pic7 = json['pic7'];
    pic8 = json['pic8'];
    pic9 = json['pic9'];
    pic10 = json['pic10'];
    isverifypic1 = json['isverifypic1'];
    isverifypic2 = json['isverifypic2'];
    isverifypic3 = json['isverifypic3'];
    isverifypic4 = json['isverifypic4'];
    isverifypic5 = json['isverifypic5'];
    isverifypic6 = json['isverifypic6'];
    isverifypic7 = json['isverifypic7'];
    isverifypic8 = json['isverifypic8'];
    isverifypic9 = json['isverifypic9'];
    isverifypic10 = json['isverifypic10'];
    oldpic1 = json['oldpic1'];
    oldpic2 = json['oldpic2'];
    oldpic3 = json['oldpic3'];
    oldpic4 = json['oldpic4'];
    oldpic5 = json['oldpic5'];
    oldpic6 = json['oldpic6'];
    oldpic7 = json['oldpic7'];
    oldpic8 = json['oldpic8'];
    userId = json['userId'];
    communityId = json['communityId'];
    profileId = json['profileId'];
    name = json['name'];
    surname = json['surname'];
    gender = json['gender'];
    mobile = json['mobile'];
    profileIdResult = json['profile_id_result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['pic1'] = this.pic1;
    data['pic2'] = this.pic2;
    data['pic3'] = this.pic3;
    data['pic4'] = this.pic4;
    data['pic5'] = this.pic5;
    data['pic6'] = this.pic6;
    data['pic7'] = this.pic7;
    data['pic8'] = this.pic8;
    data['pic9'] = this.pic9;
    data['pic10'] = this.pic10;
    data['isverifypic1'] = this.isverifypic1;
    data['isverifypic2'] = this.isverifypic2;
    data['isverifypic3'] = this.isverifypic3;
    data['isverifypic4'] = this.isverifypic4;
    data['isverifypic5'] = this.isverifypic5;
    data['isverifypic6'] = this.isverifypic6;
    data['isverifypic7'] = this.isverifypic7;
    data['isverifypic8'] = this.isverifypic8;
    data['isverifypic9'] = this.isverifypic9;
    data['isverifypic10'] = this.isverifypic10;
    data['oldpic1'] = this.oldpic1;
    data['oldpic2'] = this.oldpic2;
    data['oldpic3'] = this.oldpic3;
    data['oldpic4'] = this.oldpic4;
    data['oldpic5'] = this.oldpic5;
    data['oldpic6'] = this.oldpic6;
    data['oldpic7'] = this.oldpic7;
    data['oldpic8'] = this.oldpic8;
    data['userId'] = this.userId;
    data['communityId'] = this.communityId;
    data['profileId'] = this.profileId;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['gender'] = this.gender;
    data['mobile'] = this.mobile;
    data['profile_id_result'] = this.profileIdResult;
    return data;
  }
}

class Verifyimagelist2 {
  int? total;

  Verifyimagelist2({this.total});

  Verifyimagelist2.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    return data;
  }
}