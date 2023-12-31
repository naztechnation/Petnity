


import 'package:petnity/model/agent/agent.dart';

class Product {
  int? id;
  String? name;
  String? price;
  bool? inStock;
  String? image;
  String? description;
  String? createdAt;
  String? updatedAt;
  Agent? agent;

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
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
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
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    return data;
  }
}