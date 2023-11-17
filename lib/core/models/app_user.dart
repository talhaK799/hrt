import 'package:hart/core/constants/format_date.dart';

class AppUser {
  String? id;
  String? paymentId;
  String? email;
  String? password;
  String? phoneNumber;
  bool? isEmailVerified;
  bool? isPhoneNoVerified;
  bool? isPremiumUser;
  bool? isLiked;
  bool? isDesLiked;
  bool? isNotificationsOn;
  bool? isPrivatePhoto;
  bool? isGoogle;
  bool? isFacebook;
  int? likesCount;
  int? spanks;
  int? age;
  DateTime? createdAt = DateTime.now();
  DateTime? uplift = DateTime.now();
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
    this.isGoogle,
    this.phoneNumber,
    this.isEmailVerified,
    this.isPhoneNoVerified,
    this.isPrivatePhoto,
    this.isLiked,
    this.isDesLiked,
    this.muteIds,
    this.likesCount,
    this.spanks,
    this.isNotificationsOn,
    this.name,
    this.dob,
    this.uplift,
    this.nickName,
    this.isPremiumUser,
    this.identity,
    this.isFacebook,
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
    data['paymentId'] = paymentId;
    data['email'] = email;
    data['isGoogle'] = isGoogle ?? false;
    data['isFacebook'] = isFacebook ?? false;
    data['createdAt'] = createdAt ?? DateTime.now();
    data['uplift'] = uplift ?? DateTime.now();
    data['name'] = name ?? 'User';
    data['phoneNumber'] = phoneNumber;
    data['isEmailVerified'] = isEmailVerified ?? false;
    data['isPhoneNoVerified'] = isPhoneNoVerified ?? false;
    data['isNotificationsOn'] = isNotificationsOn ?? false;
    data['isLiked'] = isLiked ?? false;
    data['isDesLiked'] = isDesLiked ?? false;
    data['isPremiumUser'] = isPremiumUser ?? false;
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
    return data;
  }

  AppUser.fromJson(json, id) {
    this.id = id;
    email = json['email'] ?? "";
    paymentId = json['paymentId'];
    name = json['name'] ?? "User";
    createdAt = json['createdAt'].toDate() ?? DateTime(2000);
    uplift = json['uplift'].toDate() ?? DateTime(2000);
    phoneNumber = json['phoneNumber'];
    isEmailVerified = json['isEmailVerified'] ?? false;
    isPhoneNoVerified = json['isPhoneNoVerified'] ?? false;
    isLiked = json['isLiked'] ?? false;
    isDesLiked = json['isDesLiked'] ?? false;
    isPremiumUser = json['isPremiumUser'] ?? false;
    isNotificationsOn = json['isNotificationsOn'] ?? false;
    isPrivatePhoto = json['isPrivatePhoto'] ?? false;
    isGoogle = json['isGoogle'] ?? false;
    isFacebook = json['isFacebook'] ?? false;
    // isMuteNotification = json['isMuteNotification'] ?? false;
    nickName = json['nickName'] ?? "User";
    dob = json['dob'];
    age = json['age'] ?? 0;
    likesCount = json['likesCount'] ?? 10;
    spanks = json['spanks'] ?? 0;
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
// =======
//     try {
//       this.id = id;
//       email = json['email'] ?? "";
//       name = json['name'] ?? "User";
//       phoneNumber = json['phoneNumber'];
//       isEmailVerified = json['isEmailVerified'] ?? false;
//       isPhoneNoVerified = json['isPhoneNoVerified'] ?? false;
//       isLiked = json['isLiked'] ?? false;
//       isDesLiked = json['isDesLiked'] ?? false;
//       // isMuteNotification = json['isMuteNotification'] ?? false;
//       nickName = json['nickName'] ?? "User";
//       dob = json['dob'];
//       age = json['age'] ?? 0;
//       likesCount = json['likesCount'] ?? 10;
//       // lookingFor = json['lookingFor'];
//       if (json["lookingFor"] != null) {
//         lookingFor = [];
//         json["lookingFor"].forEach((element) {
//           lookingFor!.add(element);
//         });
//       } else {
//         lookingFor = [];
//       }
//       if (json["muteIds"] != null) {
//         muteIds = [];
//         json["muteIds"].forEach((element) {
//           muteIds!.add(element);
//         });
//       } else {
//         muteIds = [];
//       }
//       identity = json['identity'];
//       // if (json["identity"] != null) {
//       //   identity = [];
//       //   json["identity"].forEach((element) {
//       //     identity!.add(element);
//       //   });
//       // } else {
//       //   identity = [];
//       // }
//       if (json["desire"] != null) {
//         desire = [];
//         json["desire"].forEach((element) {
//           desire!.add(element);
//         });
//       } else {
//         desire = [];
//       }
//       if (json["images"] != null) {
//         images = [];
//         json["images"].forEach((element) {
//           images!.add(element);
//         });
//       } else {
//         images = [];
//       }
//       if (json["likedUsers"] != null) {
//         likedUsers = [];
//         json["likedUsers"].forEach((element) {
//           likedUsers!.add(element);
//         });
//       } else {
//         likedUsers = [];
//       }
//       if (json["disLikedUsers"] != null) {
//         disLikedUsers = [];
//         json["disLikedUsers"].forEach((element) {
//           disLikedUsers!.add(element);
//         });
//       } else {
//         disLikedUsers = [];
//       }
//     } catch (e) {
//       print("@getUserFromJson: $e");
// >>>>>>> dev
    }
  }
}
