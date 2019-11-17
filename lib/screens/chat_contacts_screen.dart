import 'package:event/models/chat_contact_model.dart';
import 'package:event/widgets/chat_contact_widget.dart';
import 'package:flutter/material.dart';

class ChatContactsScreen extends StatelessWidget {
  final _chatContactsList = [
    ChatContactModel(
      id: "1",
      imageUrl:
          "https://i0.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
      name: "Name",
      
     
    ),
    ChatContactModel(
      id: "2",
      imageUrl:
          "https://i0.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
      name: "Name",
    
    ),
    ChatContactModel(
      id: "3",
      imageUrl:
          "https://i0.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
      name: "Name",
      
     
    ),
    ChatContactModel(
      id: "4",
      imageUrl:
          "https://i0.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
      name: "Name",
     
      
    ),
    ChatContactModel(
      id: "5",
      imageUrl:
          "https://i0.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
      name: "Name",
     
      
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: _chatContactsList.length,
        itemBuilder: (_, index) => ChatContactWidget(
          _chatContactsList[index],
        ),
      ),
    );
  }
}
