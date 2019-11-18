import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChoiceChipProvider with ChangeNotifier {
  int _value = 0;
  String name;
  String previousCategory;

  List<String> _chooseCategory = [];

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
    Set<String> _tempSet = Set();

    try {
      final snapShot = await Firestore.instance.collection("Post").getDocuments();
      print(snapShot.documents);
      snapShot.documents.forEach((event) {
        event.data["Category"].forEach((category) {
          _tempSet.add(category);
        });
      });

      print(_tempSet);
      _chooseCategory = _tempSet.toList();
      notifyListeners();
    } catch (error) {
      print("errorrrrr... ${error.toString()}");
      throw error;
    }
  }
}
