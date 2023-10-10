class Matches {
  String? id;
  bool? isAccepted;
  bool? isProgressed;
  bool? isRejected;
  String? likedByUserId;
  String? likedUserId;

  Matches({
    this.isAccepted,
    this.id,
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
      'likedByUserId': likedByUserId ?? '',
      'likedUserId': likedUserId ?? '',
    };
  }
}
