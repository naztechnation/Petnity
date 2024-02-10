 

import 'order.dart';
import 'vet_orders.dart'; 

class AgentServicesList {
  bool? status;
  List<Orders>? orders;
  List<VetOrders>? vetOrders;

  AgentServicesList({this.status, this.orders, this.vetOrders});

  AgentServicesList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    if (json['vet_orders'] != null) {
      vetOrders = <VetOrders>[];
      json['vet_orders'].forEach((v) {
        vetOrders!.add(new VetOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    if (this.vetOrders != null) {
      data['vet_orders'] = this.vetOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




