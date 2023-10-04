class GetServiceTypes {
  bool? status;
  String? message;
  List<ServiceTypes>? serviceTypes;

  GetServiceTypes({this.status, this.message, this.serviceTypes});

  GetServiceTypes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['service_types'] != null) {
      serviceTypes = <ServiceTypes>[];
      json['service_types'].forEach((v) {
        serviceTypes!.add(new ServiceTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.serviceTypes != null) {
      data['service_types'] =
          this.serviceTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceTypes {
  int? id;
  String? name;

  ServiceTypes({this.id, this.name});

  ServiceTypes.fromJson(Map<String, dynamic> json) {
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
