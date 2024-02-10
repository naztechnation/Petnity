class CreateWithrawal {
  bool? status;
  String? message;
  CreateWithrawalData? data;

  CreateWithrawal({this.status, this.message, this.data});

  CreateWithrawal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CreateWithrawalData.fromJson(json['data']) : null;
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

class CreateWithrawalData {
  Withdrawal? withdrawal;

  CreateWithrawalData({this.withdrawal});

  CreateWithrawalData.fromJson(Map<String, dynamic> json) {
    withdrawal = json['withdrawal'] != null
        ? new Withdrawal.fromJson(json['withdrawal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.withdrawal != null) {
      data['withdrawal'] = this.withdrawal!.toJson();
    }
    return data;
  }
}

class Withdrawal {
  String? status;
  String? sId;
  String? agent;
  int? amount;
  String? createdAt;
  String? updatedAt;

  Withdrawal(
      {this.status,
      this.sId,
      this.agent,
      this.amount,
      this.createdAt,
      this.updatedAt});

  Withdrawal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    agent = json['agent'];
    amount = json['amount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['agent'] = this.agent;
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
