import '../agent/agent.dart';

class WithrawalHistory {
  bool? status;
  String? message;
  WithrawalHistoryData? data;

  WithrawalHistory({this.status, this.message, this.data});

  WithrawalHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new WithrawalHistoryData.fromJson(json['data']) : null;
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

class WithrawalHistoryData {
  List<WithdrawalRequests>? withdrawalRequests;

  WithrawalHistoryData({this.withdrawalRequests});

  WithrawalHistoryData.fromJson(Map<String, dynamic> json) {
    if (json['withdrawalRequests'] != null) {
      withdrawalRequests = <WithdrawalRequests>[];
      json['withdrawalRequests'].forEach((v) {
        withdrawalRequests!.add(new WithdrawalRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.withdrawalRequests != null) {
      data['withdrawalRequests'] =
          this.withdrawalRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WithdrawalRequests {
  String? status;
  String? sId;
  Agent? agent;
  int? amount;
  String? createdAt;
  String? updatedAt;

  WithdrawalRequests(
      {this.status,
      this.sId,
      this.agent,
      this.amount,
      this.createdAt,
      this.updatedAt});

  WithdrawalRequests.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    amount = json['amount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

