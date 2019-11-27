import 'package:event/provider/current_user_provider.dart';
import 'package:event/screens/chat_contacts_screen.dart';
import 'package:event/screens/favourite_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/widgets.dart';
import 'package:provider/provider.dart';

import '../helpers/google_sign_in.dart';
import '../helpers/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../screens/edit_event_screen.dart';
import '../screens/connect_screen.dart';

class DashBoardDrawer extends StatefulWidget {
  @override
  _DashBoardDrawerState createState() => _DashBoardDrawerState();
}

class _DashBoardDrawerState extends State<DashBoardDrawer> {
  bool _isSignedInWithGoogle = false;
  final _auth = Auth();
  GoogleSignInAccount _currentGoogleUser;
  FirebaseUser _currentFirebaseAuthUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  void _handleSignOut(BuildContext context) async {
    if (_isSignedInWithGoogle) {
      await googleSignIn.signOut();
      Navigator.pushReplacementNamed(context, LoginSignupScreen.route);
    } else {
      await _auth.signOut();
      final user = await _auth.getCurrentUser();
      if (user == null)
        Navigator.pushReplacementNamed(context, LoginSignupScreen.route);
    }
  }

  void _getUserInfo() async {
    _isSignedInWithGoogle = await googleSignIn.isSignedIn();
    _currentGoogleUser = googleSignIn.currentUser;
    _currentFirebaseAuthUser = await _auth.getCurrentUser();
    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildHeader(BuildContext context, double _headerHeight) {
    final currentUser = Provider.of<CurrentUserProvider>(context).currentUser;
    return Container(
      height: _headerHeight,
      width: double.infinity,
      color: Theme.of(context).primaryColorLight,
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _isSignedInWithGoogle
              ? Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    bottom: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GoogleUserCircleAvatar(
                        identity: _currentGoogleUser,
                      ),
                      SizedBox(height: 5),
                      Text(_currentGoogleUser.displayName ?? '',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(_currentGoogleUser.email ?? ''),
                    ],
                  ),
                )
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
              onTap: () => Navigator.of(context).pushNamed(EditEventScreen.route),
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
              onTap: () =>
                  Navigator.of(context).pushNamed(ConnectScreen.route),
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