import 'package:TheSpecialParty/models/productmodel.dart';

class FavoriteModel {
  Favorites favorites;

  FavoriteModel({this.favorites});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    favorites = json['favorites'] != null
        ? new Favorites.fromJson(json['favorites'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.favorites != null) {
      data['favorites'] = this.favorites.toJson();
    }
    return data;
  }
}

class Favorites {
  int currentPage;
  List<FavoriteData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  Null nextPageUrl;
  String path;
  int perPage;
  Null prevPageUrl;
  int to;
  int total;

  Favorites(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Favorites.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<FavoriteData>();
      json['data'].forEach((v) {
        data.add(new FavoriteData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class FavoriteData {
  int id;
  String productId;
  String userId;
  ProductData product;

  FavoriteData({this.id, this.productId, this.userId, this.product});

  FavoriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    product =
        json['product'] != null ? new ProductData.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    if (this.product != null) {
      data['product'] = this.product;
    }
    return data;
  }
}

class Product {
  int id;
  String name;
  String description;
  String length;
  String width;
  String sale;
  String code;
  String price;
  String imageHeader;
  bool favorite;
  List<Images> images;

  Product(
      {this.id,
      this.name,
      this.description,
      this.length,
      this.width,
      this.sale,
      this.code,
      this.price,
      this.imageHeader,
      this.favorite,
      this.images});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    length = json['length'];
    width = json['width'];
    sale = json['sale'];
    code = json['code'];
    price = json['price'];
    imageHeader = json['image_header'];
    favorite = json['favorite'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['length'] = this.length;
    data['width'] = this.width;
    data['sale'] = this.sale;
    data['code'] = this.code;
    data['price'] = this.price;
    data['image_header'] = this.imageHeader;
    data['favorite'] = this.favorite;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String image;

  Images({this.image});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}