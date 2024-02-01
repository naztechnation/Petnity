class GalleryAgents {
  bool? status;
  String? message;
  GalleryAgentsData? data;

  GalleryAgents({this.status, this.message, this.data});

  GalleryAgents.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new GalleryAgentsData.fromJson(json['data']) : null;
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

class GalleryAgentsData {
  List<GalleryElements>? galleryElements;

  GalleryAgentsData({this.galleryElements});

  GalleryAgentsData.fromJson(Map<String, dynamic> json) {
    if (json['galleryElements'] != null) {
      galleryElements = <GalleryElements>[];
      json['galleryElements'].forEach((v) {
        galleryElements!.add(new GalleryElements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.galleryElements != null) {
      data['galleryElements'] =
          this.galleryElements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GalleryElements {
  String? sId;
  String? agent;
  String? image;
  String? createdAt;
  String? updatedAt;

  GalleryElements(
      {this.sId, this.agent, this.image, this.createdAt, this.updatedAt});

  GalleryElements.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    agent = json['agent'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['agent'] = this.agent;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
