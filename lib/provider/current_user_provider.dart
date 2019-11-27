import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/firebase_auth.dart';
import '../models/connection_model.dart';

class CurrentUserProvider with ChangeNotifier {
  Connection _currentUser;

  Connection get currentUser{
    return _currentUser;
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
        imageUrl:
            "https://images.pexels.com/photos/772571/pexels-photo-772571.jpeg?cs=srgb&dl=beautiful-bees-bloom-772571.jpg&fm=jpg",
      );
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
