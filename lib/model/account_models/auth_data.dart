

class AuthData{
  bool? status;
  var message;
  bool? isAgent;

  AuthData({this.status,this.message, this.isAgent});

  AuthData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    isAgent = json['is_agent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['is_agent'] = this.isAgent;
    return data;
  }
}
