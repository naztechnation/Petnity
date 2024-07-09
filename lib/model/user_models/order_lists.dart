import 'package:petnity/model/user_models/vet_orders.dart';

import 'order.dart';

class UserOrders {
  bool? status;
  String? message;
  Data? data;

  UserOrders({this.status, this.message, this.data});

  UserOrders.fromJson(Map<String, dynamic> json) {
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
  List<Orders>? orders;
  List<VetOrders>? vetOrders;

  Data({this.orders, this.vetOrders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    if (json['vetOrders'] != null) {
      vetOrders = <VetOrders>[];
      json['vetOrders'].forEach((v) {
        vetOrders!.add(new VetOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    if (this.vetOrders != null) {
      data['vetOrders'] = this.vetOrders!.map((v) => v.toJson()).toList();
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
  bool? isBanned;
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
      this.isBanned,
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
    isBanned = json['isBanned'];
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
    data['isBanned'] = this.isBanned;
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

class Agent {
  List<Services>? services;
  List<PetTypes>? petTypes;
  int? ratingFromAdmin;
  bool? isVerified;
  bool? isReachable;
  bool? isBanned;
  String? sId;
  User? user;
  String? name;
  String? gender;
  String? dateOfBirth;
  String? about;
  String? picture;
  String? country;
  String? city;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? idPhoto;
  PetTypes? idType;

  Agent(
      {this.services,
      this.petTypes,
      this.ratingFromAdmin,
      this.isVerified,
      this.isReachable,
      this.isBanned,
      this.sId,
      this.user,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.about,
      this.picture,
      this.country,
      this.city,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.idPhoto,
      this.idType});

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
    ratingFromAdmin = json['ratingFromAdmin'];
    isVerified = json['isVerified'];
    isReachable = json['isReachable'];
    isBanned = json['isBanned'];
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    about = json['about'];
    picture = json['picture'];
    country = json['country'];
    city = json['city'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    idPhoto = json['idPhoto'];
    idType =
        json['idType'] != null ? new PetTypes.fromJson(json['idType']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.petTypes != null) {
      data['petTypes'] = this.petTypes!.map((v) => v.toJson()).toList();
    }
    data['ratingFromAdmin'] = this.ratingFromAdmin;
    data['isVerified'] = this.isVerified;
    data['isReachable'] = this.isReachable;
    data['isBanned'] = this.isBanned;
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['about'] = this.about;
    data['picture'] = this.picture;
    data['country'] = this.country;
    data['city'] = this.city;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['idPhoto'] = this.idPhoto;
    if (this.idType != null) {
      data['idType'] = this.idType!.toJson();
    }
    return data;
  }
}

class Services {
  String? sId;
  String? name;
  String? image;
  int? iV;

  Services({this.sId, this.name, this.image, this.iV});

  Services.fromJson(Map<String, dynamic> json) {
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

class PetTypes {
  String? sId;
  String? name;
  int? iV;

  PetTypes({this.sId, this.name, this.iV});

  PetTypes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['__v'] = this.iV;
    return data;
  }
}


class Package {
  String? sId;
  Service? service;
  int? level;
  String? name;
  String? description;
  int? price;
  String? duration;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Package(
      {this.sId,
      this.service,
      this.level,
      this.name,
      this.description,
      this.price,
      this.duration,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Package.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    level = json['level'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    duration = json['duration'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['level'] = this.level;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Service {
  bool? isLive;
  String? sId;
  Services? serviceType;
  Agent? agent;
  int? levelsAmount;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Service(
      {this.isLive,
      this.sId,
      this.serviceType,
      this.agent,
      this.levelsAmount,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Service.fromJson(Map<String, dynamic> json) {
    isLive = json['isLive'];
    sId = json['_id'];
    serviceType = json['serviceType'] != null
        ? new Services.fromJson(json['serviceType'])
        : null;
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    levelsAmount = json['levelsAmount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isLive'] = this.isLive;
    data['_id'] = this.sId;
    if (this.serviceType != null) {
      data['serviceType'] = this.serviceType!.toJson();
    }
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    data['levelsAmount'] = this.levelsAmount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
