import 'package:flutter/foundation.dart';

class ChatContact {
  final String id;
  final String imageUrl;
  final String name;
  final String latestChat;
  final String latestChatTime;
  bool isRead;

  ChatContact({
      @required this.id,
      @required this.imageUrl,
      @required this.name,
      @required this.latestChat,
      @required this.latestChatTime,
      @required this.isRead
  });

}
