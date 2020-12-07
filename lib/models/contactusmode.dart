class ContactUsModel {
  String name;
  String phone;
  String massage;


  ContactUsModel({this.name, this.phone, this.massage,});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.phone =  json["phone"];
    this.massage = json["massage"];
  }
}