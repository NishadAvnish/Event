import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/google_sign_in.dart';
import '../helpers/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../screens/edit_event_screen.dart';
import '../screens/connect_screen.dart';
import '../provider/current_user_provider.dart';
import '../screens/chat_contacts_screen.dart';
import '../screens/favourite_screen.dart';
import '../screens/user_profile.dart';

class DashBoardDrawer extends StatefulWidget {
  @override
  _DashBoardDrawerState createState() => _DashBoardDrawerState();
}

class _DashBoardDrawerState extends State<DashBoardDrawer> {
  bool _isSignedInWithGoogle = false;
  final _auth = Auth();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  void _handleSignOut(BuildContext context) async {
    try {
      if (_isSignedInWithGoogle) await googleSignIn.signOut();

      await _auth.signOut();
      final user = await _auth.getCurrentUser();
      if (user == null)
        Navigator.pushReplacementNamed(context, LoginSignupScreen.route);
    } catch (e) {
      print(e);
    }
  }

  void _getUserInfo() async {
    _isSignedInWithGoogle = await googleSignIn.isSignedIn();
    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildHeader(BuildContext context, double _headerHeight) {
    final currentUser = Provider.of<CurrentUserProvider>(context).currentUser;

    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        UserProfile.route,
        arguments: Provider.of<CurrentUserProvider>(context, listen: false).currentUser.id,
      ),
      child: Container(
        height: _headerHeight,
        width: double.infinity,
        color: Theme.of(context).primaryColorLight,
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(currentUser.imageUrl),
                    radius: _headerHeight * 0.30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    currentUser.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    currentUser.email,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _headerHeight = MediaQuery.of(context).size.height * 0.2;

    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            _buildHeader(context, _headerHeight),
            ListTile(
              leading: Icon(
                Icons.add,
                color: Colors.grey,
              ),
              title: Text(
                "Add Event",
              ),
              onTap: () =>
                  Navigator.of(context).pushNamed(EditEventScreen.route),
            ),
            ListTile(
              leading: Icon(
                Icons.chat_bubble,
                color: Colors.grey,
              ),
              title: Text(
                "Chat",
              ),
              onTap: () =>
                  Navigator.of(context).pushNamed(ChatContactsScreen.route),
            ),
            ListTile(
              leading: Icon(
                Icons.group,
                color: Colors.grey,
              ),
              title: Text(
                "Connect",
              ),
              onTap: () => Navigator.of(context).pushNamed(ConnectScreen.route),
            ),
             ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.grey,
              ),
              
              title: Text(
                "Favourites",
              ),
              onTap: () => Navigator.of(context).pushNamed(FavouriteScreen.route),
            ),
            ListTile(
              leading: Icon(
                Icons.power_settings_new,
                color: Colors.grey,
              ),
              
              title: Text(
                "Log Out",
              ),
              onTap: () => _handleSignOut(context),
            ),
           
          ],
        ),
      ),
    );
  }
}
