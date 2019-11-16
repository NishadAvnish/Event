import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/models/see_more_model.dart';
import 'package:flutter/material.dart';

class SeeMoreProvider with ChangeNotifier{
  final docRef=Firestore.instance;
  DocumentSnapshot lastSnapshot;


  List<SeeMoreModel> _categoryItems=[];
   final List<String>choiceCategory;
   final value;
   bool _isItemPresent=true;

  SeeMoreProvider( this.choiceCategory,this.value); 

   List<SeeMoreModel> _seeMoreList=[];

   List<SeeMoreModel> get seeMoreItems{
     return [..._seeMoreList];
   }

  bool get isItemPresent{
       return _isItemPresent;
  }

  void changeItemPresent(){
 _isItemPresent=false;
 notifyListeners();
  }

  Future<void> fetchSeeMoreData([String getMore]) async {
        List<SeeMoreModel> _tempList=[];
        print(choiceCategory[value]);
        Query q;
        if(getMore==null)
        q=docRef.collection("Post").where("Category", isEqualTo:choiceCategory[value]).limit(5);

        else{
             q=docRef.collection("Post").where("Category", isEqualTo:choiceCategory[value]).startAfter([lastSnapshot.data]).limit(5);
        }

        try{
           await q.getDocuments().then((snapShot){
           _categoryItems.clear();
             if(snapShot!=null){
               snapShot.documents.forEach((doc){
                 _tempList.add(SeeMoreModel(
                   title:doc.data["title"],
                   id:doc.documentID,
                   timeLine:doc.data["Date"],
                   place:doc.data["place"],
                   eventImageUrl: doc.data["EventImages"][0],
                   seePersonImage: "https://images.unsplash.com/photo-1573848700501-f909e91dbe13?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                   totalSeen: doc.data["Seenby"].toString()
                 ),
                 );
               }
               );

             }
         });}catch(e){
           print(e);
         }

      QuerySnapshot querySnapshot=await q.getDocuments();
      lastSnapshot=querySnapshot.documents[querySnapshot.documents.length-1];
      _seeMoreList=_tempList;
      print("getDataProvidercalled");
      print(_seeMoreList);

      notifyListeners();
   }

}