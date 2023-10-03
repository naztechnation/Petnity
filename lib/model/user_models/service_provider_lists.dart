
class ServiceProvidersList {
  bool? status;
  List<Agents>? agents;

  ServiceProvidersList({this.status, this.agents});

  ServiceProvidersList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['agents'] != null) {
      agents = <Agents>[];
      json['agents'].forEach((v) {
        agents!.add(new Agents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.agents != null) {
      data['agents'] = this.agents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Agents {
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
  Null? idType;
  List<Services>? services;
  List<PetTypes>? petTypes;

  Agents(
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

  Agents.fromJson(Map<String, dynamic> json) {
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
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['pet_types'] != null) {
      petTypes = <PetTypes>[];
      json['pet_types'].forEach((v) {
        petTypes!.add(new PetTypes.fromJson(v));
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
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.petTypes != null) {
      data['pet_types'] = this.petTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? name;

  Services({this.id, this.name});

  Services.fromJson(Map<String, dynamic> json) {
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
