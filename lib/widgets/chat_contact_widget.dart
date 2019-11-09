import '../screens/chat_details_screen.dart';

import '../models/chat_contact_model.dart';
import 'package:flutter/material.dart';

class ChatContactWidget extends StatelessWidget {
  final ChatContact _chatContact;

  ChatContactWidget(this._chatContact);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _chatContact.isRead ? Colors.white : Colors.blue[50],
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      child: ListTile(
        onTap: () => Navigator.of(context).pushNamed(ChatDetailsScreen.route),
        leading: CircleAvatar(
          child: Image.network(
            _chatContact.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(_chatContact.name),
        subtitle: Text(_chatContact.latestChat.length < 30 ? _chatContact.latestChat : "${_chatContact.latestChat.substring(0, 30)}..."),
        trailing: Text(_chatContact.latestChatTime),
      ),
    );
  }
}
