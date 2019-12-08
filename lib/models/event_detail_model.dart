
import 'package:flutter/foundation.dart';

class EventDetailModel {
  String id,title, date, authorImageUrl, description, createrId, place;
  int seenBy;
  bool isFavorite;
  List<SpeakersModel> speakerList;
  List<String> eventImageUrls;
  List<String> categories;

  EventDetailModel({
    @required this.id,
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
    this.isFavorite=false,
  });
}


class SpeakersModel {
  String speakerImage, speakerName, profile;

  SpeakersModel({this.speakerImage, this.speakerName, this.profile});
}
