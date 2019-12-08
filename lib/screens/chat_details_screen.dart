import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/chat_details_widget.dart';
import '../widgets/send_new_chat_widget.dart';
import '../models/chat_contact_model.dart';
import '../models/chat_details_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  static const route = "/chat_details_screen";

  @override
  Widget build(BuildContext context) {
    final ChatContactModel chatContact =
        ModalRoute.of(context).settings.arguments;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(chatContact.imageUrl),
              ),
              SizedBox(
                width: 10,
              ),
              Text(chatContact.name),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: height * 0.8,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("chats")
                          .document(chatContact.id)
                          .collection("messages")
                          .orderBy("time")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Center(child: Text("Loading..."));
                        if (snapshot.hasError)
                          return Center(child: Text("An error occurred..."));
                        return ListView.builder(
                          reverse: true,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (_, index) => ChatDetailsWidget(
                            ChatDetails(
                              creatorId: snapshot
                                  .data.documents[snapshot.data.documents.length - index - 1].data["creator_id"],
                              content: snapshot
                                  .data.documents[snapshot.data.documents.length - index - 1].data["message"],
                              time: DateFormat.Hm().format(DateTime.parse(
                                snapshot.data.documents[snapshot.data.documents.length - index - 1].data["time"],
                              )),
                              isAdmin: false,
                            ),
                          ),
                        );
                      }),
                ),
                SendNewChat(chatContact.id),
              ]),
        
      ),
    );
  }
}
