import '../agent/agent.dart';

class ServiceProvidersList {
  bool? status;
  List<Agent>? agents;

  ServiceProvidersList({this.status, this.agents});

  ServiceProvidersList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['agents'] != null) {
      agents = <Agent>[];
      json['agents'].forEach((v) {
        agents!.add(new Agent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.agents != null) {
      data['agents'] = this.agents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class ServicesDetails {
  int? id;
  String? name;
  String? image;

  ServicesDetails({this.id, this.name, this.image});

  ServicesDetails.fromJson(Map<String, dynamic> json) {
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

class Pets {
  int? id;
  String? name;

  Pets({this.id, this.name});

  Pets.fromJson(Map<String, dynamic> json) {
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
