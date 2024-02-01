import '../pet_types.dart/pet_types.dart';

class PetTypesModel {
  bool? status;
  String? message;
  PetTypesModelData? data;

  PetTypesModel({this.status, this.message, this.data});

  PetTypesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new PetTypesModelData.fromJson(json['data']) : null;
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

class PetTypesModelData {
  List<PetTypes>? petTypes;

  PetTypesModelData({this.petTypes});

  PetTypesModelData.fromJson(Map<String, dynamic> json) {
    if (json['petTypes'] != null) {
      petTypes = <PetTypes>[];
      json['petTypes'].forEach((v) {
        petTypes!.add(new PetTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.petTypes != null) {
      data['petTypes'] = this.petTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

