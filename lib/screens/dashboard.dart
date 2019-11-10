import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'see_more.dart';
import '../widgets/dashboard_drawer.dart';
import '../widgets/choicechip.dart';
import '../provider/choice_chip_provider.dart';

class DashBoard extends StatefulWidget {
  static const route = "/dashboard_screen";
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.shortestSide;
    final _height = MediaQuery.of(context).size.longestSide;
    final _carouselItem = Provider.of<DashBoardProvider>(context).carouselItem;
    return Scaffold(
      // for appBar search and menu
      drawer: DashBoardDrawer(),
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CarouselSlider(
              pauseAutoPlayOnTouch: Duration(milliseconds: 1000),
              viewportFraction: 1.0,
              height: _height * 0.26,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayInterval: Duration(milliseconds: 3000),
              items: _carouselItem.map((image) {
                return Container(
                  width: _width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.fill,
                  )),
                );
              }).toList(),
            ),
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
                    style: Theme.of(context).textTheme.subtitle,
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  ChoiceChipItems(),

                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    height: _height * 0.2,
                    width: _width,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: _width * 0.01,
                        );
                      },
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
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
                                    borderRadius:
                                        BorderRadius.circular(_width * 0.035),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            AssetImage("asset/images/pic1.jpg")),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: _width * 0.05,
                                  bottom: _height * 0.02,
                                  child: Text(
                                    "Title",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subhead
                                        .copyWith(color: Colors.white),
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

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
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: _height * 0.28,
                    width: _width,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Card(
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
                                          image:
                                              AssetImage("asset/images/pic2.jpg")),
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
                                      Text("Name",
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
