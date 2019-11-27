import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/models/dashboard_model.dart';
import 'package:event/widgets/recommande_fav_itesm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  static const route = "/favourite_screen";
  List<DashboardDataModel> _favouriteList = [];

  Future<void> _getData() async {
    _favouriteList.clear();
    String userId;
    FirebaseAuth.instance.currentUser().then((_idRef) {
      userId = _idRef.uid;
    });
    final snapshot = await Firestore.instance
        .collection("Post")
        .where("likedBy", arrayContains: userId)
        .getDocuments();

    snapshot.documents.forEach((doc) {
      _favouriteList.add(
        DashboardDataModel(
          eventName: doc.data["title"],
          id: doc.documentID,
          eventImage: doc.data["EventImages"][0],
          isfavourite: _checkBool(doc, userId),
          seenBy: doc.data["Seenby"],
        ),
      );
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        title: Text("Favourite"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height -
            kToolbarHeight -
            MediaQuery.of(context).padding.top,
        width: double.infinity,
        child: FutureBuilder(
            future: _getData(),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting ||
                  snapShot.error != null)
                return Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              return GridView.builder(
                itemCount: _favouriteList.length,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 180,
                    childAspectRatio: 2/2.78,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return HelperFunction().recFavItems(
                        context,
                        _favouriteList[index],3,_favouriteList
                      );
                },
              );
            }),
      ),
    );
  }
}
