import 'package:flutter/material.dart';

class AddCategoryChip extends StatelessWidget {
  final String _label;
  final Function _deleteCategory;
  AddCategoryChip(this._label, this._deleteCategory);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Theme.of(context).primaryColorLight
      ),
      padding: EdgeInsets.only(left:10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(_label),
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () => _deleteCategory(_label),
          ),
        ],
      ),
    );
  }
}
