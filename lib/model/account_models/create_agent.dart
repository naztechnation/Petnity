
class CreateAgents {
  bool? status;
  String? message;
  Agent? agent;

  CreateAgents({this.status, this.message, this.agent});

  CreateAgents.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    return data;
  }
}

class Agent {
  int? id;
  String? name;
  String? gender;
  String? dateOfBirth;
  String? about;
  String? picture;
  String? country;
  String? city;
  String? idPhoto;
  bool? isVerified;
  bool? isReachable;
  String? createdAt;
  String? updatedAt;
  int? profile;
  var idType;
  var services;
  var petTypes;

  Agent(
      {this.id,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.about,
      this.picture,
      this.country,
      this.city,
      this.idPhoto,
      this.isVerified,
      this.isReachable,
      this.createdAt,
      this.updatedAt,
      this.profile,
      this.idType,
      this.services,
      this.petTypes});

  Agent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    about = json['about'];
    picture = json['picture'];
    country = json['country'];
    city = json['city'];
    idPhoto = json['id_photo'];
    isVerified = json['is_verified'];
    isReachable = json['is_reachable'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profile = json['profile'];
    idType = json['id_type'];
    if (json['services'] != null) {
      services = <Null>[];
      json['services'].forEach((v) {
       // services!.add(new Null.fromJson(v));
      });
    }
    if (json['pet_types'] != null) {
      petTypes = <Null>[];
      json['pet_types'].forEach((v) {
       // petTypes!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['about'] = this.about;
    data['picture'] = this.picture;
    data['country'] = this.country;
    data['city'] = this.city;
    data['id_photo'] = this.idPhoto;
    data['is_verified'] = this.isVerified;
    data['is_reachable'] = this.isReachable;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile'] = this.profile;
    data['id_type'] = this.idType;
    if (this.services != null) {
     // data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.petTypes != null) {
     // data['pet_types'] = this.petTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
