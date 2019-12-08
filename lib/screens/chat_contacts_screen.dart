import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/chat_contact_model.dart';
import '../provider/current_user_provider.dart';
import '../widgets/chat_contact_widget.dart';

class ChatContactsScreen extends StatelessWidget {
  static const route = "/chat_contacts_screen";

  String otherUserId(Map<String, dynamic> data, String currentUserId) {
    int index = data["is_group"] ? 0 : 1 - data["users"].indexOf(currentUserId);
    return data["users"][index];
  }

  @override
  Widget build(BuildContext context) {
    String currentUserId =
        Provider.of<CurrentUserProvider>(context, listen: false).currentUser.id;
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
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    StreamBuilder<DocumentSnapshot>(
                        stream: Firestore.instance
                            .collection("users")
                            .document(otherUserId(
                              snapshot.data.documents[index].data,
                              currentUserId,
                            ))
                            .get()
                            .asStream(),
                        builder: (_, snapshot1) {
                          if (snapshot1.connectionState == ConnectionState.waiting)
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          if (snapshot1.hasError)
                            return Center(
                              child: Text("Something went wrong..."),
                            );
                          return Column(
                            children: <Widget>[
                              ChatContactWidget(
                                ChatContactModel(
                                  id: snapshot.data.documents[index].documentID,
                                  name: snapshot1.data.data["user_name"],
                                  imageUrl:
                                      snapshot1.data.data["image_url"] ?? "NA",
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        }));
          },
        ),
      ),
    );
  }
}
