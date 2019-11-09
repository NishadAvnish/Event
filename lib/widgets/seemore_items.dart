import 'package:event/widgets/date_card.dart';
import 'package:event/widgets/see_more_bottom_tile.dart';
import 'package:flutter/material.dart';

class SeeMoreItems extends StatelessWidget {
  final _dashItems;
  final index;
  const SeeMoreItems(this._dashItems, this.index);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.longestSide;
    final _width = MediaQuery.of(context).size.shortestSide;
    return Padding(
      padding: EdgeInsets.only(
          left: _width * 0.02, right: _width * 0.02, top: _width * 0.02),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_width * 0.05)),
        child: Column(
          children: <Widget>[
            Container(
              height: _height * 0.3,
              width: _width,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_width * 0.05)),

                // for date and time

                child: Container(
                  height: _height * 0.27,
                  width: _width,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(_width * 0.05),
                          child: Image(
                              image: NetworkImage(_dashItems[index].eventImage),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                          left: _width * 0.05,
                          bottom: _height * 0.02,
                          child: Text(
                            "An International Event",
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .copyWith(color: Colors.white),
                          )),
                      Positioned(
                        left: _width * 0.04,
                        top: _height * 0.015,
                        child: DateCard(_height, _width),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: _width * 0.04, right: _width * 0.06),
              child: BottomTile(_dashItems,index),
            )
          ],
        ),
      ),
    );
  }
}
