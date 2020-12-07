class Categorymodel {
  String name;
  String nameAr;
  String nameEn;
  String img_url;
  int id;

  Categorymodel({this.name, this.img_url, this.id,this.nameAr,this.nameEn});

  Categorymodel.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.img_url = json["image"];
    this.id = json["id"];
  }
}
