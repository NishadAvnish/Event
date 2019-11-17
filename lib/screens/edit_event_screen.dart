import 'package:event/widgets/add_event_categories.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event_detail_model.dart';
import '../widgets/event_speakers_list.dart';

import '../widgets/event_image_url_list.dart';

class EditEventScreen extends StatefulWidget {
  static const route = "/edit_event_screen";
  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  var _selectedDate = "";
  var _urlsList = [""];
  var _speakersList = [SpeakersModel(speakerName: "", profile: "", speakerImage: "",)];
  List<String>_categoriesList = [];
  final _form = GlobalKey<FormState>();

  void _addUrl(String url) {
    _urlsList.insert(0, url);
  }

  void _addSpeaker(SpeakersModel speaker){
    _speakersList.insert(0, speaker);
  }

  void _addCategory(String category){
    _categoriesList.add(category);
  }

  void _deleteCategory(String category){
    _categoriesList.remove(category);
  }

  Future<void> _showDateSelector() async {
    final response = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2021),
      initialDate: DateTime.now(),
    );
    if (response != null)
      setState(() {
        _selectedDate = DateFormat.yMMMd().format(response);
      });
  }

  void _saveForm() {
    if (!_form.currentState.validate()) return;
    print("saving");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Event Name",
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Please provide event name.';
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _selectedDate.isEmpty ? "No date chosen!" : _selectedDate,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FlatButton(
                      child: Text("Select Date"),
                      color: Theme.of(context).primaryColorLight,
                      onPressed: () => _showDateSelector(),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Event Description",
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Please provide description.';
                    return null;
                  },
                ),
                SizedBox(height: 10),
                AddEventCategory(_categoriesList, _addCategory, _deleteCategory,),
                SizedBox(height: 10),
                EventImageUrlList(_urlsList, _addUrl),
                SizedBox(height: 10),
                EventSpeakersList(_speakersList, _addSpeaker),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
