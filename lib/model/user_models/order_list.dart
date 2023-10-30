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
  int? agent;
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
    agent = json['agent'];
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
    data['agent'] = this.agent;
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
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
  ServiceType? serviceType;
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
        ? new ServiceType.fromJson(json['service_type'])
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

class ServiceType {
  int? id;
  String? name;
  String? image;

  ServiceType({this.id, this.name, this.image});

  ServiceType.fromJson(Map<String, dynamic> json) {
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
