import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/connection_model.dart';
import '../helpers/firebase_auth.dart';
import '../models/connection_request_model.dart';

class ConnectProvider with ChangeNotifier {
  final Connection _currentUserData;
  List<Connection> _availableConnections = [];
  List<Connection> _myConnections = [];

  ConnectProvider(this._currentUserData);

  final dbRef = Firestore.instance;

  List<Connection> get availableConnections {
    return [..._availableConnections];
  }

  List<Connection> get myConnections {
    return [..._myConnections];
  }

  void updateConnectionStatus(Connection connection, ConnectionRequest newConnectionRequest) {
    if (_availableConnections.contains(connection))
      _availableConnections[_availableConnections.indexOf(connection)]
          .connectionRequest
          = newConnectionRequest;
    else
      _myConnections[_myConnections.indexOf(connection)]
          .connectionRequest
          = newConnectionRequest;

    notifyListeners();
  }

  Future<void> findConnections() async {
    try {
      print(_currentUserData.email);
      final currentUser = await Auth().getCurrentUser();

      final allUsersResponse = await dbRef.collection("users").getDocuments();

      final connectionsResponse = await dbRef
          .collection("users")
          .document("${currentUser.uid}")
          .collection("connections")
          .getDocuments();

      final Map<String, ConnectionRequest> connectedConnectionRequestForId = {};
      final Map<String, ConnectionRequest> notConnectedConnectionRequestForId =
          {};
      connectionsResponse.documents.forEach((snapshot) {
        if (snapshot.data["status"] == "CONNECTED")
          connectedConnectionRequestForId.putIfAbsent(
            snapshot.data["user_id"],
            () => ConnectionRequest(
                id: snapshot.documentID,
                status: snapshot.data["status"],
                chatId: snapshot.data["chat_id"],
                userId: snapshot.data["user_id"]),
          );
        else
          notConnectedConnectionRequestForId.putIfAbsent(
            snapshot.data["user_id"],
            () => ConnectionRequest(
                id: snapshot.documentID,
                status: snapshot.data["status"],
                chatId: snapshot.data["chat_id"],
                userId: snapshot.data["user_id"]),
          );
      });

      _myConnections.clear();
      _availableConnections.clear();

      allUsersResponse.documents.forEach((doc) {
        if (doc.documentID != currentUser.uid) {
          if (!connectedConnectionRequestForId.containsKey(doc.documentID))
            _availableConnections.add(
              Connection(
                id: doc.documentID,
                name: doc.data["full_name"],
                imageUrl:
                    "https://images.pexels.com/photos/772571/pexels-photo-772571.jpeg?cs=srgb&dl=beautiful-bees-bloom-772571.jpg&fm=jpg",
                role: doc.data["role"],
                email: doc.data["email"],
                userName: doc.data["user_name"],
                connectionRequest:
                    notConnectedConnectionRequestForId["${doc.documentID}"] ??
                        ConnectionRequest(status: "NOT_CONNECTED"),
              ),
            );
          else
            _myConnections.add(
              Connection(
                id: doc.documentID,
                name: doc.data["full_name"],
                imageUrl:
                    "https://images.pexels.com/photos/772571/pexels-photo-772571.jpeg?cs=srgb&dl=beautiful-bees-bloom-772571.jpg&fm=jpg",
                role: doc.data["role"],
                email: doc.data["email"],
                userName: doc.data["user_name"],
                connectionRequest:
                    connectedConnectionRequestForId["${doc.documentID}"],
              ),
            );
        }
      });

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> sendConnectionRequest(String connectionId) async {
    try {
      final currentUser = await Auth().getCurrentUser();

      var connectionRequest = {
        "user_id": currentUser.uid,
        "status": "REQUEST_RECEIVED",
        "chat_id": "NA",
      };

      await dbRef
          .collection("users")
          .document("$connectionId")
          .collection("connections")
          .add(connectionRequest);

      connectionRequest.update("status", (_) => "REQUEST_SENT");
      connectionRequest.update("user_id", (_) => "$connectionId");

      await dbRef
          .collection("users")
          .document("${currentUser.uid}")
          .collection("connections")
          .add(connectionRequest);

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> acceptConnectionRequest(Connection connection) async {
    try {
      final currentUser = await Auth().getCurrentUser();

      await dbRef
          .collection("users")
          .document("${currentUser.uid}")
          .collection("connections")
          .document(connection.connectionRequest.id)
          .updateData({"status": "CONNECTED"});

      final response = await dbRef
          .collection("users")
          .document("${connection.id}")
          .collection("connections")
          .where("user_id", isEqualTo: currentUser.uid)
          .getDocuments();

      await dbRef
          .collection("users")
          .document("${connection.id}")
          .collection("connections")
          .document(response.documents[0].documentID)
          .updateData({"status": "CONNECTED"});

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<String> startChat(Connection connection) async {
    try {
      final currentUserId = _currentUserData.id;
      final chatData = {
        "is_group": false,
        "admins": [currentUserId],
        "users": [currentUserId, connection.id],
        "images": [
          _currentUserData.imageUrl,
          connection.imageUrl,
        ],
        "names": [_currentUserData.name, connection.name],
      };

      final response = await dbRef.collection("chats").add(chatData);

      await dbRef
          .collection("users")
          .document(currentUserId)
          .collection("connections")
          .document(connection.connectionRequest.id)
          .updateData({
        "chat_id": response.documentID,
      });

      final connectionsResponse = await dbRef
          .collection("users")
          .document(connection.id)
          .collection("connections")
          .where("user_id", isEqualTo: currentUserId)
          .getDocuments();

      await dbRef
          .collection("users")
          .document(connection.id)
          .collection("connections")
          .document(connectionsResponse.documents[0].documentID)
          .updateData({
        "chat_id": response.documentID,
      });

      return response.documentID;
    } catch (e) {
      print(e.toString());
      print(_currentUserData);
      print(connection.email);
      throw e;
    }

  }
}
