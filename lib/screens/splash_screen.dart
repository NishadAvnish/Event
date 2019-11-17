
import 'package:event/helpers/firestore_crud.dart';
import 'package:event/provider/chat_contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';
import 'login_screen.dart';
import '../helpers/firebase_auth.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkLogInStatus();
    //CrudOperation.add();
   // CrudOperation.fetch();
   
  }

  @override
  void didChangeDependencies() {
    Provider.of<ChatContactProvider>(context).fetchContact("xgySFHPrQ3feOWu9orsTEsBv4Fu1");
    super.didChangeDependencies();
 
   
  }
 

  void _checkLogInStatus() async {
    final auth = Auth();
    final user = await auth.getCurrentUser();
    if (user != null) {
      await user.reload();
      if (user?.uid != null && user.isEmailVerified)
        Navigator.of(context).pushReplacementNamed(DashBoard.route);
      else
        Navigator.of(context).pushReplacementNamed(LoginSignupScreen.route);
    } else
      Navigator.of(context).pushReplacementNamed(LoginSignupScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Text(
            "Event",
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
