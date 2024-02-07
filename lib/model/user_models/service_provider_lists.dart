import '../agent/agent.dart';

class ServiceProvidersList {
  bool? status;
  String? message;
  ServiceProvidersListData? data;

  ServiceProvidersList({this.status, this.message, this.data});

  ServiceProvidersList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ServiceProvidersListData.fromJson(json['data']) : null;
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

class ServiceProvidersListData {
  List<Agent>? agents;

  ServiceProvidersListData({this.agents});

  ServiceProvidersListData.fromJson(Map<String, dynamic> json) {
    if (json['agents'] != null) {
      agents = <Agent>[];
      json['agents'].forEach((v) {
        agents!.add(new Agent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.agents != null) {
      data['agents'] = this.agents!.map((v) => v.toJson()).toList();
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
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;

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
      this.deviceId,
      this.password,
      this.createdAt,
      this.updatedAt,
      this.iV});

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
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
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
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
