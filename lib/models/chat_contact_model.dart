class ChatContactModel {
  final String id;
  final String imageUrl;
  final String name;
  final MsgModel lastMessage;
  final List<String> userList;

  ChatContactModel({this.id, this.imageUrl, this.name, this.lastMessage, this.userList});
}

class MsgModel {
  final String msg, time, createrId;

  MsgModel({this.msg, this.time, this.createrId});
}
