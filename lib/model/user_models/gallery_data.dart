class GalleryAgents {
  bool? status;
  List<GalleryElements>? galleryElements;

  GalleryAgents({this.status, this.galleryElements});

  GalleryAgents.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['gallery_elements'] != null) {
      galleryElements = <GalleryElements>[];
      json['gallery_elements'].forEach((v) {
        galleryElements!.add(new GalleryElements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.galleryElements != null) {
      data['gallery_elements'] =
          this.galleryElements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GalleryElements {
  int? id;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? agent;

  GalleryElements(
      {this.id, this.image, this.createdAt, this.updatedAt, this.agent});

  GalleryElements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    agent = json['agent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['agent'] = this.agent;
    return data;
  }
}
