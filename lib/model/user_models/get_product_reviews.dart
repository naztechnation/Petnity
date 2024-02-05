class GetProductReviews {
  bool? status;
  String? message;
  ProductReviewsData? data;

  GetProductReviews({this.status, this.message, this.data});

  GetProductReviews.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ProductReviewsData.fromJson(json['data']) : null;
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

class ProductReviewsData {
  int? page;
  List<Reviews>? reviews;

  ProductReviewsData({this.page, this.reviews});

  ProductReviewsData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
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

class Reviews {
  String? sId;
  User? user;
  Product? product;
  int? rating;
  String? comment;
  String? createdAt;
  String? updatedAt;

  Reviews(
      {this.sId,
      this.user,
      this.product,
      this.rating,
      this.comment,
      this.createdAt,
      this.updatedAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
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

class User {
  bool? isAdmin;
  String? profileImage;
  bool? isAgent;
  bool? isReachable;
  bool? hasPets;
  bool? isVerified;
  bool? isDeleted;
  String? sId;
  String? username;
  String? email;
  String? phoneNumber;
  String? firebaseId;
  String? deviceId;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.isAdmin,
      this.profileImage,
      this.isAgent,
      this.isReachable,
      this.hasPets,
      this.isVerified,
      this.isDeleted,
      this.sId,
      this.username,
      this.email,
      this.phoneNumber,
      this.firebaseId,
      this.deviceId,
      this.password,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    isAdmin = json['isAdmin'];
    profileImage = json['profileImage'];
    isAgent = json['isAgent'];
    isReachable = json['isReachable'];
    hasPets = json['hasPets'];
    isVerified = json['isVerified'];
    isDeleted = json['isDeleted'];
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    firebaseId = json['firebaseId'];
    deviceId = json['deviceId'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAdmin'] = this.isAdmin;
    data['profileImage'] = this.profileImage;
    data['isAgent'] = this.isAgent;
    data['isReachable'] = this.isReachable;
    data['hasPets'] = this.hasPets;
    data['isVerified'] = this.isVerified;
    data['isDeleted'] = this.isDeleted;
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['firebaseId'] = this.firebaseId;
    data['deviceId'] = this.deviceId;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Product {
  bool? inStock;
  List<String>? images;
  String? sId;
  String? agent;
  String? name;
  int? price;
  String? description;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Product(
      {this.inStock,
      this.images,
      this.sId,
      this.agent,
      this.name,
      this.price,
      this.description,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    inStock = json['inStock'];
    images = json['images'].cast<String>();
    sId = json['_id'];
    agent = json['agent'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inStock'] = this.inStock;
    data['images'] = this.images;
    data['_id'] = this.sId;
    data['agent'] = this.agent;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
