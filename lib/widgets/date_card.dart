import 'package:flutter/material.dart';

const Color textColor = Color.fromRGBO(0, 79, 255, 1);
const Color subTextColor = Color.fromRGBO(62, 134, 255, 1);

class DateCard extends StatelessWidget {
  double _height, _width;

  DateCard(
    this._height,
    this._width,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
        height: _height * 0.08,
        width: _width * 0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_width * 0.05),
        ),

        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(_width*0.02),topRight:Radius.circular(_width*0.02) ),
                ),
                child: Center(
                  child: Text("2",
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 28)),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(_width*0.02),bottomRight:Radius.circular(_width*0.02) ),
                ),
                child: Center(
                  child: Text("JUN",
                      style: TextStyle(
                          color: subTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18)),
                ),
              ),
            ),
          ],
        ));
  }
}
