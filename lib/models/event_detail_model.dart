import 'package:flutter/foundation.dart';

class EventDetailModel {
  String title, date, seenBy, authorImageUrl, description, createrId, place;
  List<SpeakersModel> speakerList;
  List<String> eventImageUrls;
  List<String> categories;

  EventDetailModel({
    @required this.title,
    @required this.place,
    @required this.date,
    @required this.seenBy,
    @required this.authorImageUrl,
    @required this.description,
    @required this.createrId,
    @required this.speakerList,
    @required this.eventImageUrls,
    @required this.categories,
  });
}

class SpeakersModel {
  String speakerImage, speakerName, profile;

  SpeakersModel({this.speakerImage, this.speakerName, this.profile});
}
