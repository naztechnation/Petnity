class PetProfile {
  bool? status;
  String? message;
  Pet? pet;

  PetProfile({this.status, this.message, this.pet});

  PetProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pet = json['pet'] != null ? new Pet.fromJson(json['pet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.pet != null) {
      data['pet'] = this.pet!.toJson();
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
  int? profile;
  int? type;

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
    profile = json['profile'];
    type = json['type'];
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
    data['profile'] = this.profile;
    data['type'] = this.type;
    return data;
  }
}
