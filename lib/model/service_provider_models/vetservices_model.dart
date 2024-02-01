import '../user_models/vet_service.dart';

class VetServices {
  bool? status;
  String? message;
  VetServicesData? data;

  VetServices({this.status, this.message, this.data});

  VetServices.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new VetServicesData.fromJson(json['data']) : null;
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

class VetServicesData {
  VetService? vetService;

  VetServicesData({this.vetService});

  VetServicesData.fromJson(Map<String, dynamic> json) {
    vetService = json['vetService'] != null
        ? new VetService.fromJson(json['vetService'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vetService != null) {
      data['vetService'] = this.vetService!.toJson();
    }
    return data;
  }
}

