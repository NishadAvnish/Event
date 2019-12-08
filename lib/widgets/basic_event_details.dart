import '../models/event_detail_model.dart';
import '../provider/event_provider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BasicEventDetails extends StatefulWidget {
  @override
  _BasicEventDetailsState createState() => _BasicEventDetailsState();
}

class _BasicEventDetailsState extends State<BasicEventDetails> {

  Future<void> _showDateSelector(EventDetailModel event) async {
    final response = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2021),
      initialDate: DateTime.now(),
    );
    if (response != null){
      setState(() {
        event.date = response.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _event = Provider.of<EventProvider>(context,listen: false).event;
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            labelText: "Title",
          ),
          initialValue: _event.title,
          onSaved: (value) => _event.title = value,
          validator: (value) {
            if (value.isEmpty) return 'Enter title.';
            return null;
          },
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              child: Text("Select Date"),
              color: Theme.of(context).primaryColorLight,
              onPressed: () => _showDateSelector(_event),
            ),
            Text(
              _event.date.isEmpty ? "No date chosen!" : DateFormat.yMMMd().format(DateTime.parse(_event.date)),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Place",
          ),
          initialValue: _event.place,
          onSaved: (value) => _event.place = value,
          validator: (value) {
            if (value.isEmpty) return 'Enter place.';
            return null;
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Description",
          ),
          initialValue: _event.description,
          onSaved: (value) => _event.description = value,
          validator: (value) {
            if (value.isEmpty) return 'Enter description.';
            return null;
          },
        ),
      ],
    );
  }
}
