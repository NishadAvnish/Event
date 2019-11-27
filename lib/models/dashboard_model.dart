class DashboardDataModel {
  final String eventName, id, eventImage;
  int seenBy;
  bool isfavourite=false;  
  DashboardDataModel({this.eventName, this.id, this.eventImage,this.isfavourite,this.seenBy});
}
