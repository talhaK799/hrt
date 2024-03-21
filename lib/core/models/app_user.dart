class AppUser {
  String? id;
  String? paymentId;
  String? email;
  String? password;
  String? phoneNumber;
  bool? isEmailVerified;
  bool? isPhoneNoVerified;
  bool? isPremiumUser;
  bool? isGroupAdmin;
  bool? isLiked;
  bool? isDesLiked;
  bool? isNotificationsOn;
  bool? isPrivatePhoto;
  bool? isGoogle;
  bool? isApple;
  bool? isUplifted;
  bool? isProfileCompleted;
  bool? isFacebook;
  int? likesCount;
  int? spanks;
  double? latitude;
  double? longitude;
  double distance = 0.0;
  String? fcmToken;
  int? age;
  DateTime? createdAt = DateTime.now();
  DateTime? uplift = DateTime.now();
  DateTime? onlineTime = DateTime.now();
  String offlineTime = '';

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
  List<String> blockedUsers = [];
  bool? isFirstTimeChat;
  bool? isSelected;
  String? about;

  AppUser({
    this.id,
    this.email,
    this.password,
    this.isGoogle,
    this.phoneNumber,
    this.isEmailVerified,
    this.isPhoneNoVerified,
    this.isPrivatePhoto,
    this.isLiked,
    this.isDesLiked,
    this.isUplifted,
    this.latitude,
    this.longitude,
    this.muteIds,
    this.likesCount,
    this.spanks,
    this.isNotificationsOn,
    this.name,
    this.fcmToken,
    this.dob,
    this.uplift,
    this.nickName,
    this.isPremiumUser,
    this.isGroupAdmin,
    this.identity,
    this.isFacebook,
    this.lookingFor,
    this.desire,
    this.images,
    this.disLikedUsers,
    this.likedUsers,
    this.age,
    this.blockedUsers = const [],
    this.isFirstTimeChat = false,
    this.isSelected = false,
    this.isProfileCompleted,
    this.isApple,
    this.onlineTime,
    this.offlineTime = '',
    this.distance = 0.0,
    this.about,
  });

  toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['paymentId'] = paymentId;
    data['email'] = email;
    data['isGoogle'] = isGoogle ?? false;
    data['isFacebook'] = isFacebook ?? false;
    data['isUplifted'] = isUplifted ?? false;
    data['createdAt'] = createdAt ?? DateTime.now();
    data['uplift'] = uplift ?? DateTime.now();
    data['onlineTime'] = onlineTime ?? DateTime.now();
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['longitude'] = longitude ?? 10;
    data['latitude'] = latitude ?? 8;
    data['fcmToken'] = fcmToken;
    data['isEmailVerified'] = isEmailVerified ?? false;
    data['isProfileCompleted'] = isProfileCompleted ?? false;
    data['isPhoneNoVerified'] = isPhoneNoVerified ?? false;
    data['isNotificationsOn'] = isNotificationsOn ?? false;
    data['isFirstTimeChat'] = isFirstTimeChat ?? false;
    data['isLiked'] = isLiked ?? false;
    data['isDesLiked'] = isDesLiked ?? false;
    data['isPremiumUser'] = isPremiumUser ?? false;
    data['isGroupAdmin'] = isGroupAdmin ?? false;
    data['isPrivatePhoto'] = isPrivatePhoto ?? false;
    data['dob'] = dob ?? '';
    data['age'] = age ?? 0;
    data['likesCount'] = likesCount ?? 0;
    data['spanks'] = spanks ?? 0;
    data['nickName'] = nickName ?? "User";
    data['identity'] = identity ?? "";
    data['lookingFor'] = lookingFor ?? [];
    data['desire'] = desire ?? [];
    data['muteIds'] = muteIds ?? [];
    data['images'] = images ?? [];
    data['likedUsers'] = likedUsers ?? [];
    data['disLikedUsers'] = disLikedUsers ?? [];
    data['blockedUsers'] = blockedUsers ?? [];
    data["isApple"] = isApple ?? false;
    data["about"] = this.about;
    return data;
  }

  AppUser.fromJson(json, id) {
    try {
      this.id = id;
      email = json['email'] ?? "";
      paymentId = json['paymentId'];
      name = json['name'] ?? "User";
      createdAt = json['createdAt'].toDate() ?? DateTime(2000);
      uplift = json['uplift'].toDate() ?? DateTime(2000);
      onlineTime = json['onlineTime'].toDate() ?? DateTime(2000);
      phoneNumber = json['phoneNumber'];
      isEmailVerified = json['isEmailVerified'] ?? false;
      isPhoneNoVerified = json['isPhoneNoVerified'] ?? false;
      isProfileCompleted = json['isProfileCompleted'] ?? false;
      isLiked = json['isLiked'] ?? false;
      isUplifted = json['isUplifted'] ?? false;
      isDesLiked = json['isDesLiked'] ?? false;
      isPremiumUser = json['isPremiumUser'] ?? false;
      isGroupAdmin = json['isGroupAdmin'] ?? false;
      isNotificationsOn = json['isNotificationsOn'] ?? false;
      isPrivatePhoto = json['isPrivatePhoto'] ?? false;
      isFirstTimeChat = json['isFirstTimeChat'] ?? false;
      isGoogle = json['isGoogle'] ?? false;
      isFacebook = json['isFacebook'] ?? false;
      isApple = json["isApple"] ?? false;
      this.fcmToken = json['fcmToken'] ?? '';
      // isMuteNotification = json['isMuteNotification'] ?? false;
      nickName = json['nickName'] ?? "User";
      dob = json['dob'];
      age = json['age'] ?? 0;
      likesCount = json['likesCount'] ?? 10;
      spanks = json['spanks'] ?? 0;
      latitude = json['latitude'].toDouble() ?? 2.0;
      longitude = json['longitude'].toDouble() ?? 3.0;
      about = json['about'] ?? "";
      if (json["lookingFor"] != null) {
        lookingFor = [];
        json["lookingFor"].forEach((element) {
          lookingFor!.add(element);
        });
      } else {
        lookingFor = [];
      }
      if (json["blockedUsers"] != null) {
        blockedUsers = [];
        json["blockedUsers"].forEach((element) {
          blockedUsers!.add(element);
        });
      } else {
        blockedUsers = [];
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
    } catch (e) {
      print("getAllUsers.FromJson: ${e}");
    }
  }
}
