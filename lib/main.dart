import 'package:event/Modal/ChoiceChipProvider.dart';
import 'package:event/Screen/DashBoard.dart';
import 'package:event/Screen/seemore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() {
  // WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
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
        home: SeeMore(),
      ),
    );
  }
}
