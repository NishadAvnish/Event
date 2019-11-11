import 'package:event/provider/event_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DottedBox extends StatefulWidget {
  int index;

   DottedBox({Key key, this.index});

  @override
  _DottedBoxState createState() => _DottedBoxState();
}

class _DottedBoxState extends State<DottedBox> {
  PageController _pageController;
  ScrollController _scrollController;

  @override
  void initState() {
    _pageController=PageController(initialPage: widget.index);
    _scrollController=ScrollController();
   
    super.initState();
  }
  
  @override
  void dispose() {
     _pageController.dispose();
     _scrollController.dispose();

    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final _height=MediaQuery.of(context).size.height;
    final _width=MediaQuery.of(context).size.width;
    final _item = Provider.of<EventDetailProvider>(context).item;
    return  Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: LimitedBox(
                            maxHeight: _height * 0.36,
                            child: PageView.builder(
                              onPageChanged: (value) {
                                setState(() {
                                  widget.index = value;
                                });
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: _item[0].eventImageUrls.length,
                              controller: _pageController,
                              itemBuilder: (context, index) => Container(
                                height: _height * 0.36,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        _item[0].eventImageUrls[index],
                                      ),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft:
                                          Radius.circular(_width * 0.1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            left: _width * 0.06,
                            bottom: _width * 0.02,
                            child: LimitedBox(
                              maxWidth: _width * 0.2, //0.2
                              maxHeight: _height * 0.02,
                              child: ListView(
                                controller:_scrollController,
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                    _item[0].eventImageUrls.length , (i) {
                                  return widget.index == i
                                      ? Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                        )
                                      : Container(
                                          height: 8,
                                          width: 8,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                        );
                                }),
                              ),
                            ))
                      ],
                    
    );
  }
}