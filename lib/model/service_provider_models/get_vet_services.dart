class CreateVetServices {
  bool? status;
  String? message;
  CreateVetServicesData? data;

  CreateVetServices({this.status, this.message, this.data});

  CreateVetServices.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CreateVetServicesData.fromJson(json['data']) : null;
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

class CreateVetServicesData {
  VetService? vetService;

  CreateVetServicesData({this.vetService});

  CreateVetServicesData.fromJson(Map<String, dynamic> json) {
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

class VetService {
  List<SessionTypes>? sessionTypes;
  List<SessionTypes>? contactMediums;
  bool? isLive;
  String? sId;
  String? serviceType;
  String? agent;
  int? price;
  String? createdAt;
  String? updatedAt;

  VetService(
      {this.sessionTypes,
      this.contactMediums,
      this.isLive,
      this.sId,
      this.serviceType,
      this.agent,
      this.price,
      this.createdAt,
      this.updatedAt});

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
    serviceType = json['serviceType'];
    agent = json['agent'];
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
    data['serviceType'] = this.serviceType;
    data['agent'] = this.agent;
    data['price'] = this.price;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class SessionTypes {
  String? sId;
  String? name;
  int? iV;

  SessionTypes({this.sId, this.name, this.iV});

  SessionTypes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['__v'] = this.iV;
    return data;
  }
}
