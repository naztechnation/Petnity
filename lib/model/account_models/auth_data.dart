
import '../agent/agent.dart';
import '../profile/profile.dart';

class AuthData {
  bool? status;
  var message;
  bool? isAgent;
  Profile? profile;

  Agent? agent;

  AuthData({this.status, this.message, this.isAgent, this.agent});

  AuthData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    isAgent = json['is_agent'];

    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['is_agent'] = this.isAgent;
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    return data;
  }
}

