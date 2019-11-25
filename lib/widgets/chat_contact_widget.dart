import 'package:flutter/material.dart';
import '../screens/chat_details_screen.dart';
import '../models/chat_contact_model.dart';

class ChatContactWidget extends StatelessWidget {
  final ChatContactModel _chatContact;
  ChatContactWidget(this._chatContact);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(
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
      ),
    );
  }
}
