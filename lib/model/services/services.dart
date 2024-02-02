import '../agent/agent.dart';
import '../user_models/service_type.dart';

class Services {
  bool? isLive;
  String? sId;
  ServiceType? serviceType;
  Agent? agent;
  int? levelsAmount;
  String? createdAt;
  String? updatedAt;

  Services(
      {this.isLive,
      this.sId,
      this.serviceType,
      this.agent,
      this.levelsAmount,
      this.createdAt,
      this.updatedAt});

  Services.fromJson(Map<String, dynamic> json) {
    isLive = json['isLive'];
    sId = json['_id'];
    serviceType = json['serviceType'] != null
        ? new ServiceType.fromJson(json['serviceType'])
        : null;
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    levelsAmount = json['levelsAmount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isLive'] = this.isLive;
    data['_id'] = this.sId;
    if (this.serviceType != null) {
      data['serviceType'] = this.serviceType!.toJson();
    }
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    data['levelsAmount'] = this.levelsAmount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

