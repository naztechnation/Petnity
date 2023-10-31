class GetAgentsPackages {
  bool? status;
  List<Packages>? packages;

  GetAgentsPackages({this.status, this.packages});

  GetAgentsPackages.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(new Packages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.packages != null) {
      data['packages'] = this.packages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Packages {
  int? id;
  int? level;
  String? name;
  String? description;
  String? duration;
  String? price;
  String? createdAt;
  String? updatedAt;
  Service? service;

  Packages(
      {this.id,
      this.level,
      this.name,
      this.description,
      this.duration,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.service});

  Packages.fromJson(Map<String, dynamic> json) {
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

class Service {
  int? id;
  int? levelsAmount;
  bool? isLive;
  String? createdAt;
  String? updatedAt;
  ServiceType? serviceType;
  int? agent;

  Service(
      {this.id,
      this.levelsAmount,
      this.isLive,
      this.createdAt,
      this.updatedAt,
      this.serviceType,
      this.agent});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    levelsAmount = json['levels_amount'];
    isLive = json['is_live'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    serviceType = json['service_type'] != null
        ? new ServiceType.fromJson(json['service_type'])
        : null;
    agent = json['agent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['levels_amount'] = this.levelsAmount;
    data['is_live'] = this.isLive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.serviceType != null) {
      data['service_type'] = this.serviceType!.toJson();
    }
    data['agent'] = this.agent;
    return data;
  }
}

class ServiceType {
  int? id;
  String? name;
  String? image;

  ServiceType({this.id, this.name, this.image});

  ServiceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
