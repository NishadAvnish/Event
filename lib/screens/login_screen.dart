import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';
import '../helpers/firebase_auth.dart';
import '../helpers/google_sign_in.dart' show googleSignIn;
import '../models/new_user.dart';
import '../provider/current_user_provider.dart';

class LoginSignupScreen extends StatefulWidget {
  static const route = "/login_screen";
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _passwordFocusNode = FocusNode();
  final _userNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _auth = Auth();

  FirebaseUser _currentUser;
  bool _isLoginForm = true;
  bool _isLoading = true;
  bool _emailVerificationRequired = false;
  var _newUser = NewUser(
    email: "",
    fullName: "",
    userName: "",
  );

  /////////// Google Sigin code
  @override
  void initState() {
    super.initState();

    _setUpGoogleSignInListener();

    _checkEmailVerification();
  }

  void _setUpGoogleSignInListener() {
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      if (account != null) _signInWithFirebaseAuthUsingGoogle(account);
    });
  }

  Future<void> _signInWithFirebaseAuthUsingGoogle(
      GoogleSignInAccount account) async {
    setState(() {
      _isLoading = true;
    });
    await Auth().signInWithGoogle(account);
    await Provider.of<CurrentUserProvider>(context, listen: false)
        .getCurrentUser();
    Navigator.of(context).pushReplacementNamed(DashBoard.route);
  }

  Future<void> _handleSignIn() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  /////////// Google signin code ends

  Future<void> _checkEmailVerification() async {
    _currentUser = await _auth.getCurrentUser();
    if (_currentUser != null) {
      if (!_currentUser.isEmailVerified)
        setState(() {
          _isLoading = false;
          _emailVerificationRequired = true;
        });
      else
        Navigator.of(context).pushReplacementNamed(DashBoard.route);
    } else
      setState(() {
        _isLoading = false;
        _emailVerificationRequired = false;
      });
  }

  void _saveForm() async {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();

    try {
      setState(() {
        _isLoading = true;
      });
      if (_isLoginForm) {
        _currentUser = await _auth.signIn(_newUser.email, _newUser.password);
        if (_currentUser.uid.length > 0 && _currentUser.isEmailVerified)
          Navigator.of(context).popAndPushNamed(DashBoard.route);
        else
          setState(() {
            _isLoading = false;
            _emailVerificationRequired = true;
          });
      } else {
        if (!await _auth.checkIfUsernameExists(_newUser.userName)) {
          String uid = await _auth.signUp(_newUser.email, _newUser.password);

          if (uid.length > 0) {
            await _auth.addUserToDatabase(
              uid,
              _newUser,
            );
            await _auth.sendEmailVerification();
            setState(() {
              _isLoading = false;
              _emailVerificationRequired = true;
            });
          }
        }else
          _showDialog("User name already in use.");

        setState(() {
          _isLoading = false;
        });
      }
      await Provider.of<CurrentUserProvider>(context, listen: false)
          .getCurrentUser();
    } catch (error) {
      PlatformException e = error;

      String message = "Something went wrong";
      print(e.code);
      switch (e.code) {
        case "ERROR_INVALID_EMAIL":
          message = "Invalid email.";
          break;

        case "ERROR_USER_NOT_FOUND":
          message = "Please sign up first.";
          break;

        case "ERROR_WEAK_PASSWORD":
          message = "Password length must be atleast 6.";
          break;

        case "ERROR_EMAIL_ALREADY_IN_USE":
          message = "Account already exists with this email. Try signing in.";
          break;

        case "ERROR_WRONG_PASSWORD":
          message = "Wrong password.";
          break;
      }

      _showDialog(message);

      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Icon(
          Icons.error,
          color: Theme.of(ctx).errorColor,
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isLoginForm ? "Log In" : "Create Account"),
        ),
        body: _emailVerificationRequired
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.error,
                      size: 40,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Please verify your email to finalize your account setup and restart the app.",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      child: Text("Send verification link"),
                      onPressed: () {
                        _currentUser.sendEmailVerification();
                      },
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          child: Icon(
                            _isLoginForm ? Icons.person : Icons.person_add,
                            size: 100,
                            color: Colors.white,
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 65,
                        ),
                        AnimatedContainer(
                          height: _isLoginForm ? 0 : 177,
                          duration: Duration(milliseconds: 300),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Full Name",
                                  ),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) =>
                                      FocusScope.of(context)
                                          .requestFocus(_userNameFocusNode),
                                  validator: (value) => _isLoginForm
                                      ? null
                                      : value.isEmpty ? "Enter name" : null,
                                  onSaved: (value) => _newUser.fullName = value,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Username",
                                  ),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) =>
                                      FocusScope.of(context)
                                          .requestFocus(_emailFocusNode),
                                  focusNode: _userNameFocusNode,
                                  validator: (value) => _isLoginForm
                                      ? null
                                      : value.isEmpty ? "Enter username" : null,
                                  onSaved: (value) => _newUser.userName = value,
                                ),
                                const SizedBox(height: 10),
                                DropdownButtonFormField<String>(
                                  validator: (value) => _isLoginForm
                                      ? null
                                      : value.isEmpty ? "Select role" : null,
                                  value: _newUser.role,
                                  hint: Text("Choose Role"),
                                  onSaved: (value) => _newUser.role = value,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _newUser.role = newValue;
                                    });
                                  },
                                  items: ["Teacher", "Student", "Alumni"]
                                      .map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_passwordFocusNode),
                          validator: (value) =>
                              value.isEmpty ? "Enter email" : null,
                          onSaved: (value) => _newUser.email = value,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Password",
                          ),
                          obscureText: true,
                          focusNode: _passwordFocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) =>
                              value.isEmpty ? "Enter password" : null,
                          onSaved: (value) => _newUser.password = value,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.only(top: 25),
                          width: double.infinity,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              _isLoginForm ? "Log In" : "Sign Up",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: _saveForm,
                          ),
                        ),
                        FlatButton(
                          child:
                              Text(_isLoginForm ? "Create Account" : "Sign In"),
                          onPressed: () {
                            setState(() {
                              _isLoginForm = !_isLoginForm;
                            });
                          },
                        ),
                        GoogleSignInButton(
                          onPressed: _handleSignIn,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: _isLoading
                              ? Center(child: CircularProgressIndicator())
                              : SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
