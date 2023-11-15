class Spanks {
  String? id;
  int no_spanks = 0;
  DateTime? boughtAt;
  double? price;
  String? offer;
  String? userId;
  bool? isSelected;

  Spanks({
    this.id,
    this.no_spanks = 0,
    this.price,
    this.offer,
    this.boughtAt,
    this.userId,
    this.isSelected = false,
  });

  Spanks.fromJson(json, id) {
    this.id = id;
    no_spanks = json['no_spanks'] ?? 0;
    price = json['price'] ?? '';
    // boughtAt = json['boughtAt'].toDate() ?? DateTime.now();
    
    // offer = json['offer'] ?? '';
    userId = json['userId'] ?? '';
  }

  toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['no_spanks'] = no_spanks;
    data['price'] = price;
    data['boughtAt'] = boughtAt;
    data['userId'] = userId;

    return data;
  }
}
