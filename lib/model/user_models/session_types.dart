class VetsSessionTypes {
  bool? status;
  String? message;
  SessionTypesData? data;

  VetsSessionTypes({this.status, this.message, this.data});

  VetsSessionTypes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new SessionTypesData.fromJson(json['data']) : null;
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

class SessionTypesData {
  List<VetSessionTypes>? vetSessionTypes;

  SessionTypesData({this.vetSessionTypes});

  SessionTypesData.fromJson(Map<String, dynamic> json) {
    if (json['vetSessionTypes'] != null) {
      vetSessionTypes = <VetSessionTypes>[];
      json['vetSessionTypes'].forEach((v) {
        vetSessionTypes!.add(new VetSessionTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vetSessionTypes != null) {
      data['vetSessionTypes'] =
          this.vetSessionTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VetSessionTypes {
  String? sId;
  String? name;

  VetSessionTypes({this.sId, this.name});

  VetSessionTypes.fromJson(Map<String, dynamic> json) {
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
