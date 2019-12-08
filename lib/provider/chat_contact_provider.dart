import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_contact_model.dart';

import 'package:flutter/material.dart';

class ChatContactProvider with ChangeNotifier {
  final docRef = Firestore.instance;
  
  List<ChatContactModel> _contactList = [];
  List<ChatContactModel> _groupList = [];

  List<ChatContactModel> get messagecontactList {
    return [..._contactList];
  }

  List<ChatContactModel> get groupcontactList {
    return [..._contactList];
  }

  Future<void> fetchContact(String currentUserId) async{
    await getLastMessage(currentUserId);

    print("contactList:${_contactList.length}");
    print("groupList:${_groupList.length}");
    notifyListeners();
  }

  Future<void> getLastMessage(String currentUserId) async{
    final snapshot = await docRef
        .collection("Chat")
        .where("users", arrayContains: currentUserId)
        .getDocuments();
    
      snapshot.documents.forEach((doc) async {
        final snapShot1 = await docRef
            .collection("Chat")
            .document(doc.documentID)
            .collection("Message")
            .orderBy("time", descending: true)
            .getDocuments();
        
        final lastMessage = MsgModel(
          msg: snapShot1.documents[1].data["msg"],
          time: snapShot1.documents[1].data["time"],
          createrId: snapShot1.documents[1].data["creater"],
        );

        _contactList.clear();
        _groupList.clear();

        if (doc.data["users"].length <= 2) {
          _contactList.add(
            ChatContactModel(
              id: doc.documentID,
              imageUrl: doc.data["imageUrl"],
              name: doc.documentID,
              lastMessage: lastMessage,
              userList: [...doc.data["users"]],
            ),
          );
        } else {
          _groupList.add(
            ChatContactModel(
              id: doc.documentID,
              imageUrl: doc.data["imageUrl"],
              name: doc.documentID,
              lastMessage: lastMessage,
              userList: [...doc.data["users"]],
            ),
          );
        }
      });

      print("second call");
  }
}
