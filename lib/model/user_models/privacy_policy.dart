class PrivacyPolicy {
  bool? status;
  String? message;
  Content? privacyPolicy;

  PrivacyPolicy({this.status, this.message, this.privacyPolicy});

  PrivacyPolicy.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    privacyPolicy = json['privacy_policy'] != null
        ? new Content.fromJson(json['privacy_policy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.privacyPolicy != null) {
      data['privacy_policy'] = this.privacyPolicy!.toJson();
    }
    return data;
  }
}

class Content {
  int? id;
  String? content;

  Content({this.id, this.content});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    return data;
  }
}
