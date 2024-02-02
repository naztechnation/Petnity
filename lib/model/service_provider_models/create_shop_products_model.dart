
import '../product/product.dart';

class CreateShopProduct {
  bool? status;
  String? message;
  Products? product;

  CreateShopProduct({this.status, this.message, this.product});

  CreateShopProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    product =
        json['product'] != null ? new Products.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

