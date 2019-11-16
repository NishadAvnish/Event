import 'package:event/screens/event_detail.dart';
import 'package:flutter/material.dart';

class RecommandedItem extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final _height=MediaQuery.of(context).size.height;
    final _width=MediaQuery.of(context).size.width;
    return  Container(
                    height: _height * 0.28,
                    width: _width,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return  GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed(EventDetail.route),
                                                  child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(_width * 0.035),
                            ),
                            elevation: 10,
                            child: Container(
                              width: _width * 0.4,
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
                                        borderRadius:
                                            BorderRadius.circular(_width * 0.035),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                "asset/images/pic2.jpg")),
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
                          ),
                        );;
                      },
                    ),
                  );
    
    
  }
}