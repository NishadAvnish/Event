import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/chat_contact_model.dart';
import '../provider/current_user_provider.dart';
import '../widgets/chat_contact_widget.dart';

class ChatContactsScreen extends StatelessWidget {
  static const route = "/chat_contacts_screen";

  ChatContactModel getChatContact(
      DocumentSnapshot snapshot, BuildContext context, String currentUserId) {
    Map<String, dynamic> data = snapshot.data;
    int index = data["is_group"] ? 0 : 1 - data["users"].indexOf(currentUserId);
    return ChatContactModel(
      id: snapshot.documentID,
      name: data["names"][index],
      imageUrl: data["images"][index],
    );
  }

  @override
  Widget build(BuildContext context) {
    String currentUserId =
        Provider.of<CurrentUserProvider>(context).currentUser.id;
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('chats')
              .where("users", arrayContains: currentUserId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              );
            if (snapshot.hasError)
              return Center(
                child: Text("Something went wrong..."),
              );
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => Column(
                children: <Widget>[
                  ChatContactWidget(
                    getChatContact(
                      snapshot.data.documents[index],
                      context,
                      currentUserId,
                    ),
                  ),
                  Divider(),
                ],
              ),
              itemCount: snapshot.data.documents.length,
            );
          },
        ),
      ),
    );
  }
}
