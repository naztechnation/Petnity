import 'package:petnity/model/user_models/service_type.dart';

class GetServiceTypes {
  bool? status;
  String? message;
  GetServiceTypesData? data;

  GetServiceTypes({this.status, this.message, this.data});

  GetServiceTypes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new GetServiceTypesData.fromJson(json['data']) : null;
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

class GetServiceTypesData {
  List<ServiceType>? serviceTypes;

  GetServiceTypesData({this.serviceTypes});

  GetServiceTypesData.fromJson(Map<String, dynamic> json) {
    if (json['serviceTypes'] != null) {
      serviceTypes = <ServiceType>[];
      json['serviceTypes'].forEach((v) {
        serviceTypes!.add(new ServiceType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceTypes != null) {
      data['serviceTypes'] = this.serviceTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

