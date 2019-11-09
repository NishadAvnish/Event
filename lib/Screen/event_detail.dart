import 'package:flutter/material.dart';

class EventDetail extends StatefulWidget {

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    final _height=MediaQuery.of(context).size.height;
    final _width=MediaQuery.of(context).size.width;

    return Scaffold(
       body:Column(
         children: <Widget>[
          Stack(
            Positioned.fill(
              child: Container(
                color: Colors.blueAccent,
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,

              child:Container(
                height: _height*0.36,
                decoration: BoxDecoration(color: Colors.red,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(_width*0.1)),
                ),
              ),
            )
          )
         ]
       ),
    );
  }
}