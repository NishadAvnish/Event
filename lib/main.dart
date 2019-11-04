import './Screen/chat_selector_screen.dart';
import 'package:flutter/material.dart';

import 'Screen/chat_details_screen.dart';

main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatSelectorScreen(),
      theme: ThemeData(
        primaryColor: Colors.blue,
        primaryColorDark: Colors.blue[900],
        accentColor: Colors.amber,
        primaryColorLight: Colors.blue[50],
      ),
      routes: {
        ChatDetailsScreen.route : (_) => ChatDetailsScreen(),
      },
    );
  }
}