import 'package:event/models/chat_contact_model.dart';
import 'package:event/provider/chat_contact_provider.dart';
import 'package:event/widgets/chat_contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatContactsScreen extends StatefulWidget {
  final int flag;

  ChatContactsScreen( this.flag);
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
      
     
    ),
    
    
  ];

  bool isLoading=true;
  @override
  void didChangeDependencies() {
    Provider.of<ChatContactProvider>(context,listen:false).fetchContact("xgySFHPrQ3feOWu9orsTEsBv4Fu1").catchError((e)=>print(e)).then((_){
      setState(() {
        isLoading=false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ?Align(alignment: Alignment.center,child:CircularProgressIndicator() ):Center(
      child: ListView.builder(
        itemCount: _chatContactsList.length,
        itemBuilder: (_, index) => ChatContactWidget(
          index,
          _chatContactsList[index],
          widget.flag
        ),
      ),
    );
  }
}
