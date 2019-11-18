import 'package:event/provider/user_profile_provider.dart';
import 'package:event/screens/event_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class UserProfile extends StatefulWidget {
  static const route = "/usreProfile";

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String _currentUserId;
  String createrId;
  int i = 0;
  bool isloading=true;
  @override
  Future<void> didChangeDependencies() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _currentUserId = user.uid;

    createrId = ModalRoute.of(context).settings.arguments.toString();
    Provider.of<UserProfileProvider>(context).fetch(createrId).then((_){
      setState((){
        isloading=false;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final _items = Provider.of<UserProfileProvider>(context).userItem[0];

    return Scaffold(
      appBar: AppBar(
        title: Text("profile"),
      ),
      body:isloading?Align(alignment:Alignment.center,child: Center(child:CircularProgressIndicator())) :ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                top: _height * 0.015,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: _height * 0.13,
                  width: _height * 0.16,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: _height * 0.13,
                            width: _height * 0.13,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                              image: DecorationImage(
                                  image: NetworkImage(_items?.userImage),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: _currentUserId == createrId
                            ? IconButton(
                                icon: Icon(
                                  Icons.add_a_photo,
                                  size: _height * 0.04,
                                  color: Colors.blue,
                                ),
                                onPressed: () {},
                              )
                            : Container(
                                color: Colors.transparent,
                              ),
                      )
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: _height * 0.01,
          ),
          Text(
            _items?.name,
            style: Theme.of(context)
                .textTheme
                .headline
                .copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: _width * 0.3, maxWidth: _width * 0.6),
              child: Text(
                _items?.biodata,
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),
            ),
          ),
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
            // padding: EdgeInsets.symmetric(horizontal: _height * 0.02),
            // margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom+8),
            child: Column(
              children: <Widget>[
                StickyHeader(
                  header: Padding(
                    padding: EdgeInsets.only(left: _height * 0.015),
                    child: Text(
                      "Posts",
                      style: Theme.of(context).textTheme.headline.copyWith(),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  content: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 5.0),
                    constraints: BoxConstraints(
                        minHeight: _height * 0.2, maxHeight: _height * 0.8),
                    width: _width,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: _items.posts?.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          crossAxisSpacing: _height * 0.005,
                          maxCrossAxisExtent: 170,
                          childAspectRatio: 3 / 2.5,
                          mainAxisSpacing: _height * 0.005),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(EventDetail.route,
                                arguments: _items?.productid[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(_items?.posts[index]),
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
