import 'package:petnity/model/user/user.dart';

import '../pet_types.dart/pet_types.dart';
import '../services/services.dart';

class Agent {
  List<Services>? services;
  List<PetTypes>? petTypes;
  bool? isVerified;
  bool? isReachable;
  String? sId;
  User? user;
  String? name;
  String? gender;
  String? dateOfBirth;
  String? about;
  String? picture;
  String? country;
  String? city;

  Agent(
      {this.services,
      this.petTypes,
      this.isVerified,
      this.isReachable,
      this.sId,
      this.user,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.about,
      this.picture,
      this.country,
      this.city});

  Agent.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['petTypes'] != null) {
      petTypes = <PetTypes>[];
      json['petTypes'].forEach((v) {
        petTypes!.add(new PetTypes.fromJson(v));
      });
    }
    isVerified = json['isVerified'];
    isReachable = json['isReachable'];
    sId = json['_id'];
    user = json['user'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    about = json['about'];
    picture = json['picture'];
    country = json['country'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.petTypes != null) {
      data['petTypes'] = this.petTypes!.map((v) => v.toJson()).toList();
    }
    data['isVerified'] = this.isVerified;
    data['isReachable'] = this.isReachable;
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['about'] = this.about;
    data['picture'] = this.picture;
    data['country'] = this.country;
    data['city'] = this.city;
    return data;
  }
}