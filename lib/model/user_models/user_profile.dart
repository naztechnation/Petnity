import '../user/user.dart';
import 'pets_profile.dart';

class UserProfile {
  bool? status;
  String? message;
  UserProfileData? data;

  UserProfile({this.status, this.message, this.data});

  UserProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserProfileData.fromJson(json['data']) : null;
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

class UserProfileData {
  User? user;
  List<Pets>? pets;

  UserProfileData({this.user, this.pets});

  UserProfileData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['pets'] != null) {
      pets = <Pets>[];
      json['pets'].forEach((v) {
        pets!.add(new Pets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.pets != null) {
      data['pets'] = this.pets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




