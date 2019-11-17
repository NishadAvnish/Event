import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/models/chat_details_model.dart';
import 'package:flutter/material.dart';

class ChatDetailProvider with ChangeNotifier{
  final docRef=Firestore.instance;
  List<ChatDetails> _chatDetaiList=[];

  List<ChatDetails> get chatDetailItems{
     return [..._chatDetaiList];
  }


  Future<void>fetchDetail(String chatId,String currentUserId) async {
    bool isAdmin=false;
       List<ChatDetails> _tempMsgList=[];
       try{ await docRef.collection("Chat").document(chatId).get().then((doc){
           doc["admin"].contains(currentUserId)?isAdmin=true:isAdmin=false;
           doc.data["Msg"].forEach((vl){
               _tempMsgList.add(ChatDetails(
                    content:vl["msg"],
                    time: vl["time"],
                    creatorId:vl["creater"],
                    isAdmin: isAdmin,
                  ));
            },);    
        });} catch(e){print(e);}
        _chatDetaiList=_tempMsgList;
        print(_chatDetaiList[0].isAdmin);
        notifyListeners();
   }
  
  
}