import '../session_types/session_types.dart';

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
    sessionTypes = json['sessionTypes'].cast<String>();
    contactMediums = json['contactMediums'].cast<String>();
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
    data['sessionTypes'] = this.sessionTypes;
    data['contactMediums'] = this.contactMediums;
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
