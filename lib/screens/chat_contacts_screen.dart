import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/chat_contact_model.dart';
import '../provider/chat_contact_provider.dart';
import '../widgets/chat_contact_widget.dart';

class ChatContactsScreen extends StatefulWidget {
  final int flag;

  ChatContactsScreen(this.flag);
  @override
  _ChatContactsScreenState createState() => _ChatContactsScreenState();
}

class _ChatContactsScreenState extends State<ChatContactsScreen> {
  final _chatContactsList = [
    ChatContactModel(
      id: "1",
      imageUrl:
          "https://i0.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
      name: "Name",
      lastMessage: MsgModel(
        createrId: "1",
        msg: "hello",
        time: "10:21",
      ),
      userList: ["user1"],
    ),
  ];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    //_fetchContacts();
  }

  Future<void> _fetchContacts() async {
    try {
      await Provider.of<ChatContactProvider>(context, listen: false)
          .fetchContact("VsfZbVdbwHuYqtlqOdhHKtZbBo273");
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    /* final _items = widget.flag == 1
        ? Provider.of<ChatContactProvider>(context).messagecontactList
        : Provider.of<ChatContactProvider>(context).groupcontactList; 

    return isLoading
        ? Align(alignment: Alignment.center, child: CircularProgressIndicator())
        : Center(
            child: ListView.builder(
              itemCount: _chatContactsList.length,
              itemBuilder: (_, index) => ChatContactWidget(
                index,
                _chatContactsList[index],
                widget.flag,
                _items
              ),
            ),
          );*/

    return Container(
      child: StreamBuilder(
        stream: Firestore.instance.collection('Chat').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) =>
                  ChatContactWidget(_chatContactsList[0]),
              itemCount: snapshot.data.documents.length,
            );
          }
        },
      ),
    );
  }
}
