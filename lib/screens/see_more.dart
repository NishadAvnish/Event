import 'package:event/models/see_more_model.dart';
import 'package:event/provider/see_more_provider.dart';
import 'package:event/widgets/seemore_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event_detail.dart';

class SeeMore extends StatefulWidget {
  static const String route = '/Seemore';
  @override
  _SeeMoreState createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  ScrollController _scrollController = ScrollController();
  List<SeeMoreModel> _items;
  bool isLoading = true;
  bool isItemPresent = true;

  _getData([String getMore]) {
    Future.delayed(Duration(seconds: 0)).then((_) {
      getMore == null
          ? Provider.of<SeeMoreProvider>(context).fetchSeeMoreData()
          : Provider.of<SeeMoreProvider>(context).fetchSeeMoreData(getMore);
    }).then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    print(isLoading);
    _getData();
    _scrollController.addListener(() {
      final maxExtent = _scrollController.position.maxScrollExtent;
      final currentPosition = _scrollController.position.pixels;
      final fetchingPosition = MediaQuery.of(context).size.height * 0.25;
      if (maxExtent - currentPosition <= fetchingPosition) if (isItemPresent) {
        _getData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    _items = Provider.of<SeeMoreProvider>(context).seeMoreItems;
    isItemPresent = Provider.of<SeeMoreProvider>(context).isItemPresent;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Provider.of<SeeMoreProvider>(context, listen: false).categoryValue,
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Expanded(
                    child: ListView.separated(
                  controller: _scrollController,
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Hero(
                      tag: "fromSeemore",
                      child: GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              EventDetail.route,
                              arguments: _items[index].id),
                          child: SeeMoreItems(_items, index)),
                    );
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
