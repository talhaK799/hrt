class ChatMessage {
  String? text;
  bool? isSender;
  DateTime? timestamp;

  ChatMessage({
    this.text,
    this.isSender=false,
    this.timestamp,
  });
}
