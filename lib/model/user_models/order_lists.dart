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
  String? serviceType;
  String? agent;
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
    serviceType = json['serviceType'];
    agent = json['agent'];
    levelsAmount = json['levelsAmount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isLive'] = this.isLive;
    data['_id'] = this.sId;
    data['serviceType'] = this.serviceType;
    data['agent'] = this.agent;
    data['levelsAmount'] = this.levelsAmount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
