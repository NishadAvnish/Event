import 'package:event/provider/see_more_provider.dart';
import 'package:event/widgets/seemore_items.dart';

import '../provider/choice_chip_provider.dart' show DashBoardProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SeeMore extends StatefulWidget {
  static const String route='/Seemore';
  @override
  _SeeMoreState createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.shortestSide;
    final _height = MediaQuery.of(context).size.longestSide;
    final _items = Provider.of<SeeMoreProvider>(context).seeMoreItems;

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
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return SeeMoreItems(_items, index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: _height * 0.002);
            },
          )),
        ],
      ),
    );
  }
}
