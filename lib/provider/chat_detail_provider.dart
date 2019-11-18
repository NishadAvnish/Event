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
    String lastMessage,lastTime;

       List<ChatDetails> _tempMsgList=[];
       try{ await docRef.collection("Chat").document(chatId).get().then((doc){
           doc["admin"].contains(currentUserId)?isAdmin=true:isAdmin=false;
          
        });
              
           try{await docRef.collection("Chat").document(chatId).collection("Message").orderBy("time",descending:true).getDocuments().then((snapShot1){
           snapShot1.documents.forEach((vl){
               _tempMsgList.add(ChatDetails(
                    content:vl.data["msg"],
                    time: vl.data["time"],
                    creatorId:vl.data["creater"],
                    isAdmin: isAdmin,
                  ));
                  
            },);   

            }); }catch(e){
              print(e);
            }
        
        }catch(e){print(e);}
        
        _chatDetaiList=_tempMsgList;
        notifyListeners();
   }
  
  Future<void> addNewMsg(chatId,Map<String,dynamic> msg) async {
    
     try{await docRef.collection("Chat").document(chatId).collection("Message").add(
      msg
    );}catch(e){
      print(e);
    }
     
  }
  
}