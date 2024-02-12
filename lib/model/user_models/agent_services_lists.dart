import '../agent/agent.dart';
import '../packages/packages.dart';
import '../user/user.dart';
import 'order.dart';
import 'vet_orders.dart';

class AgentServicesList {
  bool? status;
  String? message;
  AgentServicesListData? data;

  AgentServicesList({this.status, this.message, this.data});

  AgentServicesList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AgentServicesListData.fromJson(json['data']) : null;
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

class AgentServicesListData {
  List<Orders>? orders;
  List<VetOrders>? vetOrders;

  AgentServicesListData({this.orders, this.vetOrders});

  AgentServicesListData.fromJson(Map<String, dynamic> json) {
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

