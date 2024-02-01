import '../pet_types.dart/pet_types.dart';

class ServiceProvidersList {
  bool? status;
  String? message;
  Data? data;

  ServiceProvidersList({this.status, this.message, this.data});

  ServiceProvidersList.fromJson(Map<String, dynamic> json) {
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
  List<ServicesType>? services;
  List<PetTypes>? petTypes;
  bool? isVerified;
  bool? isReachable;
  String? sId;
  User? user;

  Data(
      {this.services,
      this.petTypes,
      this.isVerified,
      this.isReachable,
      this.sId,
      this.user});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <ServicesType>[];
      json['services'].forEach((v) {
        services!.add(new ServicesType.fromJson(v));
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class ServicesType {
  String? sId;
  String? name;
  String? image;
  int? iV;

  ServicesType({this.sId, this.name, this.image, this.iV});

  ServicesType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  bool? isAdmin;
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
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isAgent;

  User(
      {this.isAdmin,
      this.isReachable,
      this.hasPets,
      this.isVerified,
      this.isDeleted,
      this.sId,
      this.username,
      this.email,
      this.phoneNumber,
      this.firebaseId,
      this.deviceId,
      this.password,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isAgent});

  User.fromJson(Map<String, dynamic> json) {
    isAdmin = json['isAdmin'];
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
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isAgent = json['isAgent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAdmin'] = this.isAdmin;
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
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isAgent'] = this.isAgent;
    return data;
  }
}
