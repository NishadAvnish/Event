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
              snapShot.data["title"],
              snapShot.data["Date"],
              snapShot.data["Seenby"].toString(),
              userProfile,
              snapShot.data["Description"],
              snapShot.data["createrId"],
              _tempspeakerlist,
              [...snapShot.data["EventImages"]],
            ));
      });
    } catch (e) {
      print(e);
    }
    _items = _tempitemList;

    notifyListeners();
  }
}
