import 'package:event/models/see_more_model.dart';
import 'package:flutter/material.dart';

const Color textColor = Color.fromRGBO(0, 79, 255, 1);
const Color subTextColor = Color.fromRGBO(62, 134, 255, 1);

enum monthEnum {
  Jan,
  Feb,
  March,
  April,
  May,
  June,
  July,
  Aug,
  Sept,
  Oct,
  Nov,
  Dec
}

class DateCard extends StatelessWidget {
  final double _height, _width;
  final int index;
  final List<SeeMoreModel> _items;
  
  DateCard(
    this._height,
    this._width, this.index, this._items,
  );

  @override
  Widget build(BuildContext context) {
    var _gen=DateTime.parse(_items[index].timeLine).month;
    var _month=(monthEnum.values[_gen-1]).toString().split(".")[1];
    int _day=DateTime.parse(_items[index].timeLine).day;
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
                  child: Text("$_day",
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
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
                  child: Text("$_month",
                      style: TextStyle(
                          color: subTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ),
              ),
            ),
          ],
        ));
  }
}
