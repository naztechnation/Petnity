class IdTypeList {
  bool? status;
  String? message;
  Data? data;

  IdTypeList({this.status, this.message, this.data});

  IdTypeList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<IdTypes>? idTypes;

  Data({this.idTypes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['idTypes'] != null) {
      idTypes = <IdTypes>[];
      json['idTypes'].forEach((v) {
        idTypes!.add(new IdTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.idTypes != null) {
      data['idTypes'] = this.idTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IdTypes {
  String? sId;
  String? name;

  IdTypes({this.sId, this.name});

  IdTypes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
