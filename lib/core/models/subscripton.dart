class Subscription {
  String? id;
  int no_days = 0;
  DateTime? boughtAt;
  DateTime? expiredAt;
  String? price;
  String? userId;
  String? weeklyPrice;
  String? type;

  bool? isSelected;


  Subscription({
    this.id,
    this.no_days = 0,
    this.price,
    this.boughtAt,
    this.expiredAt,
this.type,
    this.weeklyPrice='',
    this.userId,
    this.isSelected = false,
  });

  Subscription.fromJson(json, id) {
    this.id = id;
    no_days = json['no_days'] ?? 0;
    price = json['price'] ?? '';
    boughtAt = json['boughtAt'].toDate();
    expiredAt = json['expiredAt'].toDate();
    userId = json['userId'] ?? '';
    type = json['type'] ?? '';
  }

  toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['no_days'] = no_days;
    data['price'] = price;
    data['boughtAt'] = boughtAt;
    data['expiredAt'] = expiredAt;
    data['userId'] = userId;
    data['type'] = type;

    return data;
  }
}
