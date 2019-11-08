import 'chat_selector_screen.dart';
import 'package:flutter/material.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _passwordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  bool _isLoginForm = true;
  String _email, _password;

  void _saveForm() {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();
    Navigator.of(context).pushNamed(ChatSelectorScreen.route, arguments: {
      "email": _email,
      "password": _password,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginForm ? "Log In" : "Create Account"),
      ),
      body: Padding(
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
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    icon: Icon(Icons.email),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_passwordFocusNode),
                  validator: (value) => value.isEmpty ? "Enter email" : null,
                  onSaved: (value) => _email = value,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    icon: Icon(Icons.lock),
                  ),
                  focusNode: _passwordFocusNode,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => value.isEmpty ? "Enter password" : null,
                  onSaved: (value) => _password = value,
                ),
                SizedBox(height: 20),
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
                  child: Text(_isLoginForm ? "Create Account" : "Sign In"),
                  onPressed: () {
                    setState(() {
                      _isLoginForm = !_isLoginForm;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
