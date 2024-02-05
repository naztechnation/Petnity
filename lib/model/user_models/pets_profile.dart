class PetProfile {
  bool? status;
  String? message;
  Data? data;

  PetProfile({this.status, this.message, this.data});

  PetProfile.fromJson(Map<String, dynamic> json) {
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
  List<Pets>? pets;

  Data({this.pets});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['pets'] != null) {
      pets = <Pets>[];
      json['pets'].forEach((v) {
        pets!.add(new Pets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pets != null) {
      data['pets'] = this.pets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pets {
  List<String>? healthIssues;
  List<String>? allergies;
  bool? isHidden;
  String? sId;
  String? user;
  String? type;
  String? name;
  String? gender;
  String? breed;
  String? size;
  String? about;
  String? picture;
  String? createdAt;
  String? updatedAt;

  Pets(
      {this.healthIssues,
      this.allergies,
      this.isHidden,
      this.sId,
      this.user,
      this.type,
      this.name,
      this.gender,
      this.breed,
      this.size,
      this.about,
      this.picture,
      this.createdAt,
      this.updatedAt});

  Pets.fromJson(Map<String, dynamic> json) {
    healthIssues = json['healthIssues'].cast<String>();
    allergies = json['allergies'].cast<String>();
    isHidden = json['isHidden'];
    sId = json['_id'];
    user = json['user'];
    type = json['type'];
    name = json['name'];
    gender = json['gender'];
    breed = json['breed'];
    size = json['size'];
    about = json['about'];
    picture = json['picture'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['healthIssues'] = this.healthIssues;
    data['allergies'] = this.allergies;
    data['isHidden'] = this.isHidden;
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['type'] = this.type;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['breed'] = this.breed;
    data['size'] = this.size;
    data['about'] = this.about;
    data['picture'] = this.picture;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
