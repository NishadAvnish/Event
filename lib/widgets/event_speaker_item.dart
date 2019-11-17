import '../models/event_detail_model.dart';
import 'package:flutter/material.dart';

class EventSpeakerItem extends StatefulWidget {
  final SpeakersModel _speaker;
  EventSpeakerItem(this._speaker);
  @override
  _EventSpeakerItemState createState() => _EventSpeakerItemState();
}

class _EventSpeakerItemState extends State<EventSpeakerItem> {
  final _imageFocusNode = FocusNode();
  final _aboutFocusNode = FocusNode();
  final _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _imageFocusNode.addListener(_updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _imageFocusNode.dispose();
    _aboutFocusNode.dispose();
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
        widget._speaker.speakerImage = _imageController.text;
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
          width: _screenWidth * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 8,
                ),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: widget._speaker.speakerImage.isEmpty
                          ? AssetImage("asset/images/pic2.jpg")
                          : NetworkImage(widget._speaker.speakerImage),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Name'),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_imageFocusNode),
                          validator: (value) {
                            if (value.isEmpty) return 'Please enter name.';
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.next,
                    controller: _imageController,
                    focusNode: _imageFocusNode,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_aboutFocusNode),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                    left: 8,
                    bottom: 5,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Profile'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    focusNode: _aboutFocusNode,
                    validator: (value) {
                      if (value.isEmpty) return 'Please enter profile.';
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
