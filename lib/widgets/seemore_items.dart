import 'package:event/widgets/date_card.dart';
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.near_me, color: Colors.blue),
                      Text(
                        "Place",
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.black.withOpacity(0.8)),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: _height * 0.05,
                        width: _height * 0.05,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    NetworkImage(_dashItems[index].eventImage),
                                fit: BoxFit.cover)),
                      ),
                      ChoiceChip(
                        label: Text("+325",
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(color: Color.fromRGBO(2, 0, 121, 1))),
                        selected: true,
                        selectedColor: Colors.blue[50],
                      ),
                      SizedBox(width: 2),
                      Text(
                        "Interested",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.black.withOpacity(0.4)),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}