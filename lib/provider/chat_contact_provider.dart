import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/models/chat_contact_model.dart';

import 'package:flutter/material.dart';

class ChatContactProvider with ChangeNotifier {
  final docRef = Firestore.instance;

  List<ChatContactModel> _contactList = [];
  List<ChatContactModel> _groupList=[];

  List<ChatContactModel> get messagecontactList {
    return [..._contactList];
  }
  List<ChatContactModel> get groupcontactList {
    return [..._contactList];
  }

  Future<void> fetchContact(String currentUserId) async {
    
    List<ChatContactModel> _tempList = [];
    List<ChatContactModel> _tempList1 = [];
    List<MsgModel> _tempMsgList = [];

    final snapShot = await docRef
        .collection("Chat")
        .where("users", arrayContains: currentUserId)
        .getDocuments();

    snapShot.documents.forEach((doc) async {
      final snapShot1 = await docRef
          .collection("Chat")
          .document(doc.documentID)
          .collection("Message")
          .orderBy("time")
          .getDocuments();

      snapShot1.documents.forEach((vl) {
        _tempMsgList.add(MsgModel(
          msg: vl.data["msg"],
          time: vl.data["time"],
          createrId: vl.data["creater"],
        ));
      });
       if(doc.data["users"].length<=2){
      _tempList.add(
        ChatContactModel(
          id: doc.documentID,
          imageUrl: doc.data["imageUrl"],
          name: doc.documentID,
          msgList: _tempMsgList,
          userList: [...doc.data["users"]],
        ),
      );}

      else{
          _tempList1.add(
        ChatContactModel(
          id: doc.documentID,
          imageUrl: doc.data["imageUrl"],
          name: doc.documentID,
          msgList: _tempMsgList,
          userList: [...doc.data["users"]],
        ),
      );
      }
      
      _contactList = _tempList;
      _groupList=_tempList1;

      print("contactList:${_contactList.length}");
      print("groupList:${_groupList.length}");
      notifyListeners();
    });
  }
}
