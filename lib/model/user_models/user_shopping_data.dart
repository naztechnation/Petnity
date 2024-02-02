 

import '../product/product.dart';
import '../profile/profile.dart';

class UserShopData {
  bool? status;
  String? message;
  List<UserShopList>? shopOrders;

  UserShopData({this.status, this.message, this.shopOrders});

  UserShopData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['shop_orders'] != null) {
      shopOrders = <UserShopList>[];
      json['shop_orders'].forEach((v) {
        shopOrders!.add(new UserShopList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.shopOrders != null) {
      data['shop_orders'] = this.shopOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserShopList {
  int? id;
  int? quantity;
  String? total;
  String? paymentId;
  bool? isPaid;
  bool? userMarkedDelivered;
  bool? agentMarkedDelivered;
  String? createdAt;
  String? updatedAt;
  Profile? profile;
  int? agent;
  Products? product;

  UserShopList(
      {this.id,
      this.quantity,
      this.total,
      this.paymentId,
      this.isPaid,
      this.userMarkedDelivered,
      this.agentMarkedDelivered,
      this.createdAt,
      this.updatedAt,
      this.profile,
      this.agent,
      this.product});

  UserShopList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    total = json['total'];
    paymentId = json['payment_id'];
    isPaid = json['is_paid'];
    userMarkedDelivered = json['user_marked_delivered'];
    agentMarkedDelivered = json['agent_marked_delivered'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    agent = json['agent'];
    product =
        json['product'] != null ? new Products.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['payment_id'] = this.paymentId;
    data['is_paid'] = this.isPaid;
    data['user_marked_delivered'] = this.userMarkedDelivered;
    data['agent_marked_delivered'] = this.agentMarkedDelivered;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['agent'] = this.agent;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}



