import 'package:event/Modal/DashBoardModal.dart';
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


class DashBoardProvider with ChangeNotifier{
   
    List<String> _carouselImage=[
      "https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      "https://images.unsplash.com/photo-1517263904808-5dc91e3e7044?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      
    ]; 

    List<String> get carouselItem{
      return [..._carouselImage];
    }
    
  
   List<DashboardDataModel> _dashdataitems=[
     DashboardDataModel("Event1", "Avnish",DateTime.now().toString(), DateTime.now().toString(), "Delhi", "This is a test","https://images.unsplash.com/photo-1517263904808-5dc91e3e7044?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
     "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSubu9E-kenyCU50qhNJGrFZ4Afpe43-2l_az9oQXleYQ8vF-SF",) ,  

     DashboardDataModel("Event1", "Avnish",DateTime.now().toString(), DateTime.now().toString(), "Delhi", "This is a test","https://images.unsplash.com/photo-1517263904808-5dc91e3e7044?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
     "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSubu9E-kenyCU50qhNJGrFZ4Afpe43-2l_az9oQXleYQ8vF-SF",) ,  

     DashboardDataModel("Event1", "Avnish",DateTime.now().toString(), DateTime.now().toString(), "Delhi", "This is a test","https://images.unsplash.com/photo-1517263904808-5dc91e3e7044?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
     "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSubu9E-kenyCU50qhNJGrFZ4Afpe43-2l_az9oQXleYQ8vF-SF",) ,  

     DashboardDataModel("Event1", "Avnish",DateTime.now().toString(), DateTime.now().toString(), "Delhi", "This is a test","https://images.unsplash.com/photo-1517263904808-5dc91e3e7044?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
     "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSubu9E-kenyCU50qhNJGrFZ4Afpe43-2l_az9oQXleYQ8vF-SF",) ,  

     DashboardDataModel("Event1", "Avnish",DateTime.now().toString(), DateTime.now().toString(), "Delhi", "This is a test","https://images.unsplash.com/photo-1517263904808-5dc91e3e7044?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
     "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSubu9E-kenyCU50qhNJGrFZ4Afpe43-2l_az9oQXleYQ8vF-SF",) ,  

     DashboardDataModel("Event1", "Avnish",DateTime.now().toString(), DateTime.now().toString(), "Delhi", "This is a test","https://images.unsplash.com/photo-1517263904808-5dc91e3e7044?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
     "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSubu9E-kenyCU50qhNJGrFZ4Afpe43-2l_az9oQXleYQ8vF-SF",) ,    

   ];

   List<DashboardDataModel> get dashdataItems{
     return [..._dashdataitems];
   }
    
}