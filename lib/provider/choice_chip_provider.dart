import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChoiceChipProvider with ChangeNotifier {
  int _value = 0;
  String name;
  String previousCategory;

  List<String> _chooseCategory = [
    "category",
    "Hospital",
    "InfomationTech"
  ];
  int get value {
    return _value;
  }

  List<String> get chooseCategoryItem {
    return [..._chooseCategory];
  }

  void changeValue(value1) {
    _value = value1;
    notifyListeners();
  }


  Future<void> fetchCategory() async {
    Set<String> _tempSet= Set();
    final docRef= await Firestore.instance.collection("Post").getDocuments().then((snapShot){
        snapShot.documents.forEach((doc){
           doc.data["Category"].forEach((doc){
             _tempSet.add(doc);
           });
                      
        });
    });
    _chooseCategory=_tempSet.toList();

  }
}
