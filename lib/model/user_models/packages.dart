import '../services/services.dart';

class Packages {
  String? sId;
  Services? service;
  int? level;
  String? name;
  String? description;
  int? price;
  String? duration;
  String? createdAt;
  String? updatedAt;

  Packages(
      {this.sId,
      this.service,
      this.level,
      this.name,
      this.description,
      this.price,
      this.duration,
      this.createdAt,
      this.updatedAt});

  Packages.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    service =
        json['service'] != null ? new Services.fromJson(json['service']) : null;
    level = json['level'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    duration = json['duration'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['level'] = this.level;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}