import '../product/product.dart';
import '../profile/profile.dart';
import '../user_models/shop_order.dart';

class AgentsOrderRequests {
  bool? status;
  String? message;
  bool? hasNext;
  bool? hasPrevious;
  int? numPages;
  int? currentPage;
  List<ShopOrders>? shopOrders;

  AgentsOrderRequests(
      {this.status,
      this.message,
      this.hasNext,
      this.hasPrevious,
      this.numPages,
      this.currentPage,
      this.shopOrders});

  AgentsOrderRequests.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    hasNext = json['has_next'];
    hasPrevious = json['has_previous'];
    numPages = json['num_pages'];
    currentPage = json['current_page'];
    if (json['shop_orders'] != null) {
      shopOrders = <ShopOrders>[];
      json['shop_orders'].forEach((v) {
        shopOrders!.add(new ShopOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['has_next'] = this.hasNext;
    data['has_previous'] = this.hasPrevious;
    data['num_pages'] = this.numPages;
    data['current_page'] = this.currentPage;
    if (this.shopOrders != null) {
      data['shop_orders'] = this.shopOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

