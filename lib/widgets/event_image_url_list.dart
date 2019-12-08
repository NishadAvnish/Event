import '../provider/event_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/event_image_url_item.dart';
import 'package:flutter/material.dart';

class EventImageUrlList extends StatefulWidget {
  @override
  _EventImageUrlListState createState() => _EventImageUrlListState();
}

class _EventImageUrlListState extends State<EventImageUrlList> {
  @override
  Widget build(BuildContext context) {
    final _event = Provider.of<EventProvider>(context).event;

    print("building");
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Event Image URLs",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FlatButton.icon(
              color: Theme.of(context).primaryColorLight,
              icon: Icon(Icons.add),
              label: Text("Add"),
              onPressed: () {
                setState(() {
                  _event.eventImageUrls.add("");
                });
              },
            ),
          ],
        ),
        Container(
          height: 265,
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: _event.eventImageUrls
                    .map((url) =>
                        EventImageUrlItem(_event.eventImageUrls.indexOf(url)))
                    .toList()),
          ),
        ),
      ],
    );
  }
}
