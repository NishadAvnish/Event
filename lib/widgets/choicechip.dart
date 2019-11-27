import '../provider/dash_board_provider.dart';
import '../provider/choice_chip_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChoiceChipItems extends StatefulWidget {
  final bool isRebuildReq;

  const ChoiceChipItems({Key key, this.isRebuildReq}) : super(key: key);
  @override
  _ChoiceChipItemsState createState() => _ChoiceChipItemsState();
}

class _ChoiceChipItemsState extends State<ChoiceChipItems> {
  var _value = -1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  void _fetchCategories() async {
    try {
      await Provider.of<ChoiceChipProvider>(context, listen: false)
          .fetchCategory();
      setState(() {
        _isLoading = false;
        _value = 0;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
    
    _isLoading=false;
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _choiceProvider =
        Provider.of<ChoiceChipProvider>(context, listen: false);

    if (_value != -1)
      Provider.of<DashBoardProvider>(context, listen: false)
          .categoryFetch(_value);

    return Container(
      height: _height * 0.05,
      child: _isLoading
          ? Center(
              child: Text("Loading..."),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _choiceProvider.chooseCategoryItem.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ChoiceChip(
                      label: Text(
                        _choiceProvider.chooseCategoryItem[index],
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      selected: _value == index,
                      selectedColor: Colors.blue[200],
                      backgroundColor: Colors.grey[200],
                      onSelected: (selected) {
                        _choiceProvider.changeValue(index);

                        setState(() {
                          _value = index;
                        });
                      },
                    ));
              },
            ),
    );
  }
}
