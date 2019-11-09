import 'package:event/screens/google_sign_in.dart';
import 'package:event/screens/login_screen.dart';
import 'package:event/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/dashboard.dart';
import './provider/choice_chip_provider.dart';
import 'screens/chat_details_screen.dart';
import 'screens/chat_selector_screen.dart';

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
        home: SplashScreen(),
        theme: ThemeData(
          primaryColor: Colors.blue,
          primaryColorDark: Colors.blue[900],
          accentColor: Colors.amber,
          primaryColorLight: Colors.blue[50],
        ),
        routes: {
          ChatDetailsScreen.route: (_) => ChatDetailsScreen(),
          ChatSelectorScreen.route: (_) => ChatSelectorScreen(),
          DashBoard.route: (_) => DashBoard(),
          LoginSignupScreen.route: (_) => LoginSignupScreen(),
          SignInDemo.route: (_) => SignInDemo(),
        },
      ),
    );
  }
}