class CreateVetServices {
  bool? status;
  String? message;
  VetService? vetService;

  CreateVetServices({this.status, this.message, this.vetService});

  CreateVetServices.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vetService = json['vet_service'] != null
        ? new VetService.fromJson(json['vet_service'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.vetService != null) {
      data['vet_service'] = this.vetService!.toJson();
    }
    return data;
  }
}

class VetService {
  int? id;
  String? price;
  bool? isLive;
  String? createdAt;
  String? updatedAt;
  ServiceType? serviceType;
  int? agent;
  List<SessionTypes>? sessionTypes;
  List<SessionTypes>? contactMediums;

  VetService(
      {this.id,
      this.price,
      this.isLive,
      this.createdAt,
      this.updatedAt,
      this.serviceType,
      this.agent,
      this.sessionTypes,
      this.contactMediums});

  VetService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    isLive = json['is_live'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    serviceType = json['service_type'] != null
        ? new ServiceType.fromJson(json['service_type'])
        : null;
    agent = json['agent'];
    if (json['session_types'] != null) {
      sessionTypes = <SessionTypes>[];
      json['session_types'].forEach((v) {
        sessionTypes!.add(new SessionTypes.fromJson(v));
      });
    }
    if (json['contact_mediums'] != null) {
      contactMediums = <SessionTypes>[];
      json['contact_mediums'].forEach((v) {
        contactMediums!.add(new SessionTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['is_live'] = this.isLive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.serviceType != null) {
      data['service_type'] = this.serviceType!.toJson();
    }
    data['agent'] = this.agent;
    if (this.sessionTypes != null) {
      data['session_types'] =
          this.sessionTypes!.map((v) => v.toJson()).toList();
    }
    if (this.contactMediums != null) {
      data['contact_mediums'] =
          this.contactMediums!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceType {
  int? id;
  String? name;
  String? image;

  ServiceType({this.id, this.name, this.image});

  ServiceType.fromJson(Map<String, dynamic> json) {
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

class SessionTypes {
  int? id;
  String? name;

  SessionTypes({this.id, this.name});

  SessionTypes.fromJson(Map<String, dynamic> json) {
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
