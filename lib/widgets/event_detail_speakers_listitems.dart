import 'package:flutter/material.dart';

class SpeakerList extends StatelessWidget {
  final index;
  SpeakerList(this.index);

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
                              "https://images.unsplash.com/photo-1555445091-5a8b655e8a4a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
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
                      "Name",
                      style: Theme.of(context).textTheme.headline,
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Text(
                      "Best Describe about the use ",
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
