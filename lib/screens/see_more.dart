import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_detail.dart';
import '../models/see_more_model.dart';
import '../provider/see_more_provider.dart';
import '../widgets/see_more_app_bar.dart';
import '../widgets/seemore_items.dart';

class SeeMore extends StatefulWidget {
  static const String route = '/Seemore';
  @override
  _SeeMoreState createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  ScrollController _scrollController = ScrollController();
  List<SeeMoreModel> _items;
  bool _isLoading = true;
  bool _isItemPresent = true;

  void _getData([String getMore]) {
    Future.delayed(Duration(seconds: 0)).then((_) {
      getMore == null
          ? Provider.of<SeeMoreProvider>(context,listen: false).fetchSeeMoreData()
          : Provider.of<SeeMoreProvider>(context,listen: false).fetchSeeMoreData(getMore);
    }).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    print(_isLoading);
    _getData();
    _scrollController.addListener(() {
      final maxExtent = _scrollController.position.maxScrollExtent;
      final currentPosition = _scrollController.position.pixels;
      final fetchingPosition = MediaQuery.of(context).size.height * 0.25;
      if (maxExtent - currentPosition <= fetchingPosition) if (_isItemPresent) {
        _getData();
      }
    });
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.longestSide;
    _items = Provider.of<SeeMoreProvider>(context).seeMoreItemsToShow;
    _isItemPresent = Provider.of<SeeMoreProvider>(context, listen: false).isItemPresent;

    return Scaffold(
      appBar: PreferredSize(
        child: SeeMoreAppBar(),
        preferredSize: Size(double.infinity, _height * 0.07),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(
                          EventDetail.route,
                          arguments: _items[index].id),
                      child: SeeMoreItem(_items, index),
                    );
                  },
                )),
              ],
            ),
    );
  }
}
