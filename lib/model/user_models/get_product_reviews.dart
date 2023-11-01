

class GetProductReviews {
  bool? status;
  String? message;
  List<ProductReviews>? reviews;

  GetProductReviews({this.status, this.message, this.reviews});

  GetProductReviews.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['reviews'] != null) {
      reviews = <ProductReviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new ProductReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductReviews {
  int? id;
  int? rating;
  String? comment;
  String? createdAt;
  String? updatedAt;
  int? profile;
  ReviewProduct? product;

  ProductReviews(
      {this.id,
      this.rating,
      this.comment,
      this.createdAt,
      this.updatedAt,
      this.profile,
      this.product});

  ProductReviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profile = json['profile'];
    product =
        json['product'] != null ? new ReviewProduct.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile'] = this.profile;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class ReviewProduct {
  int? id;
  String? name;
  String? price;
  bool? inStock;
  String? image;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? agent;

  ReviewProduct(
      {this.id,
      this.name,
      this.price,
      this.inStock,
      this.image,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.agent});

  ReviewProduct.fromJson(Map<String, dynamic> json) {
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
