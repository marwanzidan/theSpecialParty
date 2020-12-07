class NotificationModel {
  Notifications notifications;

  NotificationModel({this.notifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notifications = json['notifications'] != null
        ? new Notifications.fromJson(json['notifications'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] = this.notifications.toJson();
    }
    return data;
  }
}

class Notifications {
  int currentPage;
  List<NotificationsList> notificationsList;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Notifications(
      {this.currentPage,
      this.notificationsList,
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

  Notifications.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      notificationsList = new List<NotificationsList>();
      json['data'].forEach((v) {
        notificationsList.add(new NotificationsList.fromJson(v));
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
    if (this.notificationsList != null) {
      data['data'] =
          this.notificationsList.map((v) => v.toJson()).toList();
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

class NotificationsList {
  String id;
  String type;
  String notifiableType;
  String notifiableId;
  NotificationData notificationData;
  dynamic readAt;
  String createdAt;
  String updatedAt;

  NotificationsList(
      {this.id,
      this.type,
      this.notifiableType,
      this.notifiableId,
      this.notificationData,
      this.readAt,
      this.createdAt,
      this.updatedAt});

  NotificationsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    notificationData = json['data'] != null
        ? new NotificationData.fromJson(json['data'])
        : null;
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['notifiable_type'] = this.notifiableType;
    data['notifiable_id'] = this.notifiableId;
    if (this.notificationData != null) {
      data['data'] = this.notificationData.toJson();
    }
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class NotificationData {
  Order order;

  NotificationData({this.order});

  NotificationData.fromJson(Map<String, dynamic> json) {
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
  dynamic userId;
  dynamic totalPrice;
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
  dynamic latitude;
  dynamic longitude;
  String address;
  dynamic payid;
  String typePayment;
  String createdAt;
  String updatedAt;
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