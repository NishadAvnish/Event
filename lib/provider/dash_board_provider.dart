import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/models/dashboard_model.dart';
import 'package:flutter/material.dart';

Firestore _documentRef = Firestore.instance;

class DashBoardProvider with ChangeNotifier {
  int previousIndex = -1;

  List<DashboardDataModel> _categoryItems = [];
  final List<String> choiceCategory;

  DashBoardProvider(
    this.choiceCategory, //this._categoryItems
  );
  List<DashboardDataModel> _recommandedItem = [];

  List<DashboardDataModel> get CategoryItems {
    return [..._categoryItems];
  }

  List<DashboardDataModel> get recommandedItems {
    return [..._recommandedItem];
  }

  Future<void> categoryFetch(index) async {
    List<DashboardDataModel> _tempList = [];

    if (previousIndex != index) {
      try {
        await _documentRef
            .collection("Post")
            .where("Category", isEqualTo: choiceCategory[index])
            .limit(10)
            .getDocuments()
            .then((snapShot) {
          _categoryItems.clear();
          if (snapShot != null) {
            snapShot.documents.forEach((doc) {
              _tempList.add(
                DashboardDataModel(
                  eventName: doc.data["Creater"],
                  id: doc.documentID,
                  eventImage: doc.data["EventImages"][0],
                  category: doc.data["Category"],
                ),
              );
            });
          }
        });
      } catch (e) {}

      previousIndex = index;
      _categoryItems = _tempList;

      notifyListeners();
    }
  }

  Future<void> recommandedFetch() async {
    List<DashboardDataModel> _tempList = [];

    try {
      await _documentRef
          .collection("Post")
          .orderBy("Seenby", descending: true)
          .limit(45)
          .getDocuments()
          .then((snapShot) {
        _categoryItems.clear();
        if (snapShot != null) {
          snapShot.documents.forEach((doc) {
            print(doc.data);
          });
        }
      });
    } catch (e) {}

    _categoryItems = _tempList;
    notifyListeners();
  }
}

class CarouselProvider with ChangeNotifier {
  List<String> _carouselImage = [];
  List<String> get carouselItem {
    return [..._carouselImage];
  }

  Future<Stream> carouselFetch() async {
    List<dynamic> list1 = [];
    try {
      await _documentRef.collection("Carousal").getDocuments().then((ds) {
        if (ds != null) {
          ds.documents.forEach((document) {
            list1 = [...document.data["Images"]];
          });
        }
      });
    } catch (e) {
      print(e);
    }
    _carouselImage = [];
    _carouselImage = [...list1];
    notifyListeners();
  }
}
