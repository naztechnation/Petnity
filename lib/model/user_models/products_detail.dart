import '../product/product.dart';

class ProductDetails {
  bool? status;
  String? message;
  ProductDetailsData? data;

  ProductDetails({this.status, this.message, this.data});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ProductDetailsData.fromJson(json['data']) : null;
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

class ProductDetailsData {
  Products? product;

  ProductDetailsData({this.product});

  ProductDetailsData.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Products.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

