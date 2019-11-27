import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/connect_provider.dart';
import '../widgets/connection_widget.dart';

class ConnectionsListScreen extends StatelessWidget {
  final int _flag;
  ConnectionsListScreen(this._flag);

  @override
  Widget build(BuildContext context) {
    final _connectionsData = Provider.of<ConnectProvider>(context);

    return ListView.builder(
      itemCount: _flag == 0
          ? _connectionsData.availableConnections.length
          : _connectionsData.myConnections.length,
      itemBuilder: (_, index) => ConnectionWidget(
        _flag == 0
            ? _connectionsData.availableConnections[index]
            : _connectionsData.myConnections[index],
      ),
    );
  }
}
