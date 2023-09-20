class Chat {
  String? name;
  String? desscription;
  String? image;
  int? messageCount;
  bool? isGroup;
  DateTime? timestamp;

  Chat({
    this.name,
    this.isGroup = false,
    this.timestamp,
    this.desscription,
    this.image,
    this.messageCount,
  });
}
