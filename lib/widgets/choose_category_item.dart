import 'package:event/provider/dash_board_provider.dart';
import 'package:event/screens/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseItems extends StatefulWidget {
  @override
  _ChooseItemsState createState() => _ChooseItemsState();
}

class _ChooseItemsState extends State<ChooseItems> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Container(
      height: _height * 0.2,
      width: _width,
      child: Consumer<DashBoardProvider>(
        builder: (ctx, dashBo, child) => ListView.builder(
          itemCount: dashBo.categoryItems.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(EventDetail.route,
                    arguments: {"flag":2,"id":dashBo.categoryItems[index].id});
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_width * 0.035),
                ),
                child: Container(
                  height: _height * 0.22,
                  width: _width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_width * 0.035),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_width * 0.035),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  dashBo.categoryItems[index].eventImage),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 0,
                          bottom: _height * 0.02,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            width: _width * 0.4,
                            color: Colors.black54,
                            child: Text(
                              dashBo.categoryItems[index].eventName,
                              style: Theme.of(context)
                                  .textTheme
                                  .subhead
                                  .copyWith(color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
