import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/models/dashboard_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FavouriteProvider with ChangeNotifier{
  
   List<DashboardDataModel> _favouriteList = [];
   List<DashboardDataModel> get favouriteList{
     return [..._favouriteList];
   }

  Future<void> getData() async {
    _favouriteList.clear();
    String userId;
    await FirebaseAuth.instance.currentUser().then((_idRef) {
      userId = _idRef.uid;
    });
    final snapshot = await Firestore.instance
        .collection("Post")
        .where("likedBy", arrayContains: userId)
        .getDocuments();

    snapshot.documents.forEach((doc) {
      _favouriteList.add(
        DashboardDataModel(
          eventName: doc.data["title"],
          id: doc.documentID,
          eventImage: doc.data["EventImages"][0],
          isfavourite: _checkBool(doc, userId),
          seenBy: doc.data["Seenby"],
        ),
      );
    });
  }

  bool _checkBool(DocumentSnapshot snapshot, String userId) {
    if (snapshot.data["likedBy"] != null) {
      if (snapshot.data["likedBy"].contains(userId)) {
        return true;
      } else
        return false;
    }
    return false;
  }

  void deleteDatafromList(String prodId){
    print(_favouriteList.length);
    int index=_favouriteList.indexWhere((favouriteList)=>favouriteList.id==prodId);
      _favouriteList.removeAt(index);
      notifyListeners();
    print(_favouriteList.length);  

  }
}