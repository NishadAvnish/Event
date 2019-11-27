import 'package:event/screens/chat_contacts_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/connect_provider.dart';
import '../models/connection_model.dart';
import '../models/connection_request_model.dart';

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
    if (widget._connection.connectionRequest.status == "REQUEST_SENT") return;

    setState(() {
      _isLoading = true;
    });

    String chatId;

    try {
      final connectProvider = Provider.of<ConnectProvider>(context, listen: false);
      switch(widget._connection.connectionRequest.status){
      case "NOT_CONNECTED":
        await connectProvider
              .sendConnectionRequest(widget._connection.id);
        break;

      case "REQUEST_RECEIVED":
        await connectProvider
              .acceptConnectionRequest(widget._connection);
        break;

      case "CONNECTED":
        chatId = widget._connection.connectionRequest.chatId == "NA" ? await connectProvider
              .startChat(widget._connection) : widget._connection.connectionRequest.chatId;
        break;
      }

      setState(() {
        _isLoading = false;
        if(widget._connection.connectionRequest.status == "NOT_CONNECTED"){
          widget._connection.connectionRequest.status = "REQUEST_SENT";
          connectProvider.updateConnectionStatus(widget._connection, widget._connection.connectionRequest);
        }
        else if(widget._connection.connectionRequest.status == "REQUEST_RECEIVED"){
          widget._connection.connectionRequest.status = "CONNECTED";
          connectProvider.updateConnectionStatus(widget._connection, widget._connection.connectionRequest);
        }
        else if(widget._connection.connectionRequest.status == "CONNECTED" && widget._connection.connectionRequest.chatId == "NA"){
          widget._connection.connectionRequest.chatId = chatId;
          connectProvider.updateConnectionStatus(widget._connection, widget._connection.connectionRequest);
        }
      });

      if(widget._connection.connectionRequest.status == "CONNECTED")
        _goToChatScreen(chatId);

    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _goToChatScreen(String chatId){
    Navigator.of(context).pushNamed(ChatContactsScreen.route);
  }

  String getStatusToBeShown(ConnectionRequest request) {
    switch (request.status) {
      case "REQUEST_SENT":
        return "Pending";
      case "REQUEST_RECEIVED":
        return "Accept";
      case "CONNECTED":
        return request.chatId == "NA" ? "Start Chat" : "Say hi!";
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
              : Text(getStatusToBeShown(widget._connection.connectionRequest)),
        ),
      ),
    );
  }
}
