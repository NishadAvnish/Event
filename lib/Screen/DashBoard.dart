import 'package:carousel_slider/carousel_slider.dart';
import 'package:event/Modal/ChoiceChipProvider.dart';
import 'package:event/Widget/choicechip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
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
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.01),
              ),
            ),
          ),

          Positioned(
            right: -_height * 0.12,
            top: -_height * 0.1,
            child: Container(
              width: _width,
              height: _height * 0.5,
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // for appBar search and menu
          Positioned(
            left: _width * 0.01,
            top: MediaQuery.of(context).padding.top,
            right: _width * 0.01,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: _height * 0.03,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    size: _height * 0.03,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),

          //Body
          Positioned(
            top: _height * 0.1,
            left: _width * 0.03,
            right: _width * 0.03,
            child: Container(
              height: _height * 0.9,
              width: _width,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CarouselSlider(
                          pauseAutoPlayOnTouch: Duration(milliseconds: 6000),
                          viewportFraction: 1.0,
                          height: _height * 0.26,
                          autoPlay: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayInterval: Duration(milliseconds: 6000),
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
                          height: _height * 0.018,
                        ),

                        //this is for choose category horizontal listview
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Choose",
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                                Text(
                                  "a category",
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ],
                            ),
                            ChoiceChipItems(),
                          ],
                        ),
                        SizedBox(
                          height: _height * 0.002,
                        ),
                        Container(
                          height: _height * 0.2,
                          width: _width,
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: _width * 0.01,
                              );
                            },
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: <Widget>[
                                  Container(
                                    height: _height * 0.22,
                                    width: _width * 0.5,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(_width * 0.035),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "Asset/Image/pic1.jpg")),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        SizedBox(
                          height: _height * 0.01,
                        ),

                        //for more button
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "See More",
                                style: Theme.of(context)
                                    .textTheme
                                    .body2
                                    .copyWith(color: Colors.red),
                              ),
                            ],
                          ),
                        ),

                        //this one is for trending horizontal listview
                        SizedBox(
                          height: _height * 0.015,
                        ),

                        Text(
                          "Recommanded for you",
                          style: Theme.of(context).textTheme.subtitle,
                        ),

                        SizedBox(
                          height: _height * 0.02,
                        ),

                        Container(
                          height: _height * 0.27,
                          width: _width,
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: _width * 0.02,
                              );
                            },
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                width: _width * 0.35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(_width * 0.035),
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
                                          borderRadius: BorderRadius.circular(
                                              _width * 0.035),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "Asset/Image/pic2.jpg")),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: _height * 0.005,
                                          right: 0,
                                         ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Name",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle),

                                           IconButton(
                                             icon: Icon(Icons.favorite_border,color:Colors.red),
                                             onPressed: (){
                                               //favourite button
                                             },
                                           ),       
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.03,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          /*
          // for bottom sheet
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            bottom: 0,
            child: Container(
              height: _height * 0.37,
              width: _width,
              child: Stack(children: <Widget>[
                
                Positioned(
                  top: _height * 0.005,
                  bottom: 0,
                  child: Container(
                    
                    width: _width,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(_height * 0.035),
                          topRight: Radius.circular(_height * 0.035)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: _height * 0.01,
                    width: _width * 0.15,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
              

              ]),
            ),
          )
          */
        ],
      ),
    );
  }
}
