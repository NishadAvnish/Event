import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_speaker_item.dart';
import '../models/event_detail_model.dart';
import '../provider/event_provider.dart';

class EventSpeakersList extends StatefulWidget {
  @override
  _EventSpeakersListState createState() => _EventSpeakersListState();
}

class _EventSpeakersListState extends State<EventSpeakersList> {
  @override
  Widget build(BuildContext context) {
    final _eventData = Provider.of<EventProvider>(context);

    print("building");
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Event Host",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FlatButton.icon(
              color: Theme.of(context).primaryColorLight,
              icon: Icon(Icons.add),
              label: Text("Add"),
              onPressed: () {
                setState(() {
                  _eventData.event.speakerList.add(SpeakersModel(
                      speakerName: "", profile: "", speakerImage: ""));
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
              children: _eventData.event.speakerList
                  .map((speaker) => EventSpeakerItem(speaker))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
