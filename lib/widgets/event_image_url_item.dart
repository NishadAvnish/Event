import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/event_provider.dart';

class EventImageUrlItem extends StatefulWidget {
  final int _index;
  EventImageUrlItem(this._index);
  @override
  _EventImageUrlItemState createState() => _EventImageUrlItemState();
}

class _EventImageUrlItemState extends State<EventImageUrlItem> {
  final _imageFocusNode = FocusNode();
  final _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _imageFocusNode.addListener(_updateImage);
    _initUrl();
  }

  void _initUrl(){
    _imageController.text = Provider.of<EventProvider>(context,listen: false).event.eventImageUrls[widget._index];
  }

  @override
  void dispose() {
    super.dispose();
    _imageFocusNode.dispose();
    _imageController.dispose();
  }

  void _updateImage() {
    print("focus");
    if (!_imageFocusNode.hasFocus) {
      if ((!_imageController.text.startsWith('http') &&
          !_imageController.text.startsWith('https'))) {
        return;
      }
      setState(() {
        Provider.of<EventProvider>(context,listen: false).event.eventImageUrls[widget._index] = _imageController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _event = Provider.of<EventProvider>(context,listen: false).event;

    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Container(
          width: _screenWidth * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 160,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: _event.eventImageUrls[widget._index].isEmpty
                        ? AssetImage("asset/images/pic2.jpg")
                        : NetworkImage(_event.eventImageUrls[widget._index]),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: 5,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    onSaved: (value) => _event.eventImageUrls[widget._index] = value,
                    controller: _imageController,
                    focusNode: _imageFocusNode,
                    validator: (value) {
                      if (value.isEmpty) return 'Enter URL.';
                      if (!value.startsWith('http') &&
                          !value.startsWith('https'))
                        return 'Invalid URL.';
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
