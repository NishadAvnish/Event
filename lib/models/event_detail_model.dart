class EventDetailModel{
  final String title, date, seenBy,authorImageUrl,description;
  final List<SpeakersModel> speakerList;
  final List<String> eventImageUrls;

  EventDetailModel(this.title, this.date, this.seenBy, this.authorImageUrl, this.description, this.speakerList, this.eventImageUrls);
}

class SpeakersModel {
  String speakerImage, speakerName,about;

  SpeakersModel(this.speakerImage, this.speakerName, this.about);
}