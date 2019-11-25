import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/connect_provider.dart';
import '../models/connection_model.dart';

class ConnectionWidgetStatusButton extends StatefulWidget {
  final Connection _connection;
  ConnectionWidgetStatusButton(this._connection);

  @override
  _ConnectionWidgetStatusButtonState createState() =>
      _ConnectionWidgetStatusButtonState();
}

class _ConnectionWidgetStatusButtonState
    extends State<ConnectionWidgetStatusButton> {
  var _isLoading = false;

  void _handleOnClick() async {
    if (widget._connection.connectionRequest.status != "NOT_CONNECTED" &&
        widget._connection.connectionRequest.status != "REQUEST_RECEIVED") return;

    setState(() {
      _isLoading = true;
    });

    try {
      if (widget._connection.connectionRequest.status == "NOT_CONNECTED")
        await Provider.of<ConnectProvider>(context, listen: false)
            .sendConnectionRequest(widget._connection.id);
      else
        await Provider.of<ConnectProvider>(context, listen: false)
            .acceptConnectionRequest(widget._connection);

      setState(() {
        _isLoading = false;
        Provider.of<ConnectProvider>(context, listen: false).updateConnectionStatus(
          widget._connection,
          widget._connection.connectionRequest.status == "NOT_CONNECTED"
              ? "REQUEST_SENT"
              : "CONNECTED",
        );
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String getStatusToBeShown(String status) {
    switch (status) {
      case "REQUEST_SENT":
        return "Pending";
      case "REQUEST_RECEIVED":
        return "Accept";
      case "CONNECTED":
        return "Connected";
      case "NOT_CONNECTED":
        return "Connect";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleOnClick,
      child: Container(
        width: 90,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : Text(getStatusToBeShown(widget._connection.connectionRequest.status)),
        ),
      ),
    );
  }
}
