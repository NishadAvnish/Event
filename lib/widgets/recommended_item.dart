import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dash_board_provider.dart';
import '../screens/event_detail.dart';

class RecommendedItem extends StatelessWidget {
  final int _index;
  RecommendedItem(this._index);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.shortestSide;
    final _height = MediaQuery.of(context).size.longestSide;
    final recommendedItemsList =
        Provider.of<RecommandedProvider>(context).recommandedItems;

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(EventDetail.route,
          arguments: recommendedItemsList[_index].id),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_width * 0.035),
        ),
        child: Container(
          width: _width * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_width * 0.035),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: _height * 0.005,
                    left: _height * 0.005,
                    right: _height * 0.005),
                child: Container(
                  height: _height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_width * 0.035),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage(recommendedItemsList[_index].eventImage),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: _height * 0.005,
                  right: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(recommendedItemsList[_index].eventName,
                        style: Theme.of(context).textTheme.subtitle),
                    IconButton(
                      icon: Icon(Icons.favorite_border, color: Colors.red),
                      onPressed: () {
                        //favourite button
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
