import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/event_detail_model.dart';
import 'package:flutter/cupertino.dart';

class EventDetailProvider with ChangeNotifier {
  final _documentRef = Firestore.instance;

  List<EventDetailModel> _items = [];

  List<EventDetailModel> get item {
    return [..._items];
  }

  Future<void> eventFetch(String id) async {
    List<EventDetailModel> _tempitemList = [];
    List<SpeakersModel> _tempspeakerlist = [];
    String userProfile;
    String userId;
    await FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      userId = user.uid;
    });
    try {
      await _documentRef
          .collection("Post")
          .document(id)
          .get()
          .then((snapShot) async {
        snapShot.data["speaker"].forEach((doc) {
          _tempspeakerlist.add(SpeakersModel(
              speakerImage: doc["image"],
              speakerName: doc["name"],
              profile: doc["pos"]));
        });

        try {
          await _documentRef
              .collection("users")
              .document(snapShot.data["creatorId"])
              .get()
              .then((sShot) {
              // userProfile = sShot.data["photoUrl"];
          });
        } catch (e) {
          throw e;
        }

        _tempitemList.insert(
            0,
            EventDetailModel(
              id: snapShot.documentID.toString(),
              title: snapShot.data["title"],
              date: snapShot.data["Date"],
              seenBy: snapShot.data["Seenby"],
              authorImageUrl: userProfile,
              description: snapShot.data["Description"],
              createrId: snapShot.data["creatorId"],
              speakerList: _tempspeakerlist,
              eventImageUrls: [...snapShot.data["EventImages"]],
              place: "Place",
              categories: [],
              isFavorite: _checkBool(snapShot, userId),
            ));
      });
    } catch (e) {
      print(e);
    }
    _items = _tempitemList;

    notifyListeners();
  }

  Future<void> toggleFavourite(String prodId, int seenBy,bool isFavourite) async {
    final docRef = Firestore.instance.collection("Post");
    String userId;

    await FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      userId = user.uid;
    });

    EventDetailModel _eventDetail = _items[0];
    _items[0].seenBy = isFavourite?seenBy + 1:seenBy-1;
    _items[0].isFavorite = !_items[0].isFavorite;
    notifyListeners();
    

    try {
      final doc = await docRef.document(prodId).get();

      if (doc.data["likedBy"] != null && doc.data["likedBy"].contains(userId)) {
        await docRef.document(prodId).updateData({
          "likedBy": FieldValue.arrayRemove([userId])
        });

        await docRef.document(prodId).updateData({
          "Seenby": (seenBy - 1),
        });
      } else {
        if (doc.data["linkedBy"] == null) {
          await docRef.document(prodId).setData({
            "likedBy": [userId]
          }, merge: true);
        } else
          await docRef.document(userId).updateData({
            "likedBy": FieldValue.arrayUnion([userId])
          });

        await docRef.document(prodId).updateData({
          "Seenby": (seenBy + 1),
        });
      }
    } catch (e) {
      _items[0].seenBy = _eventDetail.seenBy;
      _items[0].isFavorite = _eventDetail.isFavorite;
      notifyListeners();
      throw e;
    }
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
}
