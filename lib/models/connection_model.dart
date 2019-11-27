import 'package:event/models/connection_request_model.dart';

class Connection{
  String id;
  String name;
  String userName;
  String email;
  String role;
  String imageUrl;
  ConnectionRequest connectionRequest;

  Connection({this.id,this.name,this.userName,this.email,this.role,this.imageUrl, this.connectionRequest});
}