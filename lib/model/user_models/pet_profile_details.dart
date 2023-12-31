

import '../profile/profile.dart';

class PetProfileDetails {
  bool? status;
  String? message;
  Pet? pet;
  PetHealthIssue? petHealthIssue;
  PetHealthIssue? petAllergy;

  PetProfileDetails(
      {this.status,
      this.message,
      this.pet,
      this.petHealthIssue,
      this.petAllergy});

  PetProfileDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pet = json['pet'] != null ? new Pet.fromJson(json['pet']) : null;
    petHealthIssue = json['pet_health_issue'] != null
        ? new PetHealthIssue.fromJson(json['pet_health_issue'])
        : null;
    petAllergy = json['pet_allergy'] != null
        ? new PetHealthIssue.fromJson(json['pet_allergy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.pet != null) {
      data['pet'] = this.pet!.toJson();
    }
    if (this.petHealthIssue != null) {
      data['pet_health_issue'] = this.petHealthIssue!.toJson();
    }
    if (this.petAllergy != null) {
      data['pet_allergy'] = this.petAllergy!.toJson();
    }
    return data;
  }
}

class Pet {
  int? id;
  String? name;
  String? gender;
  String? breed;
  String? size;
  String? about;
  String? picture;
  bool? hasHealthIssues;
  bool? isAllergic;
  bool? isHidden;
  Profile? profile;
  Type? type;

  Pet(
      {this.id,
      this.name,
      this.gender,
      this.breed,
      this.size,
      this.about,
      this.picture,
      this.hasHealthIssues,
      this.isAllergic,
      this.isHidden,
      this.profile,
      this.type});

  Pet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    breed = json['breed'];
    size = json['size'];
    about = json['about'];
    picture = json['picture'];
    hasHealthIssues = json['has_health_issues'];
    isAllergic = json['is_allergic'];
    isHidden = json['is_hidden'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['breed'] = this.breed;
    data['size'] = this.size;
    data['about'] = this.about;
    data['picture'] = this.picture;
    data['has_health_issues'] = this.hasHealthIssues;
    data['is_allergic'] = this.isAllergic;
    data['is_hidden'] = this.isHidden;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}


class Type {
  int? id;
  String? name;

  Type({this.id, this.name});

  Type.fromJson(Map<String, dynamic> json) {
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

class PetHealthIssue {
  int? id;
  String? name;
  String? drug;
  String? prescription;
  Pet? pet;

  PetHealthIssue({this.id, this.name, this.drug, this.prescription, this.pet});

  PetHealthIssue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    drug = json['drug'];
    prescription = json['prescription'];
    pet = json['pet'] != null ? new Pet.fromJson(json['pet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['drug'] = this.drug;
    data['prescription'] = this.prescription;
    if (this.pet != null) {
      data['pet'] = this.pet!.toJson();
    }
    return data;
  }
}
