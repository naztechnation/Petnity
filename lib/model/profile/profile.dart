

import '../user/user.dart';

class Profile {
  int? id;
  String? firebaseId;
  var deviceId;
  String? phoneNumber;
  var address;
  var city;
  var country;
  String? profileImage;
  var bio;
  bool? isAgent;
  bool? isReachable;
  bool? isVerified;
  bool? hasPets;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  User? user;

  Profile(
      {this.id,
      this.firebaseId,
      this.deviceId,
      this.phoneNumber,
      this.address,
      this.city,
      this.country,
      this.profileImage,
      this.bio,
      this.isAgent,
      this.isReachable,
      this.isVerified,
      this.hasPets,
      this.createdAt,
      this.updatedAt,
      this.isDeleted,
      this.user});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firebaseId = json['firebase_id'];
    deviceId = json['device_id'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    profileImage = json['profile_image'];
    bio = json['bio'];
    isAgent = json['is_agent'];
    isReachable = json['is_reachable'];
    isVerified = json['is_verified'];
    hasPets = json['has_pets'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firebase_id'] = this.firebaseId;
    data['device_id'] = this.deviceId;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['profile_image'] = this.profileImage;
    data['bio'] = this.bio;
    data['is_agent'] = this.isAgent;
    data['is_reachable'] = this.isReachable;
    data['is_verified'] = this.isVerified;
    data['has_pets'] = this.hasPets;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_deleted'] = this.isDeleted;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}