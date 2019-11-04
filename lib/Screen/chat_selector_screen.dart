import 'chat_contacts_screen.dart';
import 'package:flutter/material.dart';

class ChatSelectorScreen extends StatefulWidget {
  @override
  _ChatSelectorScreenState createState() => _ChatSelectorScreenState();
}

class _ChatSelectorScreenState extends State<ChatSelectorScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chats"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Messages",
              ),
              Tab(
                text: "Groups",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ChatContactsScreen(),
            ChatContactsScreen(),
          ],
        ),
      ),
    );
  }
}
