class VetMediumTypes {
  bool? status;
  String? message;
  VetMediumTypesData? data;

  VetMediumTypes({this.status, this.message, this.data});

  VetMediumTypes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new VetMediumTypesData.fromJson(json['data']) : null;
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

class VetMediumTypesData {
  List<VetContactMediums>? vetContactMediums;

  VetMediumTypesData({this.vetContactMediums});

  VetMediumTypesData.fromJson(Map<String, dynamic> json) {
    if (json['vetContactMediums'] != null) {
      vetContactMediums = <VetContactMediums>[];
      json['vetContactMediums'].forEach((v) {
        vetContactMediums!.add(new VetContactMediums.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vetContactMediums != null) {
      data['vetContactMediums'] =
          this.vetContactMediums!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VetContactMediums {
  String? sId;
  String? name;

  VetContactMediums({this.sId, this.name});

  VetContactMediums.fromJson(Map<String, dynamic> json) {
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
