 

import 'shop_order.dart';

class CreatePaymentOrder {
  bool? status;
  String? message;
  ShopOrders? shopOrder;

  CreatePaymentOrder({this.status, this.message, this.shopOrder});

  CreatePaymentOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    shopOrder = json['shop_order'] != null
        ? new ShopOrders.fromJson(json['shop_order'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.shopOrder != null) {
      data['shop_order'] = this.shopOrder!.toJson();
    }
    return data;
  }
}

