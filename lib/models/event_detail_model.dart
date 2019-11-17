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
  String speakerImage, speakerName,profile;

  SpeakersModel({this.speakerImage, this.speakerName, this.profile});
}