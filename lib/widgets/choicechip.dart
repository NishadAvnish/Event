import 'dart:math';

import '../provider/choice_chip_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChoiceChipItems extends StatefulWidget {
  @override
  _ChoiceChipItemsState createState() => _ChoiceChipItemsState();
}

class _ChoiceChipItemsState extends State<ChoiceChipItems> {
  var _value = 0;
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _choiceProvider =
        Provider.of<ChoiceItemProvider>(context, listen: false);

    return Container(
      height: _height * 0.05,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _choiceProvider.categoryItem.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(3.0),
              child: ChoiceChip(
                label: Text(
                  _choiceProvider.categoryItem[index],
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                selected: _value == index,
                selectedColor: Colors.blue[200],
                backgroundColor: Colors.white,
                onSelected: (selected) {
                  setState(() {
                    _value = index;
                    _choiceProvider.changeValue(index);
                  });
                },
              ));
        },
      ),
    );
  }
}
