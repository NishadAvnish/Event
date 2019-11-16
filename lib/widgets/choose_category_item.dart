
import 'package:event/provider/choice_chip_provider.dart';
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
    final _height=MediaQuery.of(context).size.height;
    final _width=MediaQuery.of(context).size.width;
    final _items=Provider.of<DashBoardProvider>(context).CategoryItems;
    return 
        Container(
                      height: _height * 0.2,
                      width: _width,
                      child: ListView.separated( 
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: _width * 0.01,
                          );
                        },
                        itemCount: _items.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          
                          return  InkWell(
                            onTap: ()  {
                              print(_items[index].id);
                              Navigator.of(context)
                                .pushNamed(EventDetail.route,arguments: _items[index].id);},
                            child: Container(
                              height: _height * 0.22,
                              width: _width * 0.5,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(_width * 0.035),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(_width * 0.035),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                               _items[index].eventImage)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      left: _width * 0.05,
                                      bottom: _height * 0.02,
                                      child: Text(
                                        _items[index].eventName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subhead
                                            .copyWith(color: Colors.white),
                                      )),
                                ],
                              ),
                            ),
                          );

                        },
                      ),
                    );}
}