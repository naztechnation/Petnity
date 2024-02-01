class Package {
  String? sId;
  String? service;
  int? level;
  String? name;
  String? description;
  int? price;
  String? duration;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Package(
      {this.sId,
      this.service,
      this.level,
      this.name,
      this.description,
      this.price,
      this.duration,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Package.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    service = json['service'];
    level = json['level'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    duration = json['duration'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['service'] = this.service;
    data['level'] = this.level;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}


