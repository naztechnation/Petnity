import '../services/services.dart';

class Package {
  int? id;
  int? level;
  String? name;
  String? description;
  String? duration;
  String? price;
  String? createdAt;
  String? updatedAt;
  Service? service;

  Package(
      {this.id,
      this.level,
      this.name,
      this.description,
      this.duration,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.service});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    name = json['name'];
    description = json['description'];
    duration = json['duration'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['level'] = this.level;
    data['name'] = this.name;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}