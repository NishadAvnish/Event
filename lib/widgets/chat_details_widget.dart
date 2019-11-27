import 'package:provider/provider.dart';

import '../models/chat_details_model.dart';
import 'package:flutter/material.dart';
import '../provider/current_user_provider.dart';

class ChatDetailsWidget extends StatelessWidget {
  final ChatDetails _chat;

  ChatDetailsWidget(this._chat);

  @override
  Widget build(BuildContext context) {
    final currentUserId = Provider.of<CurrentUserProvider>(context,listen: false).currentUser.id;
    final isMyChat = _chat.creatorId == currentUserId;
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment:
          isMyChat ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: isMyChat ? Radius.circular(15) : Radius.circular(0),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topRight: !isMyChat ? Radius.circular(15) : Radius.circular(0),
            ),
          ),
          color: isMyChat ? Theme.of(context).primaryColorLight : Colors.white,
          child: Container(
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.8,
            ),
            child: Column(
              crossAxisAlignment:
                  isMyChat ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(_chat.content),
                SizedBox(
                  height: 5,
                ),
                Text(
                  _chat.time,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
