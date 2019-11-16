import 'package:carousel_slider/carousel_slider.dart';
import 'package:event/provider/dash_board_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarouselSlide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return StreamBuilder(
        stream: Provider.of<CarouselProvider>(context, listen: false)
            .carouselFetch()
            .asStream(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            print(snapShot.connectionState);
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          } else if (snapShot.error != null)
            return Align(
                alignment: Alignment.center,
                child: Text(
                  "An Error Occurs",
                  style: Theme.of(context).textTheme.body2,
                ));
          else
            return Consumer<CarouselProvider>(
                builder: (ctx, doc, child) => CarouselSlider(
                      pauseAutoPlayOnTouch: Duration(milliseconds: 1000),
                      viewportFraction: 1.0,
                      height: _height * 0.26,
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayInterval: Duration(milliseconds: 3000),
                      items: doc.carouselItem.map((image) {
                        return Container(
                          width: _width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(image),
                            fit: BoxFit.fill,
                          )),
                        );
                      }).toList(),
                    ));
        });
  }
}
