class GetReviews {
  bool? status;
  List<Reviews>? reviews;

  GetReviews({this.status, this.reviews});

  GetReviews.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  int? id;
  int? rating;
  String? comment;
  String? createdAt;
  String? updatedAt;
  int? agent;
  int? profile;

  Reviews(
      {this.id,
      this.rating,
      this.comment,
      this.createdAt,
      this.updatedAt,
      this.agent,
      this.profile});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    agent = json['agent'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['agent'] = this.agent;
    data['profile'] = this.profile;
    return data;
  }
}
