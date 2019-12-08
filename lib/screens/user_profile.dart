import 'package:event/provider/current_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'event_detail.dart';
import 'edit_profile_screen.dart';
import '../provider/user_profile_provider.dart';
import '../widgets/user_profile_header.dart';

class UserProfile extends StatefulWidget {
  static const route = "/user_profile";

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>{
  bool _isLoading = true;
  String _currentUser;
  String id;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await Future.delayed(Duration(milliseconds: 0));
    _currentUser=Provider.of<CurrentUserProvider>(context, listen: false).currentUser.id;
    id=ModalRoute.of(context).settings.arguments;
    await Provider.of<UserProfileProvider>(context).fetch(id);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final _items = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed:_currentUser==id ?() => Navigator.of(context).pushNamed(EditProfile.route):null,
          ),
        ],
      ),
      body: _isLoading
          ? Align(
              alignment: Alignment.center,
              child: Center(child: CircularProgressIndicator()))
          : ListView(
              children: <Widget>[
               _currentUser==id?UserProfileHeader():UserProfileHeader(flag: 1),
                SizedBox(
                  height: _height * 0.01,
                ),
                Divider(
                  height: _height * 0.01,
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      StickyHeader(
                        header: Padding(
                          padding: EdgeInsets.only(left: _height * 0.015),
                          child: Text(
                            "Posts",
                            style:
                                Theme.of(context).textTheme.headline.copyWith(),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        content: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 5.0),
                          constraints: BoxConstraints(
                              minHeight: _height * 0.2,
                              maxHeight: _height * 0.8),
                          width: _width,
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: _items.userItem[0].posts?.length,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              crossAxisSpacing: _height * 0.005,
                              maxCrossAxisExtent: 170,
                              childAspectRatio: 3 / 2.5,
                              mainAxisSpacing: _height * 0.005,
                            ),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      EventDetail.route,
                                      arguments:
                                          { "flag":1,
                                            "id":_items.userItem[0]?.productid[index]
                                          });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            _items.userItem[0]?.posts[index]),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
