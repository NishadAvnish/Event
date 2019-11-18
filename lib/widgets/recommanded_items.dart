import 'package:event/provider/dash_board_provider.dart';
import 'package:event/screens/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecommandedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Container(
      height: _height * 0.28,
      width: _width,
      child: FutureBuilder(
          future: Provider.of<RecommandedProvider>(context, listen: false)
              .recommandedFetch(),
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
            else
              return Consumer<RecommandedProvider>(
                  builder: (ctx, dashbo, child) {
                return ListView.builder(
                  itemCount: dashbo.recommandedItems.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(
                          EventDetail.route,
                          arguments: dashbo.recommandedItems[index].id),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_width * 0.035),
                        ),
                        elevation: 10,
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
                                  height: _height * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(_width * 0.035),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(dashbo
                                            .recommandedItems[index]
                                            .eventImage)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: _height * 0.005,
                                  right: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                        dashbo
                                            .recommandedItems[index].eventName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle),
                                    IconButton(
                                      icon: Icon(Icons.favorite_border,
                                          color: Colors.red),
                                      onPressed: () {
                                        //favourite button
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
                  },
                );
              });
          }),
    );
  }
}
