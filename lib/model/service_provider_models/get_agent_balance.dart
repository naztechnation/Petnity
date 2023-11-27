class AgentBalance {
  bool? status;
  num? balance;

  AgentBalance({this.status, this.balance});

  AgentBalance.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['balance'] = this.balance;
    return data;
  }
}
