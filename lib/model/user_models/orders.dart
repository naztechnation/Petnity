import 'vet_orders.dart';

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

class Orders {
  bool? shouldNotify;
  bool? isPaid;
  bool? isAccepted;
  bool? isRejected;
  bool? isOngoing;
  bool? userMarkedDelivered;
  bool? agentMarkedDelivered;
  bool? isCompleted;
  bool? paymentReleased;
  String? sId;
  String? user;
  Agent? agent;
  Package? package;
  String? pickupLocation;
  String? pickupTime;
  String? dropoffTime;
  int? fee;
  String? createdAt;
  String? updatedAt;

  Orders(
      {this.shouldNotify,
      this.isPaid,
      this.isAccepted,
      this.isRejected,
      this.isOngoing,
      this.userMarkedDelivered,
      this.agentMarkedDelivered,
      this.isCompleted,
      this.paymentReleased,
      this.sId,
      this.user,
      this.agent,
      this.package,
      this.pickupLocation,
      this.pickupTime,
      this.dropoffTime,
      this.fee,
      this.createdAt,
      this.updatedAt});

  Orders.fromJson(Map<String, dynamic> json) {
    shouldNotify = json['shouldNotify'];
    isPaid = json['isPaid'];
    isAccepted = json['isAccepted'];
    isRejected = json['isRejected'];
    isOngoing = json['isOngoing'];
    userMarkedDelivered = json['userMarkedDelivered'];
    agentMarkedDelivered = json['agentMarkedDelivered'];
    isCompleted = json['isCompleted'];
    paymentReleased = json['paymentReleased'];
    sId = json['_id'];
    user = json['user'];
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    package =
        json['package'] != null ? new Package.fromJson(json['package']) : null;
    pickupLocation = json['pickupLocation'];
    pickupTime = json['pickupTime'];
    dropoffTime = json['dropoffTime'];
    fee = json['fee'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shouldNotify'] = this.shouldNotify;
    data['isPaid'] = this.isPaid;
    data['isAccepted'] = this.isAccepted;
    data['isRejected'] = this.isRejected;
    data['isOngoing'] = this.isOngoing;
    data['userMarkedDelivered'] = this.userMarkedDelivered;
    data['agentMarkedDelivered'] = this.agentMarkedDelivered;
    data['isCompleted'] = this.isCompleted;
    data['paymentReleased'] = this.paymentReleased;
    data['_id'] = this.sId;
    data['user'] = this.user;
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    data['pickupLocation'] = this.pickupLocation;
    data['pickupTime'] = this.pickupTime;
    data['dropoffTime'] = this.dropoffTime;
    data['fee'] = this.fee;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Agent {
  List<String>? services;
  List<String>? petTypes;
  bool? isVerified;
  bool? isReachable;
  String? sId;
  String? user;
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
  String? idType;

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
      this.city,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.idPhoto,
      this.idType});

  Agent.fromJson(Map<String, dynamic> json) {
    services = json['services'].cast<String>();
    petTypes = json['petTypes'].cast<String>();
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    idPhoto = json['idPhoto'];
    idType = json['idType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['services'] = this.services;
    data['petTypes'] = this.petTypes;
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['idPhoto'] = this.idPhoto;
    data['idType'] = this.idType;
    return data;
  }
}

class Package {
  String? sId;
  String? service;
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
    service = json['service'];
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
    data['service'] = this.service;
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



