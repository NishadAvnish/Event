import 'package:carousel_slider/carousel_slider.dart';
import 'package:event/provider/dash_board_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarouselSlide extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
     final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    
    final _carousel= Provider.of<CarouselProvider>(context);
    final _carouselItem=_carousel.carouselItem;
    return StreamBuilder(
                  stream:_carousel.carouselFetch().asStream() ,
                  builder:(context,snapshot) =>CarouselSlider(
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
            );
            
  }
}