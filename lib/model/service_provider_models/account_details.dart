class AccountDetailsList {
  bool? status;
  List<AgentBankDetails>? agentBankDetails;

  AccountDetailsList({this.status, this.agentBankDetails});

  AccountDetailsList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['agent_bank_details'] != null) {
      agentBankDetails = <AgentBankDetails>[];
      json['agent_bank_details'].forEach((v) {
        agentBankDetails!.add(new AgentBankDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.agentBankDetails != null) {
      data['agent_bank_details'] =
          this.agentBankDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AgentBankDetails {
  int? id;
  String? bank;
  String? accountName;
  String? accountNumber;
  bool? idDefault;
  String? createdAt;
  String? updatedAt;
  int? agent;

  AgentBankDetails(
      {this.id,
      this.bank,
      this.accountName,
      this.accountNumber,
      this.idDefault,
      this.createdAt,
      this.updatedAt,
      this.agent});

  AgentBankDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bank = json['bank'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    idDefault = json['id_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    agent = json['agent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank'] = this.bank;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['id_default'] = this.idDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['agent'] = this.agent;
    return data;
  }
}
