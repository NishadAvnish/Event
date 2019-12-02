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

  _getData() {
    Future.delayed(Duration(seconds: 0)).then((_) {
      Provider.of<SeeMoreProvider>(context, listen: false).fetchSeeMoreData();
    }).then((_) {
      setState(() {
        isLoading = false;
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
    _items = Provider.of<SeeMoreProvider>(context).seeMoreItems;

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
        body: ListView.separated(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed(EventDetail.route, arguments: _items[index].id),
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SeeMoreItems(_items, index),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: _height * 0.002);
          },
        ));
  }
}
