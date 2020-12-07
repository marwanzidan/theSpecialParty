class ShowOrderDetails {
  Order order;

  ShowOrderDetails({this.order});

  ShowOrderDetails.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    return data;
  }
}

class Order {
  int id;
  String userId;
  String totalPrice;
  String deliveryDate;
  String deliveryTime;
  Status status;
  dynamic note;
  dynamic district;
  String reciverPhone;
  dynamic reciverName;
  dynamic cardDescription;
  dynamic rate;
  dynamic comment;
  String latitude;
  String longitude;
  String address;
  dynamic payid;
  String typePayment;
  String createdAt;
  String updatedAt;
  List<Products> products;
  String whatsapp;
  User user;

  Order(
      {this.id,
      this.userId,
      this.totalPrice,
      this.deliveryDate,
      this.deliveryTime,
      this.status,
      this.note,
      this.district,
      this.reciverPhone,
      this.reciverName,
      this.cardDescription,
      this.rate,
      this.comment,
      this.latitude,
      this.longitude,
      this.address,
      this.payid,
      this.typePayment,
      this.createdAt,
      this.updatedAt,
      this.products,
      this.whatsapp,
      this.user});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalPrice = json['total_price'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    note = json['note'];
    district = json['district'];
    reciverPhone = json['reciver_phone'];
    reciverName = json['reciver_name'];
    cardDescription = json['card_description'];
    rate = json['rate'];
    comment = json['comment'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    payid = json['payid'];
    typePayment = json['type_payment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    whatsapp = json['whatsapp'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['total_price'] = this.totalPrice;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_time'] = this.deliveryTime;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['note'] = this.note;
    data['district'] = this.district;
    data['reciver_phone'] = this.reciverPhone;
    data['reciver_name'] = this.reciverName;
    data['card_description'] = this.cardDescription;
    data['rate'] = this.rate;
    data['comment'] = this.comment;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['payid'] = this.payid;
    data['type_payment'] = this.typePayment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['whatsapp'] = this.whatsapp;
    if (this.user != null) {
      data['user'] = this.user.toJson();
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

class Products {
  int id;
  String name;
  String description;
  String length;
  String width;
  String sale;
  String code;
  String price;
  String imageHeader;
  List<Images> images;
  Pivot pivot;

  Products(
      {this.id,
      this.name,
      this.description,
      this.length,
      this.width,
      this.sale,
      this.code,
      this.price,
      this.imageHeader,
      this.images,
      this.pivot});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    length = json['length'];
    width = json['width'];
    sale = json['sale'];
    code = json['code'];
    price = json['price'];
    imageHeader = json['image_header'];
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
  String quantity;

  Pivot({this.orderId, this.productId, this.quantity});

  Pivot.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String image;
  String phone;
  String mobileToken;
  String createdAt;
  String updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.image,
      this.phone,
      this.mobileToken,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    image = json['image'];
    phone = json['phone'];
    mobileToken = json['mobile_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['mobile_token'] = this.mobileToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}