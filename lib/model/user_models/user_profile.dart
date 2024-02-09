class UserProfile {
  bool? status;
  String? message;
  Data? data;

  UserProfile({this.status, this.message, this.data});

  UserProfile.fromJson(Map<String, dynamic> json) {
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
  User? user;
  List<Pets>? pets;

  Data({this.user, this.pets});

  Data.fromJson(Map<String, dynamic> json) {
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

class User {
  bool? isAdmin;
  String? profileImage;
  bool? isAgent;
  bool? isReachable;
  bool? hasPets;
  bool? isVerified;
  bool? isDeleted;
  String? sId;
  String? username;
  String? email;
  String? phoneNumber;
  String? firebaseId;
  String? deviceId;

  User(
      {this.isAdmin,
      this.profileImage,
      this.isAgent,
      this.isReachable,
      this.hasPets,
      this.isVerified,
      this.isDeleted,
      this.sId,
      this.username,
      this.email,
      this.phoneNumber,
      this.firebaseId,
      this.deviceId});

  User.fromJson(Map<String, dynamic> json) {
    isAdmin = json['isAdmin'];
    profileImage = json['profileImage'];
    isAgent = json['isAgent'];
    isReachable = json['isReachable'];
    hasPets = json['hasPets'];
    isVerified = json['isVerified'];
    isDeleted = json['isDeleted'];
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    firebaseId = json['firebaseId'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAdmin'] = this.isAdmin;
    data['profileImage'] = this.profileImage;
    data['isAgent'] = this.isAgent;
    data['isReachable'] = this.isReachable;
    data['hasPets'] = this.hasPets;
    data['isVerified'] = this.isVerified;
    data['isDeleted'] = this.isDeleted;
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['firebaseId'] = this.firebaseId;
    data['deviceId'] = this.deviceId;
    return data;
  }
}

class Pets {
  List<HealthIssues>? healthIssues;
  List<HealthIssues>? allergies;
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
    if (this.healthIssues != null) {
      data['healthIssues'] = this.healthIssues!.map((v) => v.toJson()).toList();
    }
    if (this.allergies != null) {
      data['allergies'] = this.allergies!.map((v) => v.toJson()).toList();
    }
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

class HealthIssues {
  String? sId;
  String? pet;
  String? name;
  String? drug;
  String? prescription;
  String? createdAt;
  String? updatedAt;
  int? iV;

  HealthIssues(
      {this.sId,
      this.pet,
      this.name,
      this.drug,
      this.prescription,
      this.createdAt,
      this.updatedAt,
      this.iV});

  HealthIssues.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    pet = json['pet'];
    name = json['name'];
    drug = json['drug'];
    prescription = json['prescription'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['pet'] = this.pet;
    data['name'] = this.name;
    data['drug'] = this.drug;
    data['prescription'] = this.prescription;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
