import 'package:cloud_firestore/cloud_firestore.dart';


class CrudOperation {

  static Future<void> add() async {
       try{await Firestore.instance.collection("Post").document().setData({
         "EventImages":["https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80","https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80","https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80", "https://images.unsplash.com/photo-1555445091-5a8b655e8a4a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"],
         "Creater":"Avnish",
         "createrImage":"https://images.unsplash.com/photo-1555445091-5a8b655e8a4a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
         "title":"Event13",
         "Date":DateTime.now().toIso8601String(),
         "Seenby":3222,
         "Category":"Seminar",
         "Description":"Mary Bell (3 December 1903 – 6 February 1979 was an Australian aviator and founding leader of the Women's Air Training Corps, a volunteer organisation that provided support to the Royal Australian Air Force (RAAF) during World War II.Mary Bell (3 December 1903 – 6 February 1979 was an Australian aviator and founding leader of the Women's Air Training Corps, a volunteer organisation that provided support to the Royal Australian Air Force (RAAF) during World War II",
         
         "speaker":[{"name":"jhjh","image":"https://images.unsplash.com/photo-1503249023995-51b0f3778ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60","pos":"Engineer"}]

       });
       }catch(e){print(e);}

  }


  static Future<void> fetch(){
    Firestore.instance.collection("Post/Category/InformationTech").getDocuments().then((snapshot){
             if(snapshot!=null){
               snapshot.documents.forEach((doc){
                  print(doc.data['speaker'][0]["image"]);
               });
             }
    });
  }

}