 
import '../product/product.dart'; 

class ShoppingList {
  bool? status;
  String? message;
  bool? hasNext;
  bool? hasPrevious;
  int? numPages;
  int? currentPage;
  List<Product>? products;

  ShoppingList(
      {this.status,
      this.message,
      this.hasNext,
      this.hasPrevious,
      this.numPages,
      this.currentPage,
      this.products});

  ShoppingList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    hasNext = json['has_next'];
    hasPrevious = json['has_previous'];
    numPages = json['num_pages'];
    currentPage = json['current_page'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(new Product.fromJson(v));
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
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

