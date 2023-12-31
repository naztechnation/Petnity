import '../profile/profile.dart';

class PetProfile {
  bool? status;
  String? message;
  List<Pets>? pets;

  PetProfile({this.status, this.message, this.pets});

  PetProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['pets'] != null) {
      pets = <Pets>[];
      json['pets'].forEach((v) {
        pets!.add(new Pets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.pets != null) {
      data['pets'] = this.pets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pets {
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

  Pets(
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

  Pets.fromJson(Map<String, dynamic> json) {
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
