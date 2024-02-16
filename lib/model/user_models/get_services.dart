import '../agent/agent.dart';
import '../service_provider_models/vetservices_model.dart';
import '../services/services.dart';
import '../session_types/session_types.dart';
import 'service_type.dart';

class GetServices {
  bool? status;
  String? message;
  GetServicesData? data;

  GetServices({this.status, this.message, this.data});

  GetServices.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new GetServicesData.fromJson(json['data']) : null;
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

class GetServicesData {
  List<Services>? services;
  List<VetServices>? vetServices;

  GetServicesData({this.services, this.vetServices});

  GetServicesData.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['vetServices'] != null) {
      vetServices = <VetServices>[];
      json['vetServices'].forEach((v) {
        vetServices!.add(new VetServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.vetServices != null) {
      data['vetServices'] = this.vetServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VetServices {
  List<SessionTypes>? sessionTypes;
  List<SessionTypes>? contactMediums;
  bool? isLive;
  String? sId;
  ServiceType? serviceType;
  Agent? agent;
  int? price;
  String? createdAt;
  String? updatedAt;

  VetServices(
      {this.sessionTypes,
      this.contactMediums,
      this.isLive,
      this.sId,
      this.serviceType,
      this.agent,
      this.price,
      this.createdAt,
      this.updatedAt});

  VetServices.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}