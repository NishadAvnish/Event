import '../widgets/event_image_url_item.dart';
import 'package:flutter/material.dart';

class EventImageUrlList extends StatefulWidget {
  final List<String> _urlsList;
  final Function _addUrl;
  EventImageUrlList(this._urlsList, this._addUrl);

  @override
  _EventImageUrlListState createState() => _EventImageUrlListState();
}

class _EventImageUrlListState extends State<EventImageUrlList> {
  @override
  Widget build(BuildContext context) {
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
              icon: Icon(
                Icons.add,
              ),
              label: Text("Add URL"),
              onPressed: () {
                setState(() {
                  widget._addUrl("");
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
              children: widget._urlsList.map((url) => EventImageUrlItem(url)).toList()
            ),
          ),
        ),
      ],
    );
  }
}
