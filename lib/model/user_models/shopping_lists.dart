

class ShoppingList {
  bool? status;
  String? message;
  bool? hasNext;
  bool? hasPrevious;
  int? numPages;
  int? currentPage;
  List<Products>? products;

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
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
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

class Products {
  int? id;
  String? name;
  String? price;
  bool? inStock;
  String? image;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? agent;

  Products(
      {this.id,
      this.name,
      this.price,
      this.inStock,
      this.image,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.agent});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    inStock = json['in_stock'];
    image = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    agent = json['agent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['in_stock'] = this.inStock;
    data['image'] = this.image;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['agent'] = this.agent;
    return data;
  }
}
