import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/add_event_categories.dart';
import '../widgets/basic_event_details.dart';
import '../widgets/event_speakers_list.dart';
import '../widgets/event_image_url_list.dart';
import '../provider/event_provider.dart';
import '../provider/choice_chip_provider.dart';

class EditEventScreen extends StatefulWidget {
  static const route = "/edit_event_screen";
  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final _form = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  void _saveForm() async {
    if (!_form.currentState.validate()) return;
    final _event = Provider.of<EventProvider>(context, listen: false);
    if (_event.event.date.isEmpty) {
      _showSnackBar("No date selected!");
      return;
    }
    if (_event.event.categories.isEmpty) {
      _showSnackBar("No categories added!");
      return;
    }
    if (_event.event.eventImageUrls.isEmpty ||_event.event.eventImageUrls.length<1) {
      _showSnackBar("No images added!");
      return;
    }
    // if (_event.event.speakerList.isEmpty) {
    //   _showSnackBar("No speakers added!");
    //   return;
    // }

    _form.currentState.save();

    setState(() {
      _isLoading = true;
    });

    try {
      await _event.addEvent();
      _event.clear();
      
      Navigator.of(context).pop();
      // for adding the category and post to dashboard choose category screen
      Provider.of<ChoiceChipProvider>(context).fetchCategory();

    } catch (error) {
      print(error.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showSnackBar(String message) {
    _scaffold.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        duration: Duration(
          seconds: 2,
        ),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("parent");
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text("Add Event"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: Text("Loading..."))
          : Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      BasicEventDetails(),
                      SizedBox(height: 15),
                      AddEventCategory(),
                      SizedBox(height: 10),
                      EventImageUrlList(),
                      SizedBox(height: 10),
                      EventSpeakersList(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
