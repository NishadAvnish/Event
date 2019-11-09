import 'package:event/helpers/google_sign_in.dart';
import 'package:flutter/material.dart';

import '../helpers/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../screens/chat_selector_screen.dart';

class DashBoardDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _headerHeight = MediaQuery.of(context).size.height * 0.2;
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: _headerHeight,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                      size: _headerHeight * 0.4,
                    ),
                    radius: _headerHeight * 0.30,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.chat_bubble,
                color: Colors.grey,
              ),
              title: Text(
                "Chat",
                style: Theme.of(context).textTheme.title,
              ),
              onTap: () =>
                  Navigator.of(context).pushNamed(ChatSelectorScreen.route),
            ),
            ListTile(
              leading: Icon(
                Icons.power_settings_new,
                color: Colors.grey,
              ),
              title: Text(
                "Log Out",
                style: Theme.of(context).textTheme.title,
              ),
              onTap: () async {
                bool isSignedInWithGoogle = await googleSignIn.isSignedIn();
                if (isSignedInWithGoogle) {
                  await googleSignIn.signOut();
                  Navigator.pushReplacementNamed(
                      context, LoginSignupScreen.route);
                } else {
                  final auth = Auth();
                  await auth.signOut();
                  final user = await auth.getCurrentUser();
                  if (user == null)
                    Navigator.pushReplacementNamed(
                        context, LoginSignupScreen.route);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
