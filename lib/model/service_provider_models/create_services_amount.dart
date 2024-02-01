class ServiceAmount {
  bool? status;
  String? message;
  ServiceAmountData? data;

  ServiceAmount({this.status, this.message, this.data});

  ServiceAmount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ServiceAmountData.fromJson(json['data']) : null;
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

class ServiceAmountData {
  Service? service;

  ServiceAmountData({this.service});

  ServiceAmountData.fromJson(Map<String, dynamic> json) {
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class Service {
  bool? isLive;
  String? sId;
  String? serviceType;
  String? agent;
  int? levelsAmount;
  String? createdAt;
  String? updatedAt;

  Service(
      {this.isLive,
      this.sId,
      this.serviceType,
      this.agent,
      this.levelsAmount,
      this.createdAt,
      this.updatedAt});

  Service.fromJson(Map<String, dynamic> json) {
    isLive = json['isLive'];
    sId = json['_id'];
    serviceType = json['serviceType'];
    agent = json['agent'];
    levelsAmount = json['levelsAmount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isLive'] = this.isLive;
    data['_id'] = this.sId;
    data['serviceType'] = this.serviceType;
    data['agent'] = this.agent;
    data['levelsAmount'] = this.levelsAmount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
