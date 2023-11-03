class ShoppingList {
  bool? status;
  String? message;
  bool? hasNext;
  bool? hasPrevious;
  int? numPages;
  int? currentPage;
  List<Products>? products;

  ShoppingList(
      {this.status,
      this.message,
      this.hasNext,
      this.hasPrevious,
      this.numPages,
      this.currentPage,
      this.products});

  ShoppingList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    hasNext = json['has_next'];
    hasPrevious = json['has_previous'];
    numPages = json['num_pages'];
    currentPage = json['current_page'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['has_next'] = this.hasNext;
    data['has_previous'] = this.hasPrevious;
    data['num_pages'] = this.numPages;
    data['current_page'] = this.currentPage;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? price;
  bool? inStock;
  String? image;
  String? description;
  String? createdAt;
  String? updatedAt;
  Agent? agent;

  Products(
      {this.id,
      this.name,
      this.price,
      this.inStock,
      this.image,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.agent});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    inStock = json['in_stock'];
    image = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['in_stock'] = this.inStock;
    data['image'] = this.image;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    return data;
  }
}

class Agent {
  int? id;
  String? name;
  String? gender;
  String? dateOfBirth;
  String? about;
  String? picture;
  String? country;
  String? city;
  String? idPhoto;
  bool? isVerified;
  bool? isReachable;
  String? createdAt;
  String? updatedAt;
  Profile? profile;
  Null? idType;
  List<Services>? services;
  List<PetTypes>? petTypes;

  Agent(
      {this.id,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.about,
      this.picture,
      this.country,
      this.city,
      this.idPhoto,
      this.isVerified,
      this.isReachable,
      this.createdAt,
      this.updatedAt,
      this.profile,
      this.idType,
      this.services,
      this.petTypes});

  Agent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    about = json['about'];
    picture = json['picture'];
    country = json['country'];
    city = json['city'];
    idPhoto = json['id_photo'];
    isVerified = json['is_verified'];
    isReachable = json['is_reachable'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    idType = json['id_type'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['pet_types'] != null) {
      petTypes = <PetTypes>[];
      json['pet_types'].forEach((v) {
        petTypes!.add(new PetTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['about'] = this.about;
    data['picture'] = this.picture;
    data['country'] = this.country;
    data['city'] = this.city;
    data['id_photo'] = this.idPhoto;
    data['is_verified'] = this.isVerified;
    data['is_reachable'] = this.isReachable;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['id_type'] = this.idType;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.petTypes != null) {
      data['pet_types'] = this.petTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profile {
  int? id;
  String? firebaseId;
  String? phoneNumber;
  Null? address;
  Null? city;
  Null? country;
  Null? profileImage;
  bool? isAgent;
  bool? isReachable;
  bool? isVerified;
  bool? hasPets;
  String? createdAt;
  String? updatedAt;
  User? user;

  Profile(
      {this.id,
      this.firebaseId,
      this.phoneNumber,
      this.address,
      this.city,
      this.country,
      this.profileImage,
      this.isAgent,
      this.isReachable,
      this.isVerified,
      this.hasPets,
      this.createdAt,
      this.updatedAt,
      this.user});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firebaseId = json['firebase_id'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    profileImage = json['profile_image'];
    isAgent = json['is_agent'];
    isReachable = json['is_reachable'];
    isVerified = json['is_verified'];
    hasPets = json['has_pets'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firebase_id'] = this.firebaseId;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['profile_image'] = this.profileImage;
    data['is_agent'] = this.isAgent;
    data['is_reachable'] = this.isReachable;
    data['is_verified'] = this.isVerified;
    data['has_pets'] = this.hasPets;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;

  User({this.id, this.username, this.email, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class Services {
  int? id;
  String? name;
  Null? image;

  Services({this.id, this.name, this.image});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class PetTypes {
  int? id;
  String? name;

  PetTypes({this.id, this.name});

  PetTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
