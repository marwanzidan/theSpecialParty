class GetOrdersModel {
  Orders orders;

  GetOrdersModel({this.orders});

  GetOrdersModel.fromJson(Map<String, dynamic> json) {
    orders =
        json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders.toJson();
    }
    return data;
  }
}

class Orders {
  List<MyOrderData> data;
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  String basePageUrl;
  dynamic nextPageUrl;
  dynamic prevPageUrl;

  Orders(
      {this.data,
      this.total,
      this.perPage,
      this.currentPage,
      this.lastPage,
      this.basePageUrl,
      this.nextPageUrl,
      this.prevPageUrl});

  Orders.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<MyOrderData>();
      json['data'].forEach((v) {
        data.add(new MyOrderData.fromJson(v));
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

class MyOrderData {
  int id;
  String totalPrice;
  String productsCount;
  Status status;
  Product product;

  MyOrderData(
      {this.id,
      this.totalPrice,
      this.productsCount,
      this.status,
      this.product});

  MyOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalPrice = json['total_price'];
    productsCount = json['products_count'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_price'] = this.totalPrice;
    data['products_count'] = this.productsCount;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Status {
  int index;
  String status;

  Status({this.index, this.status});

  Status.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['status'] = this.status;
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
  Pivot pivot;

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
      this.images,
      this.pivot});

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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
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

class Pivot {
  String orderId;
  String productId;

  Pivot({this.orderId, this.productId});

  Pivot.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    return data;
  }
}