class ChatModel {
  final String name;
  final String message;
  final String photoUrl;
  final bool isRead;
  final String date;
  final MessageType type;
  final int unreadMessagesCount;

  ChatModel({
    required this.name,
    required this.message,
    this.photoUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdQ7ARiGBKr0dbLdoCE7SQC4_26-cbpJoQfc1Wpu0Iiw&s=10',
    this.isRead = false,
    required this.date,
    required this.type,
    this.unreadMessagesCount = 0,
  });
}

enum MessageType {
  text,
  image,
  video,
  audio,
  document
}