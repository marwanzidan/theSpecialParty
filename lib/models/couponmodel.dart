class CouponModel {
  Coupon coupon;

  CouponModel({this.coupon});

  CouponModel.fromJson(Map<String, dynamic> json) {
    coupon =
        json['coupon'] != null ? new Coupon.fromJson(json['coupon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coupon != null) {
      data['coupon'] = this.coupon.toJson();
    }
    return data;
  }
}

class Coupon {
  int id;
  String coupon;
  String value;
  String timeOut;
  String createdAt;
  String updatedAt;

  Coupon(
      {this.id,
      this.coupon,
      this.value,
      this.timeOut,
      this.createdAt,
      this.updatedAt});

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coupon = json['coupon'];
    value = json['value'];
    timeOut = json['time_out'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coupon'] = this.coupon;
    data['value'] = this.value;
    data['time_out'] = this.timeOut;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}