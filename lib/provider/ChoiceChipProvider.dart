import 'package:flutter/material.dart';

class ChoiceItemProvider with ChangeNotifier{
  

  int value=0;
  String name;
  String previousCategory;
List<String> _category=[
   "School",
   "Hospital",
   "Technology",
   "Seminar",
 ];

 List<String> get categoryItem{
   return [..._category];
 }


 void changeValue(value1){
   value=value1;
   
   notifyListeners();
   
    }
}
class CategoryModal{
  final String eventName,createrName,createdTime,timeline,description,eventImage,createrImage;

  CategoryModal(this.eventName, this.createrName, this.createdTime, this.timeline, this.description, this.eventImage, this.createrImage);
}

class DashBoardProvider with ChangeNotifier{
   
    List<String> _carouselImage=[
      "https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      "https://images.unsplash.com/photo-1517263904808-5dc91e3e7044?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      
    ]; 

    List<String> get carouselItem{
      return [..._carouselImage];
    }
    
    
}