import '../profile/profile.dart';

class GetProductReviews {
  bool? status;
  List<ProductReviews>? reviews;

  GetProductReviews({this.status, this.reviews});

  GetProductReviews.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
  int? agent;
  Profile? profile;

  ProductReviews(
      {this.id,
      this.rating,
      this.comment,
      this.createdAt,
      this.updatedAt,
      this.agent,
      this.profile});

  ProductReviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    agent = json['agent'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['agent'] = this.agent;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

