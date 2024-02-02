 
import '../product/product.dart'; 

class ProductDetails {
  bool? status;
  String? message;
  Products? product;

  ProductDetails({this.status, this.message, this.product});

  ProductDetails.fromJson(Map<String, dynamic> json) {
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

