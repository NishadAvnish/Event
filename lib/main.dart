
import 'package:event/Screen/dashboard.dart';
import 'package:event/Screen/event_detail.dart';
import 'package:event/widgets/date_card.dart';

import './Screen/chat_selector_screen.dart';
import 'package:flutter/material.dart';
import './provider/ChoiceChipProvider.dart';
import 'package:provider/provider.dart';
import 'Screen/chat_details_screen.dart';
import 'Screen/seemore.dart';

main() {
  runApp(MyApp());
  // WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ChoiceItemProvider(),
        ),
        ChangeNotifierProvider.value(
          value: DashBoardProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: SeeMore(),
        home: EventDetail(),
        //home:DashBoard(),
        theme: ThemeData(
          primaryColor: Colors.blue,
          primaryColorDark: Colors.blue[900],
          accentColor: Colors.amber,
          primaryColorLight: Colors.blue[50],
        ),
        routes: {
          ChatDetailsScreen.route: (_) => ChatDetailsScreen(),
          ChatSelectorScreen.route: (_) => ChatSelectorScreen(),
        },
      ),
    );
  }
}
