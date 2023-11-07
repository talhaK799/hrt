class AppUser {
  String? id;
  String? email;
  String? password;
  String? phoneNumber;
  bool? isEmailVerified;
  bool? isPhoneNoVerified;
  bool? isLiked;
  bool? isDesLiked;
  // bool? isMuteNotification;
  int? age;
  String? name;
  String? dob;
  String? nickName;
  String? identity;
  List<String>? lookingFor;
  List<String>? muteIds;
  List<String>? desire;
  List<String>? images;
  List<String>? likedUsers;
  List<String>? disLikedUsers;
  List<String>? users;
  bool? isSelected;

  AppUser({
    this.id,
    this.email,
    this.password,
    this.phoneNumber,
    this.isEmailVerified,
    this.isPhoneNoVerified,
    this.isLiked,
    this.isDesLiked,
    this.muteIds,
    // this.isMuteNotification=false,
    this.name,
    this.dob,
    this.nickName,
    this.identity,
    this.lookingFor,
    this.desire,
    this.images,
    this.disLikedUsers,
    this.likedUsers,
    this.age,
    this.users,
    this.isSelected = false,
  });

  toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['name'] = name ?? 'User';
    data['phoneNumber'] = phoneNumber;
    data['isEmailVerified'] = isEmailVerified ?? false;
    data['isPhoneNoVerified'] = isPhoneNoVerified ?? false;
    data['isLiked'] = isLiked ?? false;
    data['isDesLiked'] = isDesLiked ?? false;
    // data['isMuteNotification'] = isMuteNotification ?? false;

    data['dob'] = dob;
    data['age'] = age;
    data['nickName'] = nickName ?? "User";
    data['identity'] = identity ?? "";
    data['lookingFor'] = lookingFor ?? "";

    data['desire'] = desire ?? [];
    data['muteIds'] = muteIds ?? [];
    data['images'] = images ?? [];
    data['likedUsers'] = likedUsers ?? [];
    data['disLikedUsers'] = disLikedUsers ?? [];
    return data;
  }

  AppUser.fromJson(json, id) {
    this.id = id;
    email = json['email'] ?? "";
    name = json['name'] ?? "User";
    phoneNumber = json['phoneNumber'];
    isEmailVerified = json['isEmailVerified'] ?? false;
    isPhoneNoVerified = json['isPhoneNoVerified'] ?? false;
    isLiked = json['isLiked'] ?? false;
    isDesLiked = json['isDesLiked'] ?? false;
    // isMuteNotification = json['isMuteNotification'] ?? false;
    nickName = json['nickName'] ?? "User";
    dob = json['dob'];
    age = json['age'] ?? 0;
    // lookingFor = json['lookingFor'];
    if (json["lookingFor"] != null) {
      lookingFor = [];
      json["lookingFor"].forEach((element) {
        lookingFor!.add(element);
      });
    } else {
      lookingFor = [];
    }
    if (json["muteIds"] != null) {
      muteIds = [];
      json["muteIds"].forEach((element) {
        muteIds!.add(element);
      });
    } else {
      muteIds = [];
    }
    identity = json['identity'];
    // if (json["identity"] != null) {
    //   identity = [];
    //   json["identity"].forEach((element) {
    //     identity!.add(element);
    //   });
    // } else {
    //   identity = [];
    // }
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
    if (json["likedUsers"] != null) {
      likedUsers = [];
      json["likedUsers"].forEach((element) {
        likedUsers!.add(element);
      });
    } else {
      likedUsers = [];
    }
    if (json["disLikedUsers"] != null) {
      disLikedUsers = [];
      json["disLikedUsers"].forEach((element) {
        disLikedUsers!.add(element);
      });
    } else {
      disLikedUsers = [];
    }
  }
}
