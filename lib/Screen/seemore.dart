import 'package:event/Modal/ChoiceChipProvider.dart' show DashBoardProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum monthDay {
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

class SeeMore extends StatefulWidget {
  @override
  _SeeMoreState createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.shortestSide;
    final _height = MediaQuery.of(context).size.longestSide;
    final _dashItems = Provider.of<DashBoardProvider>(context).dashdataItems;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          iconSize: _width * 0.05,
          onPressed: () {},
        ),
        title: Text(
          "CATEGORY",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.separated(
            itemCount: _dashItems.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: _width * 0.02),
                height: _height * 0.26,
                width: _width,
                
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_width * 0.05)),
                  // for date and time    
                  child: Stack(
                    children: <Widget>[

                      Positioned.fill(child:Container(
                        height: _height * 0.26,
                        width: _width,
                        decoration: BoxDecoration(
                        image: DecorationImage(image:NetworkImage(_dashItems[index].eventImage),fit: BoxFit.cover),
                        ),
                       ),
                      ), 
                      
                      
                      Positioned(
                          left: _width * 0.02,
                          top: _height * 0.002,
                          child: Container(
                            height: _height * 0.07,
                            width: _width * 0.1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[Container()],
                            ),
                          ))
                    ],
                  ),

                
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: _height * 0.03);
            },
          )),
        ],
      ),
    );
  }
}
