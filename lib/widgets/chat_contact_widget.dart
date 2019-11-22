import 'package:flutter/material.dart';
import '../screens/chat_details_screen.dart';
import '../models/chat_contact_model.dart';

class ChatContactWidget extends StatelessWidget {
  final ChatContactModel _chatContact;
  final int flag;
  final List<ChatContactModel> _items;
  ChatContactWidget(this.index, this._chatContact, this.flag, this._items);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        //color: _chatContact.isRead ? Colors.white : Colors.blue[50],
        color: index % 2 == 0 ? Colors.white : Colors.blue[50],
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
        subtitle: Text(_lastMessage.msg.length < 30
            ? _lastMessage.msg
            : "${_lastMessage.msg.substring(0, 30)}..."),
        trailing:
            Text(_lastMessage.time/*.split("T")[1].split(".")[0].substring(0, 5)*/),
      ),
    );
  }
}
