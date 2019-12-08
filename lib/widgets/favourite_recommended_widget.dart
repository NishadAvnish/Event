import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/dashboard_model.dart';
import '../provider/dash_board_provider.dart';
import '../provider/favouite_provider.dart';
import '../screens/event_detail.dart';

class FavouriteRecommendedItem extends StatelessWidget {
  final DashboardDataModel _event;
  final int _flag;

  FavouriteRecommendedItem(this._event, this._flag);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(EventDetail.route, arguments: _event.id),
      child: Card(
        margin: EdgeInsets.all(2.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_width * 0.035),
        ),
        elevation: 1,
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
                  height: _flag == 3 ? _height * 0.15 : _height * 0.2,
                  width: _flag == 3 ? _width * 0.3 : _width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      fadeInCurve: Curves.ease,
                      fit: BoxFit.fill,
                      placeholder: "asset/images/place.jpg",
                      image: _event.eventImage,
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
                    Text(
                        _event.eventName.length > 11
                            ? _event.eventName.substring(0, 5) + "..."
                            : _event.eventName,
                        style: Theme.of(context).textTheme.subtitle),
                    IconButton(
                      icon: _event.isfavourite
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : Icon(Icons.favorite_border, color: Colors.red),
                      onPressed: () {
                        //flag==3 means the parent is Favourite screen
                        if (_flag == 3) {
                          Provider.of<FavouriteProvider>(context)
                              .deleteDatafromList(_event.id);
                        }
                        bool _isFavourite = _event.isfavourite ? true : false;
                        _isFavourite = !_isFavourite;
                        Provider.of<RecommandedProvider>(context, listen: false)
                            .toggleFavourite(
                                _event.id, _event.seenBy, _isFavourite, _flag);
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
