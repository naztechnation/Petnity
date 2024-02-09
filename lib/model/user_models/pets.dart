import '../pet_types.dart/pet_types.dart';
import '../user/user.dart';
import 'health_issues.dart';

class Pets {
  List<HealthIssues>? healthIssues;
  List<HealthIssues>? allergies;
  bool? isHidden;
  String? sId;
  User? user;
  PetTypes? type;
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
    if (json['healthIssues'] != null) {
      healthIssues = <HealthIssues>[];
      json['healthIssues'].forEach((v) {
        healthIssues!.add(new HealthIssues.fromJson(v));
      });
    }
    if (json['allergies'] != null) {
      allergies = <HealthIssues>[];
      json['allergies'].forEach((v) {
        allergies!.add(new HealthIssues.fromJson(v));
      });
    }
    isHidden = json['isHidden'];
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    type = json['type'] != null ? new PetTypes.fromJson(json['type']) : null;
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
    if (this.healthIssues != null) {
      data['healthIssues'] = this.healthIssues!.map((v) => v.toJson()).toList();
    }
    if (this.allergies != null) {
      data['allergies'] = this.allergies!.map((v) => v.toJson()).toList();
    }
    data['isHidden'] = this.isHidden;
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
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