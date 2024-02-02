import 'package:petnity/model/user_models/shop_order.dart';

class UserShopData {
  bool? status;
  String? message;
  UserShopDataData? data;

  UserShopData({this.status, this.message, this.data});

  UserShopData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserShopDataData.fromJson(json['data']) : null;
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

class UserShopDataData {
  List<ShopOrders>? shopOrders;

  UserShopDataData({this.shopOrders});

  UserShopDataData.fromJson(Map<String, dynamic> json) {
    if (json['shopOrders'] != null) {
      shopOrders = <ShopOrders>[];
      json['shopOrders'].forEach((v) {
        shopOrders!.add(new ShopOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shopOrders != null) {
      data['shopOrders'] = this.shopOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


