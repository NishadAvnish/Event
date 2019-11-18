
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/models/chat_contact_model.dart';

import 'package:flutter/material.dart';

class ChatContactProvider with ChangeNotifier{
  final docRef=Firestore.instance;

   List<ChatContactModel> _contactList=[];

   List<ChatContactModel> get contactList{
        return [..._contactList];
   }

   Future<void> fetchContact(String currentUserId) async {
     print("Called  fetchContact");
     List<ChatContactModel> _tempList=[];
     List<MsgModel> _tempMsgList=[];
      await docRef.collection("Chat").where("users",arrayContains: currentUserId).getDocuments().then((snapShot){
          snapShot.documents.forEach((doc){
            docRef.collection("Chat").document(doc.documentID).collection("Message").orderBy("time").getDocuments().then((snapShot1){
                snapShot1.documents.forEach((vl){
               
               _tempMsgList.add(MsgModel(
                    msg:vl.data["msg"],
                    time: vl.data["time"],
                    createrId:vl.data["creater"],
                  ));

            }
            );
            });

               _tempList.add(ChatContactModel(
                id: doc.documentID,
                imageUrl: doc.data["imageUrl"],
                name: doc.documentID,
                msgList:_tempMsgList,
                userList:[... doc.data["users"]],
               ),);
          });

       

      });
      _contactList=_tempList;
      print(_contactList.length);
     notifyListeners();
   }
}