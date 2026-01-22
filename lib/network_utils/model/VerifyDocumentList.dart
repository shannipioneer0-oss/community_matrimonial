


class VerifyDocumentList {
  int? success;
  Data? data;

  VerifyDocumentList({this.success, this.data});

  VerifyDocumentList.fromJson(Map<String, dynamic> json) {
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
  List<Verifydoclist> verifydoclist = [];
  List<Verifydoclist2> verifydoclist2 = [];

  Data({required this.verifydoclist, required this.verifydoclist2});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['verifydoclist'] != null) {
      verifydoclist = <Verifydoclist>[];
      json['verifydoclist'].forEach((v) {
        verifydoclist!.add(new Verifydoclist.fromJson(v));
      });
    }
    if (json['verifydoclist2'] != null) {
      verifydoclist2 = <Verifydoclist2>[];
      json['verifydoclist2'].forEach((v) {
        verifydoclist2!.add(new Verifydoclist2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.verifydoclist != null) {
      data['verifydoclist'] =
          this.verifydoclist!.map((v) => v.toJson()).toList();
    }
    if (this.verifydoclist2 != null) {
      data['verifydoclist2'] =
          this.verifydoclist2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Verifydoclist {
  int? id;
  String? idProofs;
  String? educationProof;
  String? incomeProof;
  String? isIdVerify;
  String? isEducationVerify;
  String? isIncomeVerify;
  String? idProofOld;
  String? educationProofOld;
  String? incomeProofOld;
  String? userId;
  String? communityId;
  String? profileId;
  String? name;
  String? surname;
  String? mobile;
  String? profileIdResult;
  String? gender;

  Verifydoclist(
      {this.id,
        this.idProofs,
        this.educationProof,
        this.incomeProof,
        this.isIdVerify,
        this.isEducationVerify,
        this.isIncomeVerify,
        this.idProofOld,
        this.educationProofOld,
        this.incomeProofOld,
        this.userId,
        this.communityId,
        this.profileId,
        this.name,
        this.surname,
        this.mobile,
        this.profileIdResult,
        this.gender});

  Verifydoclist.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    idProofs = json['id_proofs'];
    educationProof = json['education_proof'];
    incomeProof = json['income_proof'];
    isIdVerify = json['is_id_verify'];
    isEducationVerify = json['is_education_verify'];
    isIncomeVerify = json['is_income_verify'];
    idProofOld = json['id_proof_old'];
    educationProofOld = json['education_proof_old'];
    incomeProofOld = json['income_proof_old'];
    userId = json['userId'];
    communityId = json['communityId'];
    profileId = json['profileId'];
    name = json['name'];
    surname = json['surname'];
    mobile = json['mobile'];
    profileIdResult = json['profile_id_result'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['id_proofs'] = this.idProofs;
    data['education_proof'] = this.educationProof;
    data['income_proof'] = this.incomeProof;
    data['is_id_verify'] = this.isIdVerify;
    data['is_education_verify'] = this.isEducationVerify;
    data['is_income_verify'] = this.isIncomeVerify;
    data['id_proof_old'] = this.idProofOld;
    data['education_proof_old'] = this.educationProofOld;
    data['income_proof_old'] = this.incomeProofOld;
    data['userId'] = this.userId;
    data['communityId'] = this.communityId;
    data['profileId'] = this.profileId;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['mobile'] = this.mobile;
    data['profile_id_result'] = this.profileIdResult;
    data['gender'] = this.gender;
    return data;
  }
}

class Verifydoclist2 {
  int? total;

  Verifydoclist2({this.total});

  Verifydoclist2.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    return data;
  }
}