class UserTransactionList {
  bool? status;
  String? message;
  Data? data;

  UserTransactionList({this.status, this.message, this.data});

  UserTransactionList.fromJson(Map<String, dynamic> json) {
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
  List<Transactions>? transactions;

  Data({this.transactions});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? sId;
  String? user;
  String? transactionType;
  int? amount;
  String? transactionId;
  String? transactionStatus;
  String? createdAt;
  String? updatedAt;

  Transactions(
      {this.sId,
      this.user,
      this.transactionType,
      this.amount,
      this.transactionId,
      this.transactionStatus,
      this.createdAt,
      this.updatedAt});

  Transactions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    transactionType = json['transactionType'];
    amount = json['amount'];
    transactionId = json['transactionId'];
    transactionStatus = json['transactionStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['transactionType'] = this.transactionType;
    data['amount'] = this.amount;
    data['transactionId'] = this.transactionId;
    data['transactionStatus'] = this.transactionStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
