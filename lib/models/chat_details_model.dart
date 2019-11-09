import 'package:flutter/foundation.dart';

class ChatDetails {
  final String creatorId;
  final String content;
  final String time;

  ChatDetails({
    @required this.creatorId,
    @required this.content,
    @required this.time,
  });
}
