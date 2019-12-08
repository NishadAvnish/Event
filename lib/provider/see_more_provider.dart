import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/see_more_model.dart';

class SeeMoreProvider with ChangeNotifier {
  final docRef = Firestore.instance;
  DocumentSnapshot lastSnapshot;

  final List<String> choiceCategory;
  final value;

  SeeMoreProvider(this.choiceCategory, this.value);

  List<SeeMoreModel> _seeMoreList = [];
  List<SeeMoreModel> _seeMoreItemsToShow = [];

  List<SeeMoreModel> get seeMoreItems {
    return [..._seeMoreList];
  }

  List<SeeMoreModel> get seeMoreItemsToShow {
    return [..._seeMoreItemsToShow];
  }

  /* bool get isItemPresent {
    return _isItemPresent;
  } */

  String get categoryValue {
    return choiceCategory[value];
  }


  void searchForValue(String value){
    _seeMoreItemsToShow.clear();
    if(value == null)
      _seeMoreItemsToShow.addAll(seeMoreItems);
    else if(value.isEmpty)
      _seeMoreItemsToShow.addAll(seeMoreItems);
    else{
      _seeMoreList.forEach((seeMoreItem){
        if(seeMoreItem.title.toLowerCase().contains(value.toLowerCase()) || seeMoreItem.place.toLowerCase().contains(value.toLowerCase()))
          _seeMoreItemsToShow.add(seeMoreItem);
      });
    }
    notifyListeners();
  }

  Future<void> fetchSeeMoreData([String getMore]) async {
    int _limit = 10;
    print("fetchMore called, getMore : $getMore");
    List<SeeMoreModel> _tempList = [];
    Query q;
    
      q = docRef
          .collection("Post")
          .where("Category", arrayContains: choiceCategory[value])
          .limit(_limit);
   

    try {
      await q.getDocuments().then((snapShot) {
        if (snapShot != null) {
          snapShot.documents.forEach((doc) {
            _tempList.add(
              SeeMoreModel(
                  title: doc.data["title"],
                  id: doc.documentID,
                  timeLine: doc.data["Date"],
                  place: doc.data["place"],
                  eventImageUrl: doc.data["EventImages"][0],
                  seePersonImage:
                      "https://images.unsplash.com/photo-1573848700501-f909e91dbe13?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                  totalSeen: doc.data["Seenby"].toString()),
            );
          });
        }
      });
    } catch (e) {
      print(e);
    }

    QuerySnapshot querySnapshot = await q.getDocuments();
    lastSnapshot = querySnapshot.documents[querySnapshot.documents.length - 1];
    _seeMoreList.clear();
    _seeMoreItemsToShow.clear();
    _seeMoreList.addAll(_tempList);
    _seeMoreItemsToShow.addAll(_tempList);

    notifyListeners();
  }
}