import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/models/user_profile_model.dart';
import 'package:flutter/cupertino.dart';

class UserProfileProvider with ChangeNotifier{
  final _documentRef=Firestore.instance;
  List<UserProfileModel> _userItem=[];

  List<UserProfileModel> get userItem{
    return[..._userItem];
  }

  Future<void> fetch(String id) async {
        List<String> _tempPostImage=[];
        List<String> _productId=[];
        String _userName;
        String _imageUrl;
        String _bioData;
        try{await _documentRef.collection("User").document("$id").get().then((snapShot1){
            if(snapShot1!=null){
             _userName=snapShot1.data["name"];
             _imageUrl=snapShot1.data["photoUrl"];
             _bioData=snapShot1.data["bioData"];
            }
        });
        }catch(e){
          print(e);
        }
        
         try{ await _documentRef.collection("Post").where("createrId", isEqualTo: id).getDocuments().then((snapShot){
             if(snapShot!=null){
               snapShot.documents.forEach((doc){
                _tempPostImage.add(doc.data["EventImages"][0]);
                _productId.add(doc.documentID);
               }
               );
             }
         });
         }catch(e){
         }

     _userItem.insert(0, UserProfileModel(_imageUrl, _userName, _bioData, _tempPostImage, _productId));
    
    notifyListeners();
   }  
}