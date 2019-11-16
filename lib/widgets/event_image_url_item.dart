import 'package:flutter/material.dart';

class EventImageUrlItem extends StatefulWidget {
  final String _url;
  EventImageUrlItem(this._url);
  @override
  _EventImageUrlItemState createState() => _EventImageUrlItemState();
}

class _EventImageUrlItemState extends State<EventImageUrlItem> {
  var _eventUrl = "";
  final _imageFocusNode = FocusNode();
  final _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget._url.isNotEmpty) _eventUrl = widget._url;
    _imageFocusNode.addListener(_updateImage);
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
        _eventUrl = _imageController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
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
                    image: _eventUrl.isEmpty
                        ? AssetImage("asset/images/pic2.jpg")
                        : NetworkImage(_eventUrl),
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
                    decoration: InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageController,
                    focusNode: _imageFocusNode,
                    validator: (value) {
                      if (value.isEmpty) return 'Please enter an image URL.';
                      if (!value.startsWith('http') &&
                          !value.startsWith('https'))
                        return 'Please enter a valid URL.';
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
