class Notifications {
  String? id;
  DateTime? createdAt;
  String? fromUserId;
  String? toUserId;
  String? title;
  String? description;
  String? imageUrl;

  Notifications() {
    this.createdAt;
    this.id;
    this.fromUserId;
    this.toUserId;
    this.description;
    this.title;
    this.imageUrl;
  }

  Notifications.fromJson(json, id) {
    this.id = id;

    createdAt = json['createdAt'];
    fromUserId = json['fromUserId'];
    toUserId = json['toUserId'];
    title = json['title'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }
}
