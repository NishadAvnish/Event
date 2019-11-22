import 'package:event/models/chat_details_model.dart';
import 'package:flutter/material.dart';

class ChatDetailsWidget extends StatelessWidget {
  final String _loggedInId;
 
  final List<ChatDetails> _chat;

  ChatDetailsWidget(this._loggedInId,this._chat);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
             height: MediaQuery.of(context).size.height*0.81,
            width: screenWidth,
            child: ListView.separated(
                separatorBuilder: (_, index) => SizedBox(
                      height: 5,
                    ),
                physics: BouncingScrollPhysics(),
                reverse: true,
                itemCount: _chat.length,
                itemBuilder: (context, index) {
                  final isMyChat = _chat[index].creatorId == _loggedInId;
               
                  return Row(
                    mainAxisAlignment: isMyChat
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: isMyChat
                                ? Radius.circular(15)
                                : Radius.circular(0),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topRight: !isMyChat
                                ? Radius.circular(15)
                                : Radius.circular(0),
                          ),
                        ),
                        color: isMyChat
                            ? Theme.of(context).primaryColorLight
                            : Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          constraints: BoxConstraints(
                            maxWidth: screenWidth * 0.8,
                          ),
                          child: Column(
                            crossAxisAlignment: isMyChat
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: <Widget>[
                              SelectableText(_chat[index].content),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                _chat[index].time.split("T")[1].split(".")[0].substring(0, 5),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          );
        }
  
}
