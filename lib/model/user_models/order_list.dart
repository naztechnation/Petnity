class UserOrderList {
  bool? status;
  List<UserOrders>? orders;

  UserOrderList({this.status, this.orders});

  UserOrderList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['orders'] != null) {
      orders = <UserOrders>[];
      json['orders'].forEach((v) {
        orders!.add(new UserOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserOrders {
  int? id;
  String? pickupLocation;
  String? pickupTime;
  String? dropoffTime;
  bool? shouldNotify;
  String? fee;
  String? purchaseId;
  bool? isPaid;
  bool? isAccepted;
  bool? isRejected;
  bool? isOngoing;
  bool? isCompleted;
  bool? paymentReleased;
  String? dateCreated;
  int? profile;
  Agent? agent;
  Package? package;

  UserOrders(
      {this.id,
      this.pickupLocation,
      this.pickupTime,
      this.dropoffTime,
      this.shouldNotify,
      this.fee,
      this.purchaseId,
      this.isPaid,
      this.isAccepted,
      this.isRejected,
      this.isOngoing,
      this.isCompleted,
      this.paymentReleased,
      this.dateCreated,
      this.profile,
      this.agent,
      this.package});

  UserOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pickupLocation = json['pickup_location'];
    pickupTime = json['pickup_time'];
    dropoffTime = json['dropoff_time'];
    shouldNotify = json['should_notify'];
    fee = json['fee'];
    purchaseId = json['purchase_id'];
    isPaid = json['is_paid'];
    isAccepted = json['is_accepted'];
    isRejected = json['is_rejected'];
    isOngoing = json['is_ongoing'];
    isCompleted = json['is_completed'];
    paymentReleased = json['payment_released'];
    dateCreated = json['date_created'];
    profile = json['profile'];
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    package =
        json['package'] != null ? new Package.fromJson(json['package']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pickup_location'] = this.pickupLocation;
    data['pickup_time'] = this.pickupTime;
    data['dropoff_time'] = this.dropoffTime;
    data['should_notify'] = this.shouldNotify;
    data['fee'] = this.fee;
    data['purchase_id'] = this.purchaseId;
    data['is_paid'] = this.isPaid;
    data['is_accepted'] = this.isAccepted;
    data['is_rejected'] = this.isRejected;
    data['is_ongoing'] = this.isOngoing;
    data['is_completed'] = this.isCompleted;
    data['payment_released'] = this.paymentReleased;
    data['date_created'] = this.dateCreated;
    data['profile'] = this.profile;
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    return data;
  }
}

class Agent {
  int? id;
  String? name;
  String? gender;
  String? dateOfBirth;
  String? about;
  String? picture;
  String? country;
  String? city;
  String? idPhoto;
  bool? isVerified;
  bool? isReachable;
  String? createdAt;
  String? updatedAt;
  Profile? profile;
  int? idType;
  List<Services>? services;
  List<PetTypes>? petTypes;

  Agent(
      {this.id,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.about,
      this.picture,
      this.country,
      this.city,
      this.idPhoto,
      this.isVerified,
      this.isReachable,
      this.createdAt,
      this.updatedAt,
      this.profile,
      this.idType,
      this.services,
      this.petTypes});

  Agent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    about = json['about'];
    picture = json['picture'];
    country = json['country'];
    city = json['city'];
    idPhoto = json['id_photo'];
    isVerified = json['is_verified'];
    isReachable = json['is_reachable'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    idType = json['id_type'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['pet_types'] != null) {
      petTypes = <PetTypes>[];
      json['pet_types'].forEach((v) {
        petTypes!.add(new PetTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['about'] = this.about;
    data['picture'] = this.picture;
    data['country'] = this.country;
    data['city'] = this.city;
    data['id_photo'] = this.idPhoto;
    data['is_verified'] = this.isVerified;
    data['is_reachable'] = this.isReachable;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['id_type'] = this.idType;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.petTypes != null) {
      data['pet_types'] = this.petTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profile {
  int? id;
  String? firebaseId;
  String? phoneNumber;
  String? address;
  String? city;
  String? country;
  String? profileImage;
  bool? isAgent;
  bool? isReachable;
  bool? isVerified;
  bool? hasPets;
  String? createdAt;
  String? updatedAt;
  User? user;

  Profile(
      {this.id,
      this.firebaseId,
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
    firebaseId = json['firebase_id'];
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
    data['firebase_id'] = this.firebaseId;
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

class Services {
  int? id;
  String? name;
  String? image;

  Services({this.id, this.name, this.image});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class PetTypes {
  int? id;
  String? name;

  PetTypes({this.id, this.name});

  PetTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Package {
  int? id;
  int? level;
  String? name;
  String? description;
  String? duration;
  String? price;
  String? createdAt;
  String? updatedAt;
  Service? service;

  Package(
      {this.id,
      this.level,
      this.name,
      this.description,
      this.duration,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.service});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    name = json['name'];
    description = json['description'];
    duration = json['duration'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['level'] = this.level;
    data['name'] = this.name;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class Service {
  int? id;
  int? levelsAmount;
  bool? isLive;
  String? createdAt;
  String? updatedAt;
  Services? serviceType;
  int? agent;

  Service(
      {this.id,
      this.levelsAmount,
      this.isLive,
      this.createdAt,
      this.updatedAt,
      this.serviceType,
      this.agent});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    levelsAmount = json['levels_amount'];
    isLive = json['is_live'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    serviceType = json['service_type'] != null
        ? new Services.fromJson(json['service_type'])
        : null;
    agent = json['agent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['levels_amount'] = this.levelsAmount;
    data['is_live'] = this.isLive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.serviceType != null) {
      data['service_type'] = this.serviceType!.toJson();
    }
    data['agent'] = this.agent;
    return data;
  }
}
