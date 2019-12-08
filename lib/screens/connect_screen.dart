import 'package:event/screens/connections_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/connect_provider.dart';

class ConnectScreen extends StatefulWidget {
  static const route = "/connect_screen";
  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  var _isLoading = true;
  var _error = false;

  @override
  void initState() {
    super.initState();
    _fetchConnections();
  }

  Future<void> _fetchConnections() async {
    try {
      await Provider.of<ConnectProvider>(context, listen: false)
          .findConnections();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        print(e.toString());
        _isLoading = false;
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Connect"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async{
                setState(() {
                  _isLoading = true;
                });
                _fetchConnections();
              },
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Find Connections",
              ),
              Tab(
                text: "My Connections",
              ),
            ],
          ),
        ),
        body: _isLoading
            ? Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            : _error
                ? Center(
                    child: Text(
                      "Something went wrong...",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : TabBarView(
                    children: <Widget>[
                      ConnectionsListScreen(0),
                      ConnectionsListScreen(1),
                    ],
                  ),
      ),
    );
  }
}
