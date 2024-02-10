class GetAgentsPackages {
  bool? status;
  String? message;
  GetAgentsPackagesData? data;

  GetAgentsPackages({this.status, this.message, this.data});

  GetAgentsPackages.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new GetAgentsPackagesData.fromJson(json['data']) : null;
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

class GetAgentsPackagesData {
  List<Packages>? packages;

  GetAgentsPackagesData({this.packages});

  GetAgentsPackagesData.fromJson(Map<String, dynamic> json) {
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(new Packages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.packages != null) {
      data['packages'] = this.packages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Packages {
  String? sId;
  Service? service;
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
        json['service'] != null ? new Service.fromJson(json['service']) : null;
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

class Service {
  String? sId;
  String? agent;

  Service({this.sId, this.agent});

  Service.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    agent = json['agent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['agent'] = this.agent;
    return data;
  }
}
