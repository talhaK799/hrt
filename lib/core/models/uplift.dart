class UPlift {
  String? id;
  DateTime? boughtAt;
  DateTime? endAt;

  double? price;
  String? userId;

  UPlift({
    this.id,
    this.price,
    this.boughtAt,
    this.userId,
    this.endAt,
  });

  UPlift.fromJson(json, id) {
    this.id = id;
    price = json['price'] ?? 0.0;
    boughtAt = json['boughtAt'].toDate() ?? DateTime.now();
    endAt = json['endAt'].toDate() ?? DateTime.now();
    userId = json['userId'] ?? '';
  }

  toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['price'] = price;
    data['boughtAt'] = boughtAt;
    data['endAt'] = endAt;
    data['userId'] = userId;

    return data;
  }
}
