import 'package:flutter/material.dart';

import 'event_speaker_item.dart';
import '../models/event_detail_model.dart';

class EventSpeakersList extends StatefulWidget {
  final List<SpeakersModel> _speakersList;
  final Function _addSpeaker;
  EventSpeakersList(this._speakersList, this._addSpeaker);

  @override
  _EventSpeakersListState createState() => _EventSpeakersListState();
}

class _EventSpeakersListState extends State<EventSpeakersList> {
  @override
  Widget build(BuildContext context) {
    print("building");
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Event Speakers",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FlatButton.icon(
              color: Theme.of(context).primaryColorLight,
              icon: Icon(
                Icons.add,
              ),
              label: Text("Add Speaker"),
              onPressed: () {
                setState(() {
                  widget._addSpeaker(SpeakersModel(speakerName: "",profile: "",speakerImage: ""));
                });
              },
            ),
          ],
        ),
        Container(
          height: 245,
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget._speakersList
                  .map((speaker) => EventSpeakerItem(speaker))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}