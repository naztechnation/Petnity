import 'orders.dart';
import 'vet_orders.dart';

class UserOrderList {
  bool? status;
  String? message;
  UserOrderListData? data;

  UserOrderList({this.status, this.message, this.data});

  UserOrderList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserOrderListData.fromJson(json['data']) : null;
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

class UserOrderListData {
  List<UserOrders>? orders;
  List<VetOrders>? vetOrders;

  UserOrderListData({this.orders, this.vetOrders});

  UserOrderListData.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <UserOrders>[];
      json['orders'].forEach((v) {
        orders!.add(new UserOrders.fromJson(v));
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

