import '../agent/agent.dart';
import '../session_types/session_types.dart';
import 'service_type.dart';

class VetService {
  List<SessionTypes>? sessionTypes;
  List<SessionTypes>? contactMediums;
  bool? isLive;
  String? sId;
  ServiceType? serviceType;
  Agent? agent;
  int? price;
  String? createdAt;
  String? updatedAt;
  int? iV;

  VetService(
      {this.sessionTypes,
      this.contactMediums,
      this.isLive,
      this.sId,
      this.serviceType,
      this.agent,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.iV});

  VetService.fromJson(Map<String, dynamic> json) {
    if (json['sessionTypes'] != null) {
      sessionTypes = <SessionTypes>[];
      json['sessionTypes'].forEach((v) {
        sessionTypes!.add(new SessionTypes.fromJson(v));
      });
    }
    if (json['contactMediums'] != null) {
      contactMediums = <SessionTypes>[];
      json['contactMediums'].forEach((v) {
        contactMediums!.add(new SessionTypes.fromJson(v));
      });
    }
    isLive = json['isLive'];
    sId = json['_id'];
    serviceType = json['serviceType'] != null
        ? new ServiceType.fromJson(json['serviceType'])
        : null;
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sessionTypes != null) {
      data['sessionTypes'] = this.sessionTypes!.map((v) => v.toJson()).toList();
    }
    if (this.contactMediums != null) {
      data['contactMediums'] =
          this.contactMediums!.map((v) => v.toJson()).toList();
    }
    data['isLive'] = this.isLive;
    data['_id'] = this.sId;
    if (this.serviceType != null) {
      data['serviceType'] = this.serviceType!.toJson();
    }
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    data['price'] = this.price;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
