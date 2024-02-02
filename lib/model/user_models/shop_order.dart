import 'package:petnity/model/user/user.dart';

import '../agent/agent.dart';
import '../product/product.dart';

class ShopOrders {
  bool? isPaid;
  bool? isAccepted;
  bool? isRejected;
  bool? isOngoing;
  bool? userMarkedDelivered;
  bool? agentMarkedDelivered;
  bool? isDelivered;
  String? sId;
  User? user;
  Agent? agent;
  String? address;
  Products? product;
  int? quantity;
  int? total;
  String? createdAt;
  String? updatedAt;

  ShopOrders(
      {this.isPaid,
      this.isAccepted,
      this.isRejected,
      this.isOngoing,
      this.userMarkedDelivered,
      this.agentMarkedDelivered,
      this.isDelivered,
      this.sId,
      this.user,
      this.agent,
      this.address,
      this.product,
      this.quantity,
      this.total,
      this.createdAt,
      this.updatedAt});

  ShopOrders.fromJson(Map<String, dynamic> json) {
    isPaid = json['isPaid'];
    isAccepted = json['isAccepted'];
    isRejected = json['isRejected'];
    isOngoing = json['isOngoing'];
    userMarkedDelivered = json['userMarkedDelivered'];
    agentMarkedDelivered = json['agentMarkedDelivered'];
    isDelivered = json['isDelivered'];
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    address = json['address'];
    product =
        json['product'] != null ? new Products.fromJson(json['product']) : null;
    quantity = json['quantity'];
    total = json['total'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isPaid'] = this.isPaid;
    data['isAccepted'] = this.isAccepted;
    data['isRejected'] = this.isRejected;
    data['isOngoing'] = this.isOngoing;
    data['userMarkedDelivered'] = this.userMarkedDelivered;
    data['agentMarkedDelivered'] = this.agentMarkedDelivered;
    data['isDelivered'] = this.isDelivered;
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    data['address'] = this.address;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
