import 'package:event/models/see_more_model.dart';
import 'package:event/provider/see_more_provider.dart';
import 'package:event/widgets/seemore_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event_detail.dart';


class SeeMore extends StatefulWidget {
  static const String route='/Seemore';
  @override
  _SeeMoreState createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  ScrollController _scrollController=ScrollController();
  List<SeeMoreModel> _items;
  bool isLoading=false;
 bool isItemPresent=true;
  
  _getData([String getMore]){
    Future.delayed(Duration(seconds:0)).then((_){ getMore==null?Provider.of<SeeMoreProvider>(context).fetchSeeMoreData():Provider.of<SeeMoreProvider>(context).fetchSeeMoreData(getMore);});
  }

  @override
  void initState() {
    _getData();
    _scrollController.addListener((){
          final maxExtent=_scrollController.position.maxScrollExtent;
          final currentPosition=_scrollController.position.pixels;
          final fetchingPosition=MediaQuery.of(context).size.height*0.25;
          if(maxExtent-currentPosition<=fetchingPosition) 
          if(isItemPresent){_getData();}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.shortestSide;
    final _height = MediaQuery.of(context).size.longestSide;
    _items = Provider.of<SeeMoreProvider>(context).seeMoreItems;
     isItemPresent=Provider.of<SeeMoreProvider>(context).isItemPresent;
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          iconSize: _width * 0.05,
          onPressed: () {},
        ),
        title: Text(
          "CATEGORY",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body:isLoading?Center(child:Text("Loading....")):Column(
        children: <Widget>[
          Expanded(
              child: ListView.separated(
                controller: _scrollController,
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return GestureDetector(onTap: () => Navigator.of(context)
                              .pushNamed(EventDetail.route),child: SeeMoreItems(_items, index));
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
