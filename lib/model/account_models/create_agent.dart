 

import '../agent/agent.dart';

class CreateAgents {
  bool? status;
  String? message;
  Agent? agent;

  CreateAgents({this.status, this.message, this.agent});

  CreateAgents.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    return data;
  }
}

