import 'package:flutter/material.dart';

class ChoiceChipProvider with ChangeNotifier {
  int _value = 0;
  String name;
  String previousCategory;

  List<String> _chooseCategory = [
    "School",
    "Hospital",
    "InformationTech",
    "Seminar",
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
}
