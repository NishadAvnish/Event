import 'package:event/models/event_detail_model.dart';
import 'package:flutter/material.dart';

class SpeakerList extends StatelessWidget {
  final index;
  final List<SpeakersModel> _list1;
  SpeakerList(this.index,this._list1);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_width * 0.03),
      ),
      elevation: 10,
      child: Container(
        width: _width * 0.5,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_width * 0.03)),
        child: Padding(
          padding: EdgeInsets.all(_width * 0.01),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_width * 0.03),
                        image: DecorationImage(
                            image: NetworkImage(
                              _list1[index].speakerImage,
                            ),
                            fit: BoxFit.cover)),
                  )),
              SizedBox(width: _width * 0.03),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${_list1[index].speakerName}",
                      style: TextStyle(fontSize: _list1[index].speakerName.length > 18 ? 10 : 20),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Text(
                      "${_list1[index].profile}",
                      style: Theme.of(context).textTheme.body2,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
