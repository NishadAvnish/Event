import 'package:event/models/dashboard_model.dart';
import 'package:event/screens/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/dash_board_provider.dart' show RecommandedProvider;

class HelperFunction {
  recFavItems(BuildContext context, DashboardDataModel _list,int flag) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(EventDetail.route, arguments: _list.id),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_width * 0.035),
        ),
        elevation: 10,
        child: Container(
          width:_width * 0.4,
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
                  height: flag==3?_height*0.15:_height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_width * 0.035),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(_list.eventImage)
                        ),
                  ),
                  child: FadeInImage.assetNetwork(
                    fadeInCurve: Curves.ease,
                    fit: BoxFit.cover,
                    placeholder:"asset/images/place.jpg",
                    image:_list.eventImage,
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
                    Text(_list.eventName.length>11?_list.eventName.substring(0,9)+"...":_list.eventName,
                        style: Theme.of(context).textTheme.subtitle),
                    IconButton(
                      icon: _list.isfavourite
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : Icon(Icons.favorite_border, color: Colors.red),
                      onPressed: () {
                        bool _isFavourite = _list.isfavourite ? true : false;
                        _isFavourite = !_isFavourite;
                        Provider.of<RecommandedProvider>(context, listen: false).toggleFavourite(
                                _list.id, _list.seenBy, _isFavourite, flag);
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
