class HealthIssues {
  String? sId;
  String? pet;
  String? name;
  String? drug;
  String? prescription;
  String? createdAt;
  String? updatedAt;
  int? iV;

  HealthIssues(
      {this.sId,
      this.pet,
      this.name,
      this.drug,
      this.prescription,
      this.createdAt,
      this.updatedAt,
      this.iV});

  HealthIssues.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    pet = json['pet'];
    name = json['name'];
    drug = json['drug'];
    prescription = json['prescription'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['pet'] = this.pet;
    data['name'] = this.name;
    data['drug'] = this.drug;
    data['prescription'] = this.prescription;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
