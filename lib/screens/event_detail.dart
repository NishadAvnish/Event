
import 'package:event/widgets/event_detail_speakers_listitems.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatefulWidget {
  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {


  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Container(
      height: _height,
      width: _width,
      child: Stack(children: <Widget>[
        Positioned.fill(
          child: Container(
            color: Colors.white,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: LimitedBox(
            maxHeight: _height,
            child:
                ListView(padding: EdgeInsets.only(top: 0), children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: _height * 0.36,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1555445091-5a8b655e8a4a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(_width * 0.1)),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.all(_width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        //details of the event include body,title,seen by etc from line 57 to 100
                        Text(
                          "Name of the event",
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .copyWith(fontSize: _height * 0.04),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "21 october 2019",
                              style: Theme.of(context).textTheme.body2.copyWith(
                                  fontSize: _height * 0.02,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.remove_red_eye,
                                      color: Colors.black),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "321 ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .body2
                                        .copyWith(
                                            fontSize: _height * 0.02,
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                  ),
                                ]),
                          ],
                        ),
                        SizedBox(
                          height: _height * 0.03,
                        ),
                        Text(
                          "Wikipedia was launched on January 15, 2001, by Jimmy Wales and Larry Sanger.[13] Sanger coined its name,[14][15] as a portmanteau of  (the Hawaiian word for  and . While it was Initially an English-language encyclopedia, versions in other languages were quickly developed. With at least 5,967,345 articles,[note 3] the English Wikipedia is the largest of the more than 290 Wikipedia encyclopedias. Overall, Wikipedia comprises more than 40 million articles in 301 different languages[17] and by February 2014 it had reached 18 billion page views and nearly 500 million unique visitors per month.[18]",
                          style: Theme.of(context).textTheme.body2,
                        ),

                      //This is for speaker list form 104 to 123
                        SizedBox(
                          height: _height * 0.02,
                        ),
                        Text("Speakers",
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .copyWith(fontSize: _height * 0.028)),
                        Container(
                          height: _height * 0.14,
                          width: _width,
                          child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(width: _width * 0.01);
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return SpeakerList(index);
                              }),
                        ),

                        SizedBox(
                          height: _height * 0.02,
                        ),

                        //this is for showing about auther details
                        
                        Text("Authors",
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .copyWith(fontSize: _height * 0.028)),
                        SizedBox(
                          height: _height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: _width * 0.03),
                          child: Container(
                            height: _height * 0.09,
                            width: _height * 0.09,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "https://images.unsplash.com/photo-1555445091-5a8b655e8a4a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        )
      ]),
    );
  }

  
}
