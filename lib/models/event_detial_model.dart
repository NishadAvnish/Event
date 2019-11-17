class EventDetailModel {
  final String title, date, seenBy, authorImageUrl, description,createrId;
  final List<SpeakersModel> speakerList;
  final List<String> eventImageUrls;

  EventDetailModel(this.title, 
  this.date, 
  this.seenBy, 
  this.authorImageUrl,
  this.description, 
  this.createrId,
  this.speakerList, 
  this.eventImageUrls
  );
}

class SpeakersModel {
  final String speakerImage, speakerName, about;

  SpeakersModel({this.speakerImage, this.speakerName, this.about});
}