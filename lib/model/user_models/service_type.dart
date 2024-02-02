class ServiceType {
  String? sId;
  String? name;
  String? image;
  int? iV;

  ServiceType({this.sId, this.name, this.image, this.iV});

  ServiceType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['__v'] = this.iV;
    return data;
  }
}


