import 'package:flutter/material.dart';

import 'see_more.dart';
import '../widgets/dashboard_drawer.dart';
import '../widgets/choicechip.dart';
import '../widgets/choose_category_item.dart';
import '../widgets/recommended_items_list.dart';
import '../widgets/slider.dart';

class DashBoard extends StatelessWidget {
  static const route = "/dashboard_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // for appBar search and menu
      drawer: DashBoardDrawer(),
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CarouselSlide(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //this is for choose category horizontal listview
                  Text(
                    "Choose a Category",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  
                  ChoiceChipItems(),

                  SizedBox(
                    height: 10,
                  ),

                  ChooseItems(),

                  SizedBox(
                    height: 5,
                  ),

                  //for more button
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(SeeMore.route);
                          },
                          child: Text(
                            "See More",
                            style: Theme.of(context)
                                .textTheme
                                .body2
                                .copyWith(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //this one is for trending horizontal listview
                  SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Recommended for you",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RecommendedItemsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
