

import '../agent/agent.dart';

class WithrawalHistory {
  bool? status;
  List<AgentWithdrawals>? agentWithdrawals;

  WithrawalHistory({this.status, this.agentWithdrawals});

  WithrawalHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['agent_withdrawals'] != null) {
      agentWithdrawals = <AgentWithdrawals>[];
      json['agent_withdrawals'].forEach((v) {
        agentWithdrawals!.add(new AgentWithdrawals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.agentWithdrawals != null) {
      data['agent_withdrawals'] =
          this.agentWithdrawals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AgentWithdrawals {
  int? id;
  String? amount;
  String? status;
  String? createdAt;
  String? updatedAt;
  Agent? agent;

  AgentWithdrawals(
      {this.id,
      this.amount,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.agent});

  AgentWithdrawals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    return data;
  }
}

