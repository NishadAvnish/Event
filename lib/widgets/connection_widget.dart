import 'package:flutter/material.dart';

import '../models/connection_model.dart';
import '../widgets/connection_widget_status_button.dart';

class ConnectionWidget extends StatelessWidget {
  final Connection _connection;
  ConnectionWidget(this._connection);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_connection.imageUrl),
      ),
      title: Text(_connection.name),
      subtitle: Text(_connection.role),
      trailing: ConnectionWidgetStatusButton(_connection),
    );
  }
}