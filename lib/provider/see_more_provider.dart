import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/models/see_more_model.dart';
import 'package:flutter/material.dart';

class SeeMoreProvider with ChangeNotifier {
  final docRef = Firestore.instance;
  DocumentSnapshot lastSnapshot;

  List<SeeMoreModel> _categoryItems = [];
  final List<String> choiceCategory;
  final value;

  SeeMoreProvider(this.choiceCategory, this.value);

  List<SeeMoreModel> _seeMoreList = [];

  List<SeeMoreModel> get seeMoreItems {
    return [..._seeMoreList];
  }

 
  String get categoryValue {
    return choiceCategory[value];
  }



  Future<void> fetchSeeMoreData() async {
    int _limit=10;
    List<SeeMoreModel> _tempList = [];
    Query q;
    
      q = docRef
          .collection("Post")
          .where("Category", arrayContains: choiceCategory[value])
          .limit(_limit);
   

    try {
      await q.getDocuments().then((snapshot) {
        _categoryItems.clear();
        if (snapshot != null) {
          snapshot.documents.forEach((doc) {

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
    _seeMoreList=_tempList;
    notifyListeners();
  }
}