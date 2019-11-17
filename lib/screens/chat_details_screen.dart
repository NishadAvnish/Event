import 'package:event/models/chat_details_model.dart';
import 'package:event/widgets/chat_details_widget.dart';
import 'package:flutter/material.dart';

class ChatDetailsScreen extends StatefulWidget {

  static const route = "/chat_details_screen";

  @override
  _ChatDetailsScreenState createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {

  final _chats = [
    ChatDetails(creatorId: "1",time: "9:08 am",content: "Hi"),
    ChatDetails(creatorId: "0",time: "9:09 am",content: "Hello"),
    ChatDetails(creatorId: "1",time: "9:10 am",content: "How are you?"),
    ChatDetails(creatorId: "0",time: "9:11 am",content: "Fine..."),
    ChatDetails(creatorId: "0",time: "9:12 am",content: "What about you?"),
    ChatDetails(creatorId: "1",time: "9:13 am",content: "Badhiya... or angrezi jhaadna band kar!"),
    ChatDetails(creatorId: "0",time: "9:14 am",content: " tune shuru ki thi, mar khaega bta rha hu. Kal mil tu fir batata hu tuje."),
    ChatDetails(creatorId: "1",time: "9:15 am",content: "Hehehehehehehhehe"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Name"),
      ),
      body: ListView.separated(
        separatorBuilder: (_,index) => SizedBox(
          height: 5,
        ),
        itemCount: _chats.length,
        itemBuilder: (_,index) => ChatDetailsWidget(_chats[index]),
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),
      ),
    );
  }
}