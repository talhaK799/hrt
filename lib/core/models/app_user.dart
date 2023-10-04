class AppUser {
  String? id;
  String? email;
  String? password;
  String? phoneNumber;
  bool? isEmailVerified;
  bool? isPhoneNoVerified;
  String? name;
  String? dob;
  String? nickName;
  List<String>? identity;
  List<String>? lookingFor;
  List<String>? desire;
  List<String>? images;
  

  AppUser({
    this.id,
    this.email,
    this.password,
    this.phoneNumber,
    this.isEmailVerified,
    this.isPhoneNoVerified,
    this.name,
    this.dob,
    this.nickName,
    this.identity,
    this.lookingFor,
    this.desire,
    this.images,
  });

  toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['isEmailVerified'] = isEmailVerified ?? false;
    data['isPhoneNoVerified'] = isPhoneNoVerified ?? false;
    data['dob'] = dob;
    data['nickName'] = nickName;
    data['identity'] = identity ?? [];
    data['lookingFor'] = lookingFor ?? [];
    data['desire'] = desire ?? [];
    data['images'] = images ?? [];
    // if (identity != null || identity!.isNotEmpty) {
    //   identity!.forEach((element) async {
    //     await data["identity"].add(element);
    //   });
    // } else {
    //   identity = [];
    // }
    // if (lookingFor != null || lookingFor!.isNotEmpty) {
    //   lookingFor!.forEach((element) async {
    //     await data["lookingFor"].add(element);
    //   });
    // } else {
    //   lookingFor = [];
    // }
    return data;
  }

  AppUser.fromJson(json, id) {
    id = id;
    email = json['email'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    isEmailVerified = json['isEmailVerified'] ?? false;
    isPhoneNoVerified = json['isPhoneNoVerified'] ?? false;
    dob = json['dob'];
    if (json["lookingFor"] != null) {
      lookingFor = [];
      json["lookingFor"].forEach((element) {
        lookingFor!.add(element);
      });
    } else {
      lookingFor = [];
    }
    if (json["identity"] != null) {
      identity = [];
      json["identity"].forEach((element) {
        identity!.add(element);
      });
    } else {
      identity = [];
    }
    if (json["desire"] != null) {
      desire = [];
      json["desire"].forEach((element) {
        desire!.add(element);
      });
    } else {
      desire = [];
    }
    if (json["images"] != null) {
      images = [];
      json["images"].forEach((element) {
        images!.add(element);
      });
    } else {
      images = [];
    }
    nickName = json['nickName'];
  }
}
