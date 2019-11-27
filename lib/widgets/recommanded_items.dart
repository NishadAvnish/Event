import 'package:event/provider/dash_board_provider.dart';
import 'package:event/provider/helper_provider.dart';
import 'package:event/widgets/recommande_fav_itesm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecommandedItem extends StatelessWidget {
  final bool isRebuildReq;
  FirebaseUser userId;

  RecommandedItem({Key key, this.isRebuildReq}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    bool _isFavourite;
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
              Provider.of<LoadingData>(context).isRebuild =
                  false; //setting the rebuild to false
              return Consumer<RecommandedProvider>(
                  builder: (ctx, dashbo, child) {
                return ListView.builder(
                  itemCount: dashbo.recommandedItems.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return  HelperFunction().recFavItems(context,dashbo.recommandedItems[index],1);
                  },
                );
              });
            }
          }),
    );
  }
}
