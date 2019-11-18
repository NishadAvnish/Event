import 'package:event/provider/event_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/add_category_chip.dart';
import 'package:flutter/material.dart';

class AddEventCategory extends StatefulWidget {
  @override
  _AddEventCategoryState createState() => _AddEventCategoryState();
}

class _AddEventCategoryState extends State<AddEventCategory> {
  final _categoryNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _categoryNameController.dispose();
  }

  void _addCategory(EventProvider _eventData, String category) {
    setState(() {
      _eventData.event.categories.add(category);
      _categoryNameController.clear();
    });
    print(_eventData.event.categories);
  }

  void _deleteCategory(String category) {
    setState(() {
      Provider.of<EventProvider>(context, listen: false)
          .event
          .categories
          .remove(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _eventData = Provider.of<EventProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Add Categories", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        _eventData.event.categories.isNotEmpty
            ? Container(
                height: 40,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _eventData.event.categories
                      .map(
                        (category) => Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: AddCategoryChip(category, _deleteCategory),
                        ),
                      )
                      .toList(),
                ),
              )
            : SizedBox(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Category",
                ),
                controller: _categoryNameController,
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty &&
                      !_eventData.event.categories.contains(value))
                    _addCategory(_eventData, value);
                },
                validator: (value) => _eventData.event.categories.isEmpty
                    ? (value.isEmpty ? "Add category" : null)
                    : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: FlatButton.icon(
                icon: Icon(Icons.add),
                label: Text("Add"),
                color: Theme.of(context).primaryColorLight,
                onPressed: () {
                  final value = _categoryNameController.text.trim();
                  if (value.isNotEmpty &&
                      !_eventData.event.categories.contains(value))
                    _addCategory(_eventData, value);
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
