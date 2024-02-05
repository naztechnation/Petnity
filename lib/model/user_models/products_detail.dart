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
  Productss? product;

  ProductDetailsData({this.product});

  ProductDetailsData.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Productss.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Productss {
  bool? inStock;
  List<String>? images;
  String? sId;
  Agent? agent;
  String? name;
  int? price;
  String? description;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  Productss(
      {this.inStock,
      this.images,
      this.sId,
      this.agent,
      this.name,
      this.price,
      this.description,
      this.quantity,
      this.createdAt,
      this.updatedAt});

  Productss.fromJson(Map<String, dynamic> json) {
    inStock = json['inStock'];
    images = json['images'].cast<String>();
    sId = json['_id'];
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    name = json['name'];
    price = json['price'];
    description = json['description'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inStock'] = this.inStock;
    data['images'] = this.images;
    data['_id'] = this.sId;
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Agent {
  List<String>? services;
  List<String>? petTypes;
  bool? isVerified;
  bool? isReachable;
  String? sId;
  String? user;
  String? name;
  String? gender;
  String? dateOfBirth;
  String? about;
  String? picture;
  String? country;
  String? city;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? idPhoto;
  String? idType;

  Agent(
      {this.services,
      this.petTypes,
      this.isVerified,
      this.isReachable,
      this.sId,
      this.user,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.about,
      this.picture,
      this.country,
      this.city,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.idPhoto,
      this.idType});

  Agent.fromJson(Map<String, dynamic> json) {
    services = json['services'].cast<String>();
    petTypes = json['petTypes'].cast<String>();
    isVerified = json['isVerified'];
    isReachable = json['isReachable'];
    sId = json['_id'];
    user = json['user'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    about = json['about'];
    picture = json['picture'];
    country = json['country'];
    city = json['city'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    idPhoto = json['idPhoto'];
    idType = json['idType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['services'] = this.services;
    data['petTypes'] = this.petTypes;
    data['isVerified'] = this.isVerified;
    data['isReachable'] = this.isReachable;
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['about'] = this.about;
    data['picture'] = this.picture;
    data['country'] = this.country;
    data['city'] = this.city;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['idPhoto'] = this.idPhoto;
    data['idType'] = this.idType;
    return data;
  }
}
