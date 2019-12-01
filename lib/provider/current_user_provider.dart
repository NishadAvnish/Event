import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/firebase_auth.dart';
import '../models/connection_model.dart';

class CurrentUserProvider with ChangeNotifier {
  Connection _currentUser;

  Connection get currentUser {
    return _currentUser;
  }

  void updateCurrentUser(Connection newData){
    _currentUser.name = newData.name;
    _currentUser.userName = newData.userName;
    _currentUser.imageUrl = newData.imageUrl;
    notifyListeners();
  }

  Future<void> getCurrentUser() async {
    try {
      final cUser = await Auth().getCurrentUser();

      final response = await Firestore.instance
          .collection("users")
          .document(cUser.uid)
          .get();

      _currentUser = Connection(
        id: cUser.uid,
        name: response.data["full_name"],
        email: cUser.email,
        role: response.data["role"],
        userName: response.data["user_name"],
        imageUrl: response.data["image_url"] ?? "NA",
      );
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> updateProfile(Map<String, String> data) async {
    try {
      await Firestore.instance
          .collection("users")
          .document(_currentUser.id)
          .updateData(data);
    } catch (e) {
      throw e;
    }
  }
}
