

class CreditedWallet {
  bool? status;
  String? message;
  CreditedWalletData? data;
  Error? error;

  CreditedWallet({this.status, this.message, this.data});

  CreditedWallet.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
    data = json['data'] != null ? new CreditedWalletData.fromJson(json['data']) : null;
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

class CreditedWalletData {
  UserWallet? userWallet;

  CreditedWalletData({this.userWallet});

  CreditedWalletData.fromJson(Map<String, dynamic> json) {
    userWallet = json['userWallet'] != null
        ? new UserWallet.fromJson(json['userWallet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userWallet != null) {
      data['userWallet'] = this.userWallet!.toJson();
    }
    return data;
  }
}

class UserWallet {
  int? balance;
  String? sId;
  String? user;

  UserWallet({this.balance, this.sId, this.user});

  UserWallet.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    sId = json['_id'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['_id'] = this.sId;
    data['user'] = this.user;
    return data;
  }
}


class Error {
  String? status;
  String? message;
  dynamic data;

  Error({this.status, this.message, this.data});

  Error.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}