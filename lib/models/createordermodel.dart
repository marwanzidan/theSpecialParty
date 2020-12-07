class CreateOrderModel {
  String address;
  double longitude;
  double latitude;
  String deliveryDate;
  String deliveryTime;
  dynamic district;
  String reciverPhone;
  dynamic reciverName;
  dynamic cardDescription;
  dynamic rate;
  dynamic comment;
  dynamic note;
  double totalPrice;
  String typePayment;
  List<Products> products;

  CreateOrderModel(
      {this.address,
      this.longitude,
      this.latitude,
      this.deliveryDate,
      this.deliveryTime,
      this.district,
      this.reciverPhone,
      this.reciverName,
      this.cardDescription,
      this.rate,
      this.comment,
      this.note,
      this.totalPrice,
      this.typePayment,
      this.products});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'];
    district = json['district'];
    reciverPhone = json['reciver_phone'];
    reciverName = json['reciver_name'];
    cardDescription = json['card_description'];
    rate = json['rate'];
    comment = json['comment'];
    note = json['note'];
    totalPrice = json['total_price'];
    typePayment = json['type_payment'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_time'] = this.deliveryTime;
    data['district'] = this.district;
    data['reciver_phone'] = this.reciverPhone;
    data['reciver_name'] = this.reciverName;
    data['card_description'] = this.cardDescription;
    data['rate'] = this.rate;
    data['comment'] = this.comment;
    data['note'] = this.note;
    data['total_price'] = this.totalPrice;
    data['type_payment'] = this.typePayment;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String quantity;
  String productId;

  Products({this.quantity, this.productId});

  Products.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['product_id'] = this.productId;
    return data;
  }
}