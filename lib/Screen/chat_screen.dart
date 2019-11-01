import 'package:event/models/chat_contact_model.dart';
import 'package:event/widgets/chat_contact_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final _chatContactsList = [
    ChatContact(
      id: "1",
      imageUrl:
          "https://i0.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
      name: "Name",
      latestChat:
          "This is the latest chat and its length is increased to check.",
      latestChatTime: "8:30 PM",
      isRead: true,
    ),
    ChatContact(
      id: "2",
      imageUrl:
          "https://i0.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
      name: "Name",
      latestChat:
          "This is the latest chat and its length is increased to check.",
      latestChatTime: "8:30 PM",
      isRead: true,
    ),
    ChatContact(
      id: "3",
      imageUrl:
          "https://i0.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
      name: "Name",
      latestChat:
          "This is the latest chat and its length is increased to check.",
      latestChatTime: "8:30 PM",
      isRead: false,
    ),
    ChatContact(
      id: "4",
      imageUrl:
          "https://i0.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
      name: "Name",
      latestChat:
          "This is the latest chat and its length is increased to check.",
      latestChatTime: "8:30 PM",
      isRead: true,
    ),
    ChatContact(
      id: "5",
      imageUrl:
          "https://i0.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
      name: "Name",
      latestChat:
          "This is the latest chat and its length is increased to check.",
      latestChatTime: "8:30 PM",
      isRead: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: _chatContactsList.length,
        itemBuilder: (_, index) => ChatContactWidget(
          _chatContactsList[index],
        ),
      ),
    );
  }
}
