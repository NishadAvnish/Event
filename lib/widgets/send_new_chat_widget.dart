import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/chat_detail_provider.dart';

class SendNewChat extends StatefulWidget {
  final String _chatId;
  SendNewChat(this._chatId);
  @override
  _SendNewChatState createState() => _SendNewChatState();
}

class _SendNewChatState extends State<SendNewChat> {

  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: TextField(
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          hintText: "Type message"
                        ),
                        controller: _textEditingController,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        elevation: 3,
                        onPressed: () {
                          String msg = _textEditingController.text;
                          if (msg != null) {
                            Provider.of<ChatDetailProvider>(context,listen: false)
                                .addNewMessage(widget._chatId,msg)
                                .catchError((e) => print(e))
                                .then((_) {
                                  _textEditingController.clear();
                                });
                          }
                        },
                        child: Text(
                          'Send',
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}