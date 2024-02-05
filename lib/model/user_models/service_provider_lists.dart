import '../pet_types.dart/pet_types.dart';
import '../user/user.dart';
import 'service_type.dart';


class ServiceProvidersList {
  bool? status;
  String? message;
  ServiceProvidersListData? data;

  ServiceProvidersList({this.status, this.message, this.data});

  ServiceProvidersList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ServiceProvidersListData.fromJson(json['data']) : null;
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

class ServiceProvidersListData {
  List<ServiceType>? services;
  List<PetTypes>? petTypes;
  bool? isVerified;
  bool? isReachable;
  String? sId;
  User? user;

  ServiceProvidersListData(
      {this.services,
      this.petTypes,
      this.isVerified,
      this.isReachable,
      this.sId,
      this.user});

  ServiceProvidersListData.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <ServiceType>[];
      json['services'].forEach((v) {
        services!.add(new ServiceType.fromJson(v));
      });
    }
    if (json['petTypes'] != null) {
      petTypes = <PetTypes>[];
      json['petTypes'].forEach((v) {
         petTypes!.add(new PetTypes.fromJson(v));
      });
    }
    isVerified = json['isVerified'];
    isReachable = json['isReachable'];
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.petTypes != null) {
       data['petTypes'] = this.petTypes!.map((v) => v.toJson()).toList();
    }
    data['isVerified'] = this.isVerified;
    data['isReachable'] = this.isReachable;
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

