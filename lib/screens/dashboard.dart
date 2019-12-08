import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'see_more.dart';
import '../widgets/dashboard_drawer.dart';
import '../widgets/choicechip.dart';
import '../widgets/choose_category_item.dart';
import '../widgets/slider.dart';
import '../provider/helper_provider.dart';
import '../widgets/recommended_items.dart';

class DashBoard extends StatefulWidget {
  static const route = "/dashboard_screen";

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool isRebuildReq;
  @override
  void didChangeDependencies() {
    isRebuildReq = Provider.of<ReLoadingData>(context).isRebuildReg;
    super.didChangeDependencies();
  }

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
            CarouselSlide(isRebuildReq: isRebuildReq),
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

                  ChoiceChipItems(isRebuildReq: isRebuildReq),

                  SizedBox(
                    height: 10,
                  ),

                  ChooseItems(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeeMore(),
                                maintainState: true),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 8,
                          ),
                          child: Text(
                            "See More",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
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
                  RecommendedItemsList(isRebuildReq: isRebuildReq),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
