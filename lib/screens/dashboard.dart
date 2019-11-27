import 'package:event/provider/helper_provider.dart';
import 'package:event/widgets/choicechip.dart';
import 'package:event/widgets/choose_category_item.dart';
import 'package:event/widgets/recommanded_items.dart';
import 'package:event/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'see_more.dart';
import '../widgets/dashboard_drawer.dart';

class DashBoard extends StatefulWidget {
  static const route = "/dashboard_screen";

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool isRebuildReq;
  @override
  void didChangeDependencies() {
    isRebuildReq = Provider.of<LoadingData>(context).isRebuildReg;
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

                  SizedBox(
                    height: 5,
                  ),

                  //for more button

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          //Navigator.of(context).pushNamed(SeeMore.route);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SeeMore(),
                                  maintainState: true));
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

                  //this one is for recommended horizontal listview
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
                  RecommandedItem(isRebuildReq: isRebuildReq),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
