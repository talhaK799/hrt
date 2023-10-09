class LikedUser {
  String? id;
  String? status;
  List<String>? likignUsersIds;

  LikedUser({
    this.id,
    this.status,
    this.likignUsersIds,
  });

  LikedUser.fromJson(json, id) {
    this.id = id;
    status = json['status'] ?? '';
    if (json["likignUsersIds"] != null) {
      likignUsersIds = [];
      json["likignUsersIds"].forEach((element) {
        likignUsersIds!.add(element);
      });
    } else {
      likignUsersIds = [];
    }
  }

  toJson() {
    return {
      'id': id,
      'status': status ?? '',
      'likignUsersIds': likignUsersIds ?? [],
    };
  }
}
