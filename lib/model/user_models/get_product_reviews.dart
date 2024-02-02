import '../product/product.dart';
import '../user/user.dart';

class GetProductReviews {
  bool? status;
  String? message;
  GetProductReviewsData? data;

  GetProductReviews({this.status, this.message, this.data});

  GetProductReviews.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new GetProductReviewsData.fromJson(json['data']) : null;
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

class GetProductReviewsData {
  int? page;
  List<ProductReviews>? reviews;

  GetProductReviewsData({this.page, this.reviews});

  GetProductReviewsData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['reviews'] != null) {
      reviews = <ProductReviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new ProductReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductReviews {
  String? sId;
  User? user;
  Products? product;
  int? rating;
  String? comment;
  String? createdAt;
  String? updatedAt;

  ProductReviews(
      {this.sId,
      this.user,
      this.product,
      this.rating,
      this.comment,
      this.createdAt,
      this.updatedAt});

  ProductReviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    product =
        json['product'] != null ? new Products.fromJson(json['product']) : null;
    rating = json['rating'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

