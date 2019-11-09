import 'package:flutter/material.dart';

class SeeMore extends StatefulWidget {

  @override
  _SeeMoreState createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.shortestSide;
    final _height = MediaQuery.of(context).size.longestSide;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.menu,color: Colors.black,),iconSize: _width*0.05, onPressed: () {},),
        title:Text("CATEGORY",style: TextStyle(color: Colors.black),) ,
        centerTitle: true,
        actions: <Widget>[IconButton(icon:Icon(Icons.search,color: Colors.black, ), onPressed: () {},),],
      ),

      body: Container(),
     
    );
  }
}