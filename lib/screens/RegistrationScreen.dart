import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.longestSide;
    final _width = MediaQuery.of(context).size.shortestSide;
    
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: _height * 0.11, left: _width * 0.1, right: _width * .1),
        child: Column(
          children: <Widget>[

            Text("WELCOME", style:TextStyle(fontSize: _height*0.07,color: Colors.deepOrange[300]),),

            SizedBox(height: _height*0.05,),

            Card(
              elevation: 10,
              child: Container(
                height: _height * 0.6,
                width: double.infinity,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
