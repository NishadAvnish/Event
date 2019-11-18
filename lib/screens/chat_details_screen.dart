import 'package:event/provider/chat_detail_provider.dart';
import 'package:event/widgets/chat_details_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatDetailsScreen extends StatefulWidget {
  static const route = "/chat_details_screen";

  @override
  _ChatDetailsScreenState createState() => _ChatDetailsScreenState();
}

String _loggedInId;

Future<void> userID() async {
  final FirebaseUser x = await FirebaseAuth.instance.currentUser();
  _loggedInId = x.uid;
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  String msg;

  TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    userID();
    final _chat = Provider.of<ChatDetailProvider>(context)
        .chatDetailItems;
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Name"),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StreamBuilder<Object>(
                  stream:
                      Provider.of<ChatDetailProvider>(context, listen: false)
                          .fetchDetail("wmHgmv2l1lVQ44rF0a06", _loggedInId)
                          .asStream(),
                  builder: (context, snapshot) {
                    return ChatDetailsWidget(_loggedInId, _chat);
                  }),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: TextField(
                        textInputAction: TextInputAction.newline,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: new InputDecoration(
                          
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                        ),
                        controller: _textEditingController,
                        onChanged: (value) {
                          //Do something with the user input.
                          msg = value;
                        },
                      ),
                    ),
                    Flexible(
                      
                      flex: 1,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        elevation: 3,
                        onPressed: () {
                             if(msg!=null)
                            { Provider.of<ChatDetailProvider>(context,listen: false).addNewMsg("wmHgmv2l1lVQ44rF0a06", {"msg":msg,"time":DateTime.now().toIso8601String(),"creater":_loggedInId}).catchError((e)=>print(e)).then((_){
                              msg=null;
                              _textEditingController.clear();
                             });}

                        },
                        child: Text(
                          'Send',
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
