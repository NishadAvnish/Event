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
    _imageController.text = widget._speaker.speakerImage;
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
                          initialValue: widget._speaker.speakerName,
                          onSaved: (value) => widget._speaker.speakerName = value,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_imageFocusNode),
                          validator: (value) {
                            if (value.isEmpty) return 'Enter name.';
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
                    onSaved: (value) => widget._speaker.speakerImage = value,
                    controller: _imageController,
                    focusNode: _imageFocusNode,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_aboutFocusNode),
                    validator: (value) {
                      if (value.isEmpty) return 'Enter image URL.';
                      if (!value.startsWith('http') &&
                          !value.startsWith('https'))
                        return 'Invalid URL.';
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
                    initialValue: widget._speaker.profile,
                    onSaved: (value) => widget._speaker.profile = value,
                    focusNode: _aboutFocusNode,
                    validator: (value) {
                      if (value.isEmpty) return 'Enter profile.';
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
