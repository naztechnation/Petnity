

import '../agent/agent.dart';

class CreateWithrawal {
  bool? status;
  String? message;
  AgentWithdrawal? agentWithdrawal;

  CreateWithrawal({this.status, this.message, this.agentWithdrawal});

  CreateWithrawal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    agentWithdrawal = json['agent_withdrawal'] != null
        ? new AgentWithdrawal.fromJson(json['agent_withdrawal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.agentWithdrawal != null) {
      data['agent_withdrawal'] = this.agentWithdrawal!.toJson();
    }
    return data;
  }
}

class AgentWithdrawal {
  int? id;
  String? amount;
  String? status;
  String? createdAt;
  String? updatedAt;
  Agent? agent;

  AgentWithdrawal(
      {this.id,
      this.amount,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.agent});

  AgentWithdrawal.fromJson(Map<String, dynamic> json) {
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

