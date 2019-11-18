import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/models/event_detail_model.dart';
import 'package:flutter/cupertino.dart';

class EventDetailProvider with ChangeNotifier {
  final _documentRef = Firestore.instance;

  List<EventDetailModel> _items = [];

  List<EventDetailModel> get item {
    return [..._items];
  }

  Future<void> recommandedFetch(String id) async {
    List<EventDetailModel> _tempitemList = [];
    List<SpeakersModel> _tempspeakerlist = [];
    String userProfile;

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
              .collection("User")
              .document(snapShot.data["createrId"])
              .get()
              .then((sShot) {
            userProfile = sShot.data["photoUrl"];
          });
        } catch (e) {
          print(e);
        }

        _tempitemList.insert(
            0,
            EventDetailModel(
              title:snapShot.data["title"],
              date:snapShot.data["Date"],
              seenBy:snapShot.data["Seenby"].toString(),
              authorImageUrl: userProfile,
              description: snapShot.data["Description"],
              createrId: snapShot.data["creatorId"],
              speakerList: _tempspeakerlist,
              eventImageUrls:[...snapShot.data["EventImages"]],
              place: "Place",
              categories: [],
            ));
      });
    } catch (e) {
      print(e);
    }
    _items = _tempitemList;

    notifyListeners();
  }
}
