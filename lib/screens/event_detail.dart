import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../provider/event_detail_provider.dart';
import 'user_profile.dart';
import '../widgets/dottedBox.dart';
import '../widgets/event_detail_speakers_listitems.dart';
import '../provider/dash_board_provider.dart';

class EventDetail extends StatefulWidget {
  static const route = "/event_screen";
  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  int index = 0;
  bool isLoading = true;
  String id;
  int i = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds:0)).then((_)=>_eventFetch());
    
  }
 

  void _eventFetch() async {
    final id = ModalRoute.of(context).settings.arguments as String;
    await Provider.of<EventDetailProvider>(context, listen: false)
        .eventFetch(id);

    if (!mounted) return;    
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    final _item = Provider.of<EventDetailProvider>(context).item;
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
          left: 0,
          right: 0,
          top: 0,
          child: LimitedBox(
            maxHeight: _height,
            child: isLoading
                ? Center(
                    child: Text(
                      "Loading...",
                      style: Theme.of(context).textTheme.body2,
                    ),
                  )
                : ListView(padding: EdgeInsets.only(top: 0), children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        LimitedBox(
                          maxHeight: _height * 0.36,
                          child: DottedBox(
                            index: index,
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
                              ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxWidth: _width * 0.8),
                                child: Text(
                                  "${_item[0].title}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline
                                      .copyWith(fontSize: _height * 0.04),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "${DateTime.parse(_item[0].date).toString().split(".")[0]}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .body2
                                        .copyWith(
                                            fontSize: _height * 0.02,
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Material(
                                          color: Colors.transparent,
                                          child: IconButton(
                                            icon: _item[0].isFavorite
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.red,
                                                  ),
                                            onPressed: () {
                                              bool _isFavourite =_item[0].isFavorite ? true : false;
                                              _isFavourite =!_isFavourite;
                                              Provider.of<EventDetailProvider>(context,listen: false)
                                                  .toggleFavourite(
                                                      _item[0].id,
                                                      _item[0].seenBy,
                                                      _isFavourite);
                                              Provider.of<RecommandedProvider>(
                                                      context,
                                                      listen: false)
                                                  .toggleFavourite(
                                                      _item[0].id,
                                                      _item[0].seenBy,
                                                      _isFavourite,
                                                      2);
                                                   
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${_item[0].seenBy} ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .body2
                                              .copyWith(
                                                  fontSize: _height * 0.02,
                                                  color: Colors.black
                                                      .withOpacity(0.5)),
                                        ),
                                      ]),
                                ],
                              ),
                              SizedBox(
                                height: _height * 0.03,
                              ),
                              Text(
                                "${_item[0].description}",
                                style: Theme.of(context).textTheme.body2,
                              ),

                              //This is for speaker list form 104 to 123
                              SizedBox(
                                height: _height * 0.02,
                              ),
                              Text("Hosts",
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
                                    itemCount: _item[0].speakerList.length,
                                    itemBuilder: (context, index) {
                                      return SpeakerList(
                                          index, _item[0].speakerList);
                                    }),
                              ),

                              SizedBox(
                                height: _height * 0.02,
                              ),

                              //this is for showing about auther details

                              Text("Author",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline
                                      .copyWith(fontSize: _height * 0.028)),
                              SizedBox(
                                height: _height * 0.01,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: _width * 0.03),
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).pushNamed(
                                      UserProfile.route,
                                      arguments: _item[0].createrId),
                                  child: Container(
                                    height: _height * 0.09,
                                    width: _height * 0.09,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              "${_item[0].authorImageUrl}",
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
          ),
        ),
        Positioned(
          left: 8,
          top: MediaQuery.of(context).padding.top + 2,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
            child: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                size: 35,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        Positioned(
          right: 8,
          top: MediaQuery.of(context).padding.top + 2,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
            child: GestureDetector(
              child: Icon(
                Icons.share,
                size: 30,
              ),
              onTap: () {
                Share.share("this is our first application");
              },
            ),
          ),
        ),
      ]),
    );
  }
}
