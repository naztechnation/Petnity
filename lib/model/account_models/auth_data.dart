

class AuthData {
  bool? status;
  String? message;
  bool? isAgent;
  Profile? profile;

  AuthData({this.status, this.message, this.isAgent, this.profile});

  AuthData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    isAgent = json['is_agent'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['is_agent'] = this.isAgent;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class Profile {
  int? id;
  String? phoneNumber;
  Null? address;
  Null? city;
  Null? country;
  Null? profileImage;
  bool? isAgent;
  bool? isReachable;
  bool? isVerified;
  bool? hasPets;
  String? createdAt;
  String? updatedAt;
  User? user;

  Profile(
      {this.id,
      this.phoneNumber,
      this.address,
      this.city,
      this.country,
      this.profileImage,
      this.isAgent,
      this.isReachable,
      this.isVerified,
      this.hasPets,
      this.createdAt,
      this.updatedAt,
      this.user});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    profileImage = json['profile_image'];
    isAgent = json['is_agent'];
    isReachable = json['is_reachable'];
    isVerified = json['is_verified'];
    hasPets = json['has_pets'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['profile_image'] = this.profileImage;
    data['is_agent'] = this.isAgent;
    data['is_reachable'] = this.isReachable;
    data['is_verified'] = this.isVerified;
    data['has_pets'] = this.hasPets;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;

  User({this.id, this.username, this.email, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

