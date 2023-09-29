class AppUser {
  String? id;
  String? email;
  String? password;
  String? phoneNumber;
  bool? isEmailVerified;
  bool? isPhoneNoVerified;
  String? name;
  // String? fcmToken;

  AppUser({
    this.id,
    this.email,
    this.password,
    this.phoneNumber,
    this.isEmailVerified,
    this.isPhoneNoVerified,
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
    data['isPhoneNoVerified'] = isPhoneNoVerified ?? false;
    // // data['fcmToken'] = fcmToken;
    return data;
  }

  AppUser.fromJson(json, id) {
    id = id;
    email = json['email'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    isEmailVerified = json['isEmailVerified'] ?? false;
    isPhoneNoVerified = json['isPhoneNoVerified'] ?? false;
    // fcmToken = json['fcmToken'];
  }
}
