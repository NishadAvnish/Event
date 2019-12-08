import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/firebase_auth.dart';
import '../models/event_detail_model.dart';
import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {
  var _event = EventDetailModel(
    id: "",
    title: "",
    authorImageUrl: "",
    categories: [],
    createrId: "",
    date: "",
    description: "",
    eventImageUrls: [""],
    place: "",
    seenBy: 0,
    speakerList: [
      SpeakersModel(speakerName: "", speakerImage: "", profile: "")
    ],
  );

  void clear() {
    _event = EventDetailModel(
      id: "",
      title: "",
      authorImageUrl: "",
      categories: [],
      createrId: "",
      date: "",
      description: "",
      eventImageUrls: [""],
      place: "",
      seenBy: 0,
      speakerList: [
        SpeakersModel(speakerName: "", speakerImage: "", profile: "")
      ],
    );
  }

  EventDetailModel get event {
    return _event;
  }

  void removeEventImage(int index){
    _event.eventImageUrls.removeAt(index);
    notifyListeners();
  }

  Future<void> addEvent() async {
    final currentUser = await Auth().getCurrentUser();

    final Map<String, dynamic> eventData = {
      "Category": _event.categories,
      "Date": _event.date,
      "Description": _event.description,
      "Seenby":0,
      "EventImages": _event.eventImageUrls,
      "creatorId": currentUser.uid,
      "place": _event.place,
      "speaker": _event.speakerList
          .map((speaker) => {
                "image": speaker.speakerImage,
                "name": speaker.speakerName,
                "pos": speaker.profile,
              })
          .toList(),
      "title": _event.title,
    };

    try {
      await Firestore.instance.collection("Post").document().setData(eventData);
    } catch (error) {
      throw error;
    }
  }
}
