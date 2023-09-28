class AppUser {
  String? id;
  String? email;
  String? password;
  String? phoneNumber;
  bool? isEmailVerified;
  String? name;
  // String? fcmToken;

  AppUser({
    this.id,
    this.email,
    this.password,
    this.phoneNumber,
    this.isEmailVerified,
    this.name,
    // this.fcmToken,
  });

  toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['isEmailVerified'] = isEmailVerified ?? false;
    // // data['fcmToken'] = fcmToken;
    return data;
  }

  AppUser.fromJson(json, id) {
    id = id;
    email = json['email'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    isEmailVerified = json['isEmailVerified'] ?? false;
    // fcmToken = json['fcmToken'];
  }
}
