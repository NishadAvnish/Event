import 'package:event/provider/chat_contact_provider.dart';
import 'package:provider/provider.dart';

import '../screens/chat_details_screen.dart';

import '../models/chat_contact_model.dart';
import 'package:flutter/material.dart';

class ChatContactWidget extends StatefulWidget {
  final ChatContactModel _chatContact;
  final int index;
  final int flag;
  ChatContactWidget(this.index,this._chatContact,this.flag);

  @override
  _ChatContactWidgetState createState() => _ChatContactWidgetState();
}

class _ChatContactWidgetState extends State<ChatContactWidget> {
  
  
  @override
  Widget build(BuildContext context) {
    print("flag: ${widget.flag}");
  final _items=widget.flag==1?Provider.of<ChatContactProvider>(context).messagecontactList:Provider.of<ChatContactProvider>(context).groupcontactList;
  final _content=_items[widget.index].msgList[(_items[widget.index].msgList.length)-1];
  

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        //color: _chatContact.isRead ? Colors.white : Colors.blue[50],
        color:widget.index%2==0 ? Colors.white : Colors.blue[50],
       
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      child: ListTile(
        onTap: () => Navigator.of(context).pushNamed(ChatDetailsScreen.route),
        leading: CircleAvatar(
          child: Image.network(
            widget._chatContact.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(widget._chatContact.name),
       subtitle: Text(_content.msg.length < 30 ? _content.msg : "${_content.msg.substring(0, 30)}..."),
       trailing: Text(_content.time.split("T")[1].split(".")[0].substring(0,5)),
      ),
    );
  }
}
