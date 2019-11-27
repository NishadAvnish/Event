import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/helpers/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/chat_details_model.dart';

class ChatDetailProvider with ChangeNotifier {
  final docRef = Firestore.instance;
  List<ChatDetails> _chatDetaiList = [];

  List<ChatDetails> get chatDetailItems {
    return [..._chatDetaiList];
  }

  Stream<void> fetchDetail(String chatId, String currentUserId) async*{
    bool isAdmin = false;
    String lastMessage, lastTime;

    List<ChatDetails> _tempMsgList = [];
    try {
      await docRef.collection("Chat").document(chatId).get().then((doc) {
        doc["admin"].contains(currentUserId) ? isAdmin = true : isAdmin = false;
      });

      try {
        await docRef
            .collection("chat")
            .document(chatId)
            .collection("Message")
            .orderBy("time", descending: true)
            .getDocuments()
            .then((snapShot1) {
          snapShot1.documents.forEach(
            (vl) {
              _tempMsgList.add(ChatDetails(
                content: vl.data["msg"],
                time: vl.data["time"],
                creatorId: vl.data["creater"],
                isAdmin: isAdmin,
              ));
            },
          );
        });
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }

    _chatDetaiList = _tempMsgList;
    notifyListeners();
  }

  Future<void> addNewMessage(String chatId, String msg) async {
    final currentUser = await Auth().getCurrentUser();
    final chat = {
      "message": msg,
      "creator_id": currentUser.uid,
      "time": DateTime.now().toIso8601String(),
    };
    try {
      await docRef
          .collection("chats")
          .document(chatId)
          .collection("messages")
          .add(chat);
    } catch (e) {
      print(e);
    }
  }
}
