class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? token;
  DateTime? expiresIn;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.token,
    this.expiresIn,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    if (json['token'] != null) {
      token = json['token'];
    }
    if (json['expiresIn'] != null) {
      expiresIn = DateTime.parse(json['expiresIn']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['token'] = token;
    if (expiresIn != null) {
      data['expiresIn'] = expiresIn!.toString();
    } else {
      data['expiresIn'] = null;
    }
    return data;
  }

  Map<String, dynamic> toJsonUser() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}
