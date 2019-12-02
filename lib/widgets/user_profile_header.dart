import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/current_user_provider.dart';

class UserProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _currentUser = Provider.of<CurrentUserProvider>(context).currentUser;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10),
        CircleAvatar(
          radius: _width * 0.125,
          backgroundImage: NetworkImage(_currentUser.imageUrl),
        ),
        SizedBox(height: 10),
        Text(
          _currentUser.name,
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        ConstrainedBox(
          constraints:
              BoxConstraints(minWidth: _width * 0.3, maxWidth: _width * 0.6),
          child: Text(
            _currentUser.role,
            style: Theme.of(context).textTheme.subhead,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
