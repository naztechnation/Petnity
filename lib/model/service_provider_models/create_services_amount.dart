

class ServiceAmount {
  bool? status;
  String? message;
  Service? service;

  ServiceAmount({this.status, this.message, this.service});

  ServiceAmount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
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

  ServiceType({this.id, this.name});

  ServiceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
