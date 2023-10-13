class Matches {
  String? id;
  bool? isAccepted;
  bool? isProgressed;
  DateTime? createdAt;
  bool? isRejected;
  String? likedByUserId;
  String? likedUserId;

  Matches({
    this.isAccepted,
    this.id,
    this.createdAt,
    this.isProgressed,
    this.isRejected,
    this.likedByUserId,
    this.likedUserId,
  });

  Matches.fromJson(json, id) {
    this.id = id;
    isAccepted = json['isAccepted'];
    isProgressed = json['isProgressed'];
    isRejected = json['isRejected'];
    likedByUserId = json['likedByUserId'];
    likedUserId = json['likedUserId'];
  }

  toJson() {
    return {
      'isAccepted': isAccepted ?? false,
      'isProgressed': isProgressed ?? false,
      'isRejected': isRejected ?? false,
      'createdAt': DateTime.now(),
      'likedByUserId': likedByUserId ?? '',
      'likedUserId': likedUserId ?? '',
    };
  }
}
