import 'dart:io';

import 'package:event/helpers/firebase_auth.dart';
import 'package:event/models/connection_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/current_user_provider.dart';

class EditProfile extends StatefulWidget {
  static const route = "/edit_profile";
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _pickedImage;
  bool _isLoading = false;
  final _userNameFocusNode = FocusNode();
  final _scaffold = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();
  String _fullName, _userName;

  @override
  void dispose() {
    super.dispose();
    _userNameFocusNode.dispose();
  }

  Future<void> getImage() async {
    final pickedImage =
        await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = pickedImage;
    });
  }

  Future<String> uploadImage() async {
    try {
      final fileName = Provider.of<CurrentUserProvider>(context, listen: false)
          .currentUser
          .id;
      final storageTaskSnapshot = await FirebaseStorage.instance
          .ref()
          .child(fileName)
          .child("profile_image")
          .putFile(_pickedImage)
          .onComplete;

      if (storageTaskSnapshot.error == null) {
        final downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        return downloadUrl;
      } else
        _showSnackbar('This file is not an image');
    } catch (e) {
      _showSnackbar(e.toString());
    }
    return "";
  }

  void updateData() async {
    if (!_form.currentState.validate()) return;

    try {
      _form.currentState.save();
      final currentUserData =
          Provider.of<CurrentUserProvider>(context, listen: false);

      if (currentUserData.currentUser.userName != _userName) {
        if (await Auth().checkIfUsernameExists(_userName)) {
          _showSnackbar("Username already in use");
          return;
        }
      }

      setState(() {
        _isLoading = true;
      });

      var profileImageUrl = currentUserData.currentUser.imageUrl;

      if (_pickedImage != null) {
        profileImageUrl = await uploadImage();
        if (profileImageUrl.isEmpty) {
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }

      final newProfileData = {
        "full_name": _fullName,
        "user_name": _userName,
        "image_url": profileImageUrl,
      };

      await currentUserData.updateProfile(newProfileData);

      currentUserData.updateCurrentUser(Connection(
        id: currentUserData.currentUser.id,
        email: currentUserData.currentUser.email,
        name: newProfileData["full_name"],
        userName: newProfileData["user_name"],
        imageUrl: profileImageUrl.isNotEmpty ? profileImageUrl : currentUserData.currentUser.imageUrl,
        role: currentUserData.currentUser.role,
      ));

      Navigator.of(context).pop();
    } catch (e) {
      _showSnackbar(e.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showSnackbar(String message) {
    _scaffold.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _currentUser =
        Provider.of<CurrentUserProvider>(context, listen: false).currentUser;
    final _width = MediaQuery.of(context).size.width;

    _fullName = _currentUser.name;
    _userName = _currentUser.userName;

    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: updateData,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            AbsorbPointer(
              absorbing: _isLoading,
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: getImage,
                      child: CircleAvatar(
                        radius: _width * 0.125,
                        backgroundImage: _pickedImage == null
                            ? NetworkImage(_currentUser.imageUrl)
                            : FileImage(_pickedImage),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Full Name",
                      ),
                      initialValue: _fullName,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(_userNameFocusNode),
                      validator: (value) => value.isEmpty ? "Enter name" : null,
                      onSaved: (value) => _fullName = value,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Username",
                      ),
                      initialValue: _userName,
                      textInputAction: TextInputAction.next,
                      focusNode: _userNameFocusNode,
                      validator: (value) =>
                          value.isEmpty ? "Enter username" : null,
                      onSaved: (value) => _userName = value,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: _isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                      color: Colors.white.withOpacity(0.8),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
