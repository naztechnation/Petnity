

class Notifications {
  bool? status;
  String? message;
  List<NotificationsList>? notifications;

  Notifications({this.status, this.message, this.notifications});

  Notifications.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['notifications'] != null) {
      notifications = <NotificationsList>[];
      json['notifications'].forEach((v) {
        notifications!.add(new NotificationsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationsList {
  int? id;
  String? title;
  String? body;
  bool? isRead;
  String? createdAt;
  String? updatedAt;
  int? profile;

  NotificationsList(
      {this.id,
      this.title,
      this.body,
      this.isRead,
      this.createdAt,
      this.updatedAt,
      this.profile});

  NotificationsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile'] = this.profile;
    return data;
  }
}
