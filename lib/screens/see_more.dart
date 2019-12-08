import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_detail.dart';
import '../models/see_more_model.dart';
import '../provider/see_more_provider.dart';
import '../widgets/seemore_items.dart';
import '../widgets/see_more_app_bar.dart';

class SeeMore extends StatefulWidget {
  static const String route = '/Seemore';
  @override
  _SeeMoreState createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  ScrollController _scrollController = ScrollController();
  List<SeeMoreModel> _items;
  bool _isLoading = true;

  _getData() {
    Future.delayed(Duration(seconds: 0)).then((_) {
      Provider.of<SeeMoreProvider>(context, listen: false).fetchSeeMoreData();
    }).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    _items = Provider.of<SeeMoreProvider>(context).seeMoreItemsToShow;

    return Scaffold(
        appBar: PreferredSize(
          child: SeeMoreAppBar(),
          preferredSize: Size(double.infinity, _height * 0.07),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed(EventDetail.route, arguments: _items[index].id),
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SeeMoreItems(_items, index),
            );
          },
        ));
  }
}
