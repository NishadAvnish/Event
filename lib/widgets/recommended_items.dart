import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dash_board_provider.dart';
import '../provider/helper_provider.dart';
import 'favourite_recommended_widget.dart';

class RecommendedItemsList extends StatelessWidget {
  final bool isRebuildReq;

  RecommendedItemsList({Key key, this.isRebuildReq}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height * 0.28,
      width: _width,
      child: FutureBuilder(
          future: isRebuildReq
              ? Provider.of<RecommandedProvider>(context, listen: false)
                  .recommandedFetch()
              : null,
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            } else if (snapShot.error != null)
              return Align(
                  alignment: Alignment.center,
                  child: Text(
                    "An Error Occurs",
                    style: Theme.of(context).textTheme.body2,
                  ));
            else {
              Provider.of<ReLoadingData>(context).setRebuildReq=
                  false; //setting the rebuild to false to avoid rebuilding of widget 
              return Consumer<RecommandedProvider>(
                  builder: (ctx, dashbo, child) {
                return ListView.builder(
                  itemCount: dashbo.recommandedItems.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return  FavouriteRecommendedItem(dashbo.recommandedItems[index],1);
                  },
                );
              });
            }
          }),
    );
  }
}
