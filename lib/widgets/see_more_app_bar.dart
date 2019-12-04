import 'package:baidu_speech_recognition/baidu_speech_recognition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/see_more_provider.dart';

class SeeMoreAppBar extends StatefulWidget {
  @override
  _SeeMoreAppBarState createState() => _SeeMoreAppBarState();
}

class _SeeMoreAppBarState extends State<SeeMoreAppBar> {
  bool _searching = false;
  BaiduSpeechRecognition _speechRecognition;

  @override
  void initState() {
    super.initState();
    _speechRecognition = BaiduSpeechRecognition();
    _speechRecognition.speechRecognitionEvents.listen((data) {
      print("listen: $data");
    });
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.longestSide;
    final _seeMoreData = Provider.of<SeeMoreProvider>(context, listen: false);

    return AppBar(
      title: Text(
        _seeMoreData.categoryValue,
        style: TextStyle(color: Colors.white),
      ),
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, 0),
        child: AnimatedContainer(
          color: Colors.white,
          duration: Duration(
            milliseconds: 200,
          ),
          height: _searching ? _height * 0.07 : 0,
          child: Center(
            child: Row(
              children: <Widget>[
                SizedBox(width: 10),
                _searching
                    ? Expanded(
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(
                              hintText:
                                  "Search in ${_seeMoreData.categoryValue}"),
                          onChanged: (value) {
                            _seeMoreData.searchForValue(value);
                          },
                        ),
                      )
                    : SizedBox(),
                IconButton(
                  icon: Icon(
                    Icons.mic,
                    color: _searching ? Colors.black : Colors.transparent,
                  ),
                  onPressed: () {
                    _speechRecognition
                        .start()
                        .then((value) => print("start: $value"));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: _searching ? Colors.black : Colors.transparent,
                  ),
                  onPressed: () {
                    setState(() {
                      _searching = false;
                      _seeMoreData.searchForValue("");
                      _speechRecognition
                          .cancel()
                          .then((value) => print("cancel: $value"));
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _searching = true;
            });
            _speechRecognition.init().then((value) => print("init: $value"));
          },
        ),
      ],
    );
  }
}
