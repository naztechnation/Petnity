class CreateOrder {
  bool? status;
  String? message;
  Data? data;

  CreateOrder({this.status, this.message, this.data});

  CreateOrder.fromJson(Map<String, dynamic> json) {
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
  Order? order;

  Data({this.order});

  Data.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class Order {
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
  String? package;
  String? pickupLocation;
  String? pickupTime;
  String? dropoffTime;
  int? fee;
  String? purchaseId;
  String? createdAt;
  String? updatedAt;

  Order(
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
      this.purchaseId,
      this.createdAt,
      this.updatedAt});

  Order.fromJson(Map<String, dynamic> json) {
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
    package = json['package'];
    pickupLocation = json['pickupLocation'];
    pickupTime = json['pickupTime'];
    dropoffTime = json['dropoffTime'];
    fee = json['fee'];
    purchaseId = json['purchaseId'];
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
    data['package'] = this.package;
    data['pickupLocation'] = this.pickupLocation;
    data['pickupTime'] = this.pickupTime;
    data['dropoffTime'] = this.dropoffTime;
    data['fee'] = this.fee;
    data['purchaseId'] = this.purchaseId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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
  String? verificationCode;

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
      this.iV,
      this.verificationCode});

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
    verificationCode = json['verificationCode'];
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
    data['verificationCode'] = this.verificationCode;
    return data;
  }
}
