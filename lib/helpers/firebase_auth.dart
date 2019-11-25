import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/models/new_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

abstract class BaseAuth {
  Future<FirebaseUser> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return result.user;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    FirebaseUser user = result.user;

    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    return user.isEmailVerified;
  }

  Future<void> checkIfUsernameExists(String userName) async{
    final response = await Firestore.instance.collection("users").where("user_name", isEqualTo: userName).getDocuments();
    if(response.documents.isNotEmpty)
      throw PlatformException(
        code: "USER_NAME_EXISTS",
        message: "User name already exists.",
      );
  }

  Future<void> addUserToDatabase(String userId,NewUser newUser) async {

    final Map<String, dynamic> userData = {
      "full_name" : newUser.fullName,
      "user_name" : newUser.userName,
      "email" : newUser.email,
      "role" : newUser.role,
    };

    try {
      await Firestore.instance.collection("users").document(userId).setData(userData);
    } catch (error) {
      throw error;
    }
  }

}
