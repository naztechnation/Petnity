import 'package:petnity/model/agent/agent.dart';

class CreateAgents {
  bool? status;
  String? message;
  CreateAgentsData? data;

  CreateAgents({this.status, this.message, this.data});

  CreateAgents.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CreateAgentsData.fromJson(json['data']) : null;
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

class CreateAgentsData {
  Agent? agent;
  String? token;

  CreateAgentsData({this.agent, this.token});

  CreateAgentsData.fromJson(Map<String, dynamic> json) {
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

