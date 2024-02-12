import '../product/product.dart';

class ShoppingList {
  bool? status;
  String? message;
  ShoppingListData? data;

  ShoppingList({this.status, this.message, this.data});

  ShoppingList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ShoppingListData.fromJson(json['data']) : null;
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

class ShoppingListData {
  int? page;
  int? totalPages;
  List<Products>? products;

  ShoppingListData({this.page, this.totalPages, this.products});

  ShoppingListData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalPages = json['totalPages'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['totalPages'] = this.totalPages;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

