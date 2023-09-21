class InfoItem {
  String? id;
  String? title;
  bool? isSelected;
  InfoItem({
    this.id,
    this.title,
    this.isSelected = false,
  });
  InfoItem.fromJson(json, this.id) {
    title = json['title'];
    isSelected = false;
  }

  tojson() {
    return {
      'title': title,
    };
  }
}
