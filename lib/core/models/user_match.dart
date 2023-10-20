class UserMatch {
  String? userId;
  String? matchId;
  DateTime? matchedAt;

  UserMatch({this.userId, this.matchedAt, this.matchId});

  UserMatch.fromJson(json, id) {
    this.userId = json["userId"];
    this.matchId = id;
    this.matchedAt = json["matchedAt"].toDate();
  }

  toJson() {
    return {
      "userId": this.userId,
      "matchedAt": this.matchedAt,
    };
  }
}
