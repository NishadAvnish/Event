import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/models/dashboard_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Firestore _documentRef = Firestore.instance;

class DashBoardProvider with ChangeNotifier {
  int previousIndex = -1;

  List<DashboardDataModel> _categoryItems = [];
  final List<String> choiceCategory;

  DashBoardProvider(
    this.choiceCategory, //this._categoryItems
  );

  List<DashboardDataModel> get categoryItems {
    return [..._categoryItems];
  }

  Future<void> categoryFetch(index) async {
    List<DashboardDataModel> _tempList = [];
    if (previousIndex != index) {
      try {
        final snapShot = await _documentRef
            .collection("Post")
            .where("Category", arrayContains: choiceCategory[index])
            .getDocuments();

        _categoryItems.clear();
        if (snapShot != null) {
          snapShot.documents.forEach((doc) {
            _tempList.add(
              DashboardDataModel(
                eventName: doc.data["title"],
                id: doc.documentID,
                eventImage: doc.data["EventImages"][0],
                //category: doc.data["Category"][0],
              ),
            );
          });
        }
        previousIndex = index;
        _categoryItems = _tempList;

        notifyListeners();
      } catch (e) {
        print(e.toString());
        throw e;
      }
    }
  }
}

class RecommandedProvider with ChangeNotifier {
  List<DashboardDataModel> _recommandedItem = [];

  List<DashboardDataModel> get recommandedItems {
    return [..._recommandedItem];
  }

  Future<void> recommandedFetch() async {
    String userId;
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      userId = user.uid;
    });
    List<DashboardDataModel> _tempList1 = [];
    try {
      await _documentRef
          .collection("Post")
          .orderBy("Seenby", descending: true)
          .limit(45)
          .getDocuments()
          .then((snapShot) {
        if (snapShot != null) {
          snapShot.documents.forEach((doc) {
            _tempList1.add(DashboardDataModel(
              eventName: doc.data["title"],
              id: doc.documentID,
              eventImage: doc.data["EventImages"][0],
              isfavourite: _checkBool(doc, userId),
              seenBy: doc.data["Seenby"],
              //category: doc.data["Category"],
            ));
          });
        }
      });
    } catch (e) {
      print(e);
    }
    _recommandedItem = _tempList1;
    notifyListeners();
  }

  Future<void> toggleFavourite(
      String prodId, int seenBy, bool isFavourite, int flag,) async {
    //flag=1 from recommanded
    //flag=2 from event detail
    //flag=3 from favourite
    final docRef = Firestore.instance.collection("Post");
    String userId;
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      userId = user.uid;
    });

    int index = _recommandedItem.indexWhere((recommanded) => recommanded.id == prodId);
    DashboardDataModel _tempDashboardModel = _recommandedItem[index];

    //if flag is 2 then seenBy is already decrements or increments that's why we need not to change it here
    //!To-Do
    

    _recommandedItem[index].seenBy =
        flag == 1 ? isFavourite ? seenBy + 1 : seenBy - 1 : seenBy;
    _recommandedItem[index].isfavourite = !_recommandedItem[index].isfavourite;

    notifyListeners();

    if (flag == 1 || flag == 3) {
      try {
        final doc = await docRef.document(prodId).get();

        if (doc.data["likedBy"] != null &&
            doc.data["likedBy"].contains(userId)) {
          await docRef.document(prodId).updateData({
            "likedBy": FieldValue.arrayRemove([userId])
          });

          await docRef.document(prodId).updateData({
            "Seenby": (seenBy - 1),
          });
        } else {
          if (doc.data["linkedBy"] == null) {
            await docRef.document(prodId).setData({
              "likedBy": [userId]
            }, merge: true);
          } else
            await docRef.document(userId).updateData({
              "likedBy": FieldValue.arrayUnion([userId])
            });

          await docRef.document(prodId).updateData({
            "Seenby": (seenBy + 1),
          });
        }
      } catch (e) {
        _recommandedItem[index].isfavourite = _tempDashboardModel.isfavourite;
        notifyListeners();
        throw e;
      }
    }
  }

  bool _checkBool(DocumentSnapshot snapshot, String userId) {
    if (snapshot.data["likedBy"] != null) {
      if (snapshot.data["likedBy"].contains(userId)) {
        return true;
      } else
        return false;
    }
    return false;
  }
}

class CarouselProvider with ChangeNotifier {
  List<String> _carouselImage = [];
  List<String> get carouselItem {
    return [..._carouselImage];
  }

  Stream<void> carouselFetch() async* {
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
    _carouselImage = [...list1];
    notifyListeners();
  }
}
