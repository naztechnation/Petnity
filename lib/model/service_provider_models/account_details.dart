import '../agent/agent.dart';

class AccountDetailsList {
  bool? status;
  String? message;
  AccountDetailsListData? data;

  AccountDetailsList({this.status, this.message, this.data});

  AccountDetailsList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AccountDetailsListData.fromJson(json['data']) : null;
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

class AccountDetailsListData {
  List<BankDetails>? bankDetails;

  AccountDetailsListData({this.bankDetails});

  AccountDetailsListData.fromJson(Map<String, dynamic> json) {
    if (json['bankDetails'] != null) {
      bankDetails = <BankDetails>[];
      json['bankDetails'].forEach((v) {
        bankDetails!.add(new BankDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bankDetails != null) {
      data['bankDetails'] = this.bankDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankDetails {
  bool? isDefault;
  String? sId;
  Agent? agent;
  String? bank;
  String? bankCode;
  String? accountName;
  int? accountNumber;

  BankDetails(
      {this.isDefault,
      this.sId,
      this.agent,
      this.bank,
      this.bankCode,
      this.accountName,
      this.accountNumber});

  BankDetails.fromJson(Map<String, dynamic> json) {
    isDefault = json['isDefault'];
    sId = json['_id'];
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    bank = json['bank'];
    bankCode = json['bankCode'];
    accountName = json['accountName'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDefault'] = this.isDefault;
    data['_id'] = this.sId;
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    data['bank'] = this.bank;
    data['bankCode'] = this.bankCode;
    data['accountName'] = this.accountName;
    data['accountNumber'] = this.accountNumber;
    return data;
  }
}

