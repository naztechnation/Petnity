class PetTypesModel {
  bool? status;
  String? message;
  List<PetTypes>? petTypes;

  PetTypesModel({this.status, this.message, this.petTypes});

  PetTypesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['pet_types'] != null) {
      petTypes = <PetTypes>[];
      json['pet_types'].forEach((v) {
        petTypes!.add(new PetTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.petTypes != null) {
      data['pet_types'] = this.petTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PetTypes {
  int? id;
  String? name;

  PetTypes({this.id, this.name});

  PetTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
