import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/user_profile_model.dart';

class UserProfileProvider with ChangeNotifier {
  final _documentRef = Firestore.instance;
  List<UserProfileModel> _userItem = [];

  List<UserProfileModel> get userItem {
    return [..._userItem];
  }

  Future<void> fetch(String id) async {
    List<String> _tempPostImage = [];
    List<String> _productId = [];
    String _userName;
    String _imageUrl;
    String _role;

    try {
      final snapshot =
          await _documentRef.collection("users").document(id).get();

      if (snapshot != null) {
        _userName = snapshot.data["full_name"];
        _imageUrl = snapshot.data["image_url"] ?? "NA";
        _role = snapshot.data["role"];
      }
    } catch (e) {
      print(e);
    }

    try {
      final snapShot = await _documentRef
          .collection("Post")
          .where("creatorId", isEqualTo: id)
          .getDocuments();

      if (snapShot != null) {
        snapShot.documents.forEach((doc) {
          _tempPostImage.add(doc.data["EventImages"][0]);
          _productId.add(doc.documentID);
        });
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }

    _userItem.insert(
      0,
      UserProfileModel(
          _imageUrl, _userName, _role, _tempPostImage, _productId),
    );

    notifyListeners();
  }
}
