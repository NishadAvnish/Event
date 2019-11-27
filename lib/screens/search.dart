import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/widgets/recommande_fav_itesm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearch=false;
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite"),
      ),

      
    );
  }
}