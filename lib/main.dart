import 'package:event/Screen/RegistrationScreen.dart';
import 'package:event/Screen/chat_selector_screen.dart';
import 'package:flutter/material.dart';

main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatSelectorScreen(),
      
      );
  }
}