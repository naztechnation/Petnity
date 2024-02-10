

class AddBank {
  bool? status;
  String? message;
  Data? data;

  AddBank({this.status, this.message, this.data});

  AddBank.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  BankDetails? bankDetails;

  Data({this.bankDetails});

  Data.fromJson(Map<String, dynamic> json) {
    bankDetails = json['bankDetails'] != null
        ? new BankDetails.fromJson(json['bankDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bankDetails != null) {
      data['bankDetails'] = this.bankDetails!.toJson();
    }
    return data;
  }
}

class BankDetails {
  bool? isDefault;
  String? sId;
  String? agent;
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
    agent = json['agent'];
    bank = json['bank'];
    bankCode = json['bankCode'];
    accountName = json['accountName'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDefault'] = this.isDefault;
    data['_id'] = this.sId;
    data['agent'] = this.agent;
    data['bank'] = this.bank;
    data['bankCode'] = this.bankCode;
    data['accountName'] = this.accountName;
    data['accountNumber'] = this.accountNumber;
    return data;
  }
}
