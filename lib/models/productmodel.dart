class GetCategoryDetails {
  List<ProductsMost> productsMost;
  AllProducts products;

  GetCategoryDetails({this.productsMost, this.products});

  GetCategoryDetails.fromJson(Map<String, dynamic> json) {
    if (json['products_most'] != null) {
      productsMost = new List<ProductsMost>();
      json['products_most'].forEach((v) {
        productsMost.add(new ProductsMost.fromJson(v));
      });
    }
    products = json['products'] != null
        ? new AllProducts.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productsMost != null) {
      data['products_most'] = this.productsMost.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products.toJson();
    }
    return data;
  }
}

class ProductsMost {
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

  ProductsMost(
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

  ProductsMost.fromJson(Map<String, dynamic> json) {
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

class ProductData {
  int id;
  String name;
  String description;
  String length;
  int quantity;
  String width;
  String sale;
  bool deletebar;
  String code;
  String price;
  String imageHeader;
  bool favorite;
  List<Images> images;

  ProductData(
      {this.id,
      this.deletebar = false,
      this.name,
      this.description,
      this.length,
      this.width,
      this.quantity = 0,
      this.sale,
      this.code,
      this.price,
      this.imageHeader,
      this.favorite,
      this.images});

  ProductData.fromJson(Map<String, dynamic> json) {
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

class AllProducts {
  List<ProductData> data;
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  String basePageUrl;
  dynamic nextPageUrl;
  dynamic prevPageUrl;

  AllProducts(
      {this.data,
      this.total,
      this.perPage,
      this.currentPage,
      this.lastPage,
      this.basePageUrl,
      this.nextPageUrl,
      this.prevPageUrl});

  AllProducts.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ProductData>();
      json['data'].forEach((v) {
        data.add(new ProductData.fromJson(v));
      });
    }
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    basePageUrl = json['base_page_url'];
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['base_page_url'] = this.basePageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['prev_page_url'] = this.prevPageUrl;
    return data;
  }
}
