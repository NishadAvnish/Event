import 'package:event/models/see_more_model.dart';
import 'package:flutter/material.dart';

class BottomTile extends StatelessWidget {
  final List<SeeMoreModel> _items;
  final int index;
  BottomTile(this._items,this.index);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.longestSide;
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.near_me, color: Colors.blue),
                      Text(
                        "${_items[index].place}",
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.black.withOpacity(0.8)),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                     
                      ChoiceChip(
                        label: Text("${_items[index].totalSeen} +",
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
              );
  }
}