enum messageType { user, bot }

class MessageBubble {
  MessageBubble({
    required this.text,
    required this.type,
  });
  String? text;
  messageType? type;
}
