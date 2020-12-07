class UserModel {
  String tokenType;
  String accessToken;
  String expiresAt;
  User user;
  bool verificationCode;

  UserModel(
      {this.tokenType,
      this.accessToken,
      this.expiresAt,
      this.user,
      this.verificationCode});

  UserModel.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    accessToken = json['access_token'];
    expiresAt = json['expires_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    verificationCode = json['verification_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token_type'] = this.tokenType;
    data['access_token'] = this.accessToken;
    data['expires_at'] = this.expiresAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['verification_code'] = this.verificationCode;
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  Null emailVerifiedAt;
  String image;
  String phone;
  String mobileToken;
  String createdAt;
  String updatedAt;
  List<Roles> roles;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.image,
      this.phone,
      this.mobileToken,
      this.createdAt,
      this.updatedAt,
      this.roles});

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
    if (json['roles'] != null) {
      roles = new List<Roles>();
      json['roles'].forEach((v) {
        roles.add(new Roles.fromJson(v));
      });
    }
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
    if (this.roles != null) {
      data['roles'] = this.roles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int id;
  String name;
  String guardName;
  String createdAt;
  String updatedAt;
  Pivot pivot;

  Roles(
      {this.id,
      this.name,
      this.guardName,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['guard_name'] = this.guardName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  String modelId;
  String roleId;
  String modelType;

  Pivot({this.modelId, this.roleId, this.modelType});

  Pivot.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    roleId = json['role_id'];
    modelType = json['model_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_id'] = this.modelId;
    data['role_id'] = this.roleId;
    data['model_type'] = this.modelType;
    return data;
  }
}