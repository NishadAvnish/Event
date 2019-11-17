
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
     List<ChatContactModel> _tempList=[];
     List<MsgModel> _tempMsgList=[];
     try{ await docRef.collection("Chat").where("users",arrayContains: currentUserId).getDocuments().then((snapShot){
          snapShot.documents.forEach((doc){
            doc.data["Msg"].forEach((vl){
               _tempMsgList.add(MsgModel(
                    msg:vl["msg"],
                    time: vl["time"],
                    createrId:vl["creater"],
                  ));
            }
            );


               _tempList.add(ChatContactModel(
                id: doc.documentID,
                imageUrl: doc.data["immageUrl"],
                name: doc.documentID,
                msgList:_tempMsgList,
                userList: [...doc.data["users"]],
               ),);


          });

      });}catch(e){print(e);}
      _contactList=_tempList;
     notifyListeners();
     
   }
  
}