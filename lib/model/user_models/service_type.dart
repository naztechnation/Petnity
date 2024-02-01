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
  List<ServiceTypes>? serviceTypes;

  GetServiceTypesData({this.serviceTypes});

  GetServiceTypesData.fromJson(Map<String, dynamic> json) {
    if (json['serviceTypes'] != null) {
      serviceTypes = <ServiceTypes>[];
      json['serviceTypes'].forEach((v) {
        serviceTypes!.add(new ServiceTypes.fromJson(v));
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

class ServiceTypes {
  String? sId;
  String? name;
  String? image;

  ServiceTypes({this.sId, this.name, this.image});

  ServiceTypes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
