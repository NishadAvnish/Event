import 'package:event/provider/event_detail_provider.dart';
import 'package:event/provider/see_more_provider.dart';
import 'package:event/screens/login_screen.dart';
import 'package:event/screens/see_more.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/user_profile_provider.dart';
import 'screens/dashboard.dart';
import './provider/choice_chip_provider.dart';
import 'screens/chat_details_screen.dart';
import 'screens/chat_selector_screen.dart';
import 'screens/splash_screen.dart';


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
        ),

        ChangeNotifierProvider.value(
          value: SeeMoreProvider(),
        ),
        ChangeNotifierProvider.value(
          value:EventDetailProvider(),
        ),
        ChangeNotifierProvider.value(
          value:UserProfileProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: SeeMore(),
        // home: EventDetail(),
        //home:UserProfile(),
        //home:DashBoard(),
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
          SeeMore.route:(_)=>SeeMore(),
        },
      ),
    );
  }
}