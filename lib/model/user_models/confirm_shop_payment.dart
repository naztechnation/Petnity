

class ConfirmShopPayment {
  bool? status;
  String? message;
  ShopOrder? shopOrder;

  ConfirmShopPayment({this.status, this.message, this.shopOrder});

  ConfirmShopPayment.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    shopOrder = json['shop_order'] != null
        ? new ShopOrder.fromJson(json['shop_order'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.shopOrder != null) {
      data['shop_order'] = this.shopOrder!.toJson();
    }
    return data;
  }
}

class ShopOrder {
  int? id;
  int? quantity;
  String? total;
  String? paymentId;
  bool? isPaid;
  bool? isDelivered;
  String? createdAt;
  String? updatedAt;
  int? profile;
  int? agent;
  Product? product;

  ShopOrder(
      {this.id,
      this.quantity,
      this.total,
      this.paymentId,
      this.isPaid,
      this.isDelivered,
      this.createdAt,
      this.updatedAt,
      this.profile,
      this.agent,
      this.product});

  ShopOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    total = json['total'];
    paymentId = json['payment_id'];
    isPaid = json['is_paid'];
    isDelivered = json['is_delivered'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profile = json['profile'];
    agent = json['agent'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['payment_id'] = this.paymentId;
    data['is_paid'] = this.isPaid;
    data['is_delivered'] = this.isDelivered;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile'] = this.profile;
    data['agent'] = this.agent;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? price;
  bool? inStock;
  String? image;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? agent;

  Product(
      {this.id,
      this.name,
      this.price,
      this.inStock,
      this.image,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.agent});

  Product.fromJson(Map<String, dynamic> json) {
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
