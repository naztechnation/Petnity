import '../agent/agent.dart';

class   Products {
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

  Products(
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

  Products.fromJson(Map<String, dynamic> json) {
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
    data['agent'] = this.agent;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
