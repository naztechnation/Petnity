


class Service {
  int? id;
  int? levelsAmount;
  bool? isLive;
  String? createdAt;
  String? updatedAt;
  Services? serviceType;
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
        ? new Services.fromJson(json['service_type'])
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

class Services {
  int? id;
  String? name;
  String? image;

  Services({this.id, this.name, this.image});

  Services.fromJson(Map<String, dynamic> json) {
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