import '../widgets/add_category_chip.dart';
import 'package:flutter/material.dart';

class AddEventCategory extends StatefulWidget {
  final List<String> _categoriesList;
  final Function _addCategory;
  final Function _deleteCategory;
  AddEventCategory(
      this._categoriesList, this._addCategory, this._deleteCategory);
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

  void _addCategory(String category) {
    setState(() {
      widget._addCategory(category);
      _categoryNameController.clear();
    });
  }

  void _deleteCategory(String category) {
    setState(() {
      widget._deleteCategory(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Add Categories", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height:10),
        widget._categoriesList.isNotEmpty
            ? Container(
                height: 40,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: widget._categoriesList
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
                      !widget._categoriesList.contains(value))
                    _addCategory(value);
                },
              ),
            ),
            FlatButton(
              child: Text("Add"),
              color: Theme.of(context).primaryColorLight,
              onPressed: () {
                final value = _categoryNameController.text.trim();
                if (value.isNotEmpty && !widget._categoriesList.contains(value))
                  _addCategory(value);
              },
            ),
          ],
        )
      ],
    );
  }
}
