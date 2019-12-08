import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/favouite_provider.dart';
import '../widgets/favourite_recommended_widget.dart';

class FavouriteScreen extends StatelessWidget {
  static const route = "/favourite_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Favourite"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height -
            kToolbarHeight -
            MediaQuery.of(context).padding.top,
        width: double.infinity,
        child: FutureBuilder(
            future: Provider.of<FavouriteProvider>(context, listen: false)
                .getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.error != null)
                return Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              else
                return Consumer<FavouriteProvider>(
                    builder: (_, favProd, child) => GridView.builder(
                          itemCount: favProd.favouriteList.length,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 180,
                            childAspectRatio: 2 / 2.78,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                          ),
                          itemBuilder: (context, index) {
                            return FavouriteRecommendedItem(
                              favProd.favouriteList[index],
                              3,
                            );
                          },
                        ));
            }),
      ),
    );
  }
}
