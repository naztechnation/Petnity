class PrivacyPolicies {
  bool? status;
  String? message;
  PrivacyPoliciesData? data;

  PrivacyPolicies({this.status, this.message, this.data});

  PrivacyPolicies.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new PrivacyPoliciesData.fromJson(json['data']) : null;
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

class PrivacyPoliciesData {
  PrivacyPolicy? privacyPolicy;

  PrivacyPoliciesData({this.privacyPolicy});

  PrivacyPoliciesData.fromJson(Map<String, dynamic> json) {
    privacyPolicy = json['privacyPolicy'] != null
        ? new PrivacyPolicy.fromJson(json['privacyPolicy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.privacyPolicy != null) {
      data['privacyPolicy'] = this.privacyPolicy!.toJson();
    }
    return data;
  }
}

class PrivacyPolicy {
  String? sId;
  String? content;

  PrivacyPolicy({this.sId, this.content});

  PrivacyPolicy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['content'] = this.content;
    return data;
  }
}
