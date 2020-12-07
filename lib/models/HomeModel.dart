class HomeModel {
  List<Sliders> sliders;
  List<Null> cities;
  Setting setting;

  HomeModel({this.sliders, this.cities, this.setting});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = new List<Sliders>();
      json['sliders'].forEach((v) {
        sliders.add(new Sliders.fromJson(v));
      });
    }
    // if (json['cities'] != null) {
    //   cities = new List<Null>();
    //   json['cities'].forEach((v) {
    //     cities.add(new Null.fromJson(v));
    //   });
    // }
    setting =
        json['setting'] != null ? new Setting.fromJson(json['setting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sliders != null) {
      data['sliders'] = this.sliders.map((v) => v.toJson()).toList();
    }
    // if (this.cities != null) {
    //   data['cities'] = this.cities.map((v) => v.toJson()).toList();
    // }
    if (this.setting != null) {
      data['setting'] = this.setting.toJson();
    }
    return data;
  }
}

class Sliders {
  int id;
  String image;
  String position;
  String createdAt;
  String updatedAt;
  String imagePath;

  Sliders(
      {this.id,
      this.image,
      this.position,
      this.createdAt,
      this.updatedAt,
      this.imagePath});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imagePath = 'https://specialparty.ga' +json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['position'] = this.position;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_path'] = this.imagePath;
    return data;
  }
}

class Setting {
  int id;
  String name;
  String logo;
  String facebook;
  String twitter;
  String instagram;
  String snapchat;
  String telegram;
  String logoPath;

  Setting(
      {this.id,
      this.name,
      this.logo,
      this.facebook,
      this.twitter,
      this.instagram,
      this.snapchat,
      this.telegram,
      this.logoPath});

  Setting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    snapchat = json['snapchat'];
    telegram = json['telegram'];
    logoPath = json['logo_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    data['snapchat'] = this.snapchat;
    data['telegram'] = this.telegram;
    data['logo_path'] = this.logoPath;
    return data;
  }
}