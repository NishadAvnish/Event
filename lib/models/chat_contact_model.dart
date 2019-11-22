class ChatContactModel {
  final String id;
  final String imageUrl;
  final String name;
  final List<MsgModel> msgList;
  final List<String> userList;

  ChatContactModel({this.id, this.imageUrl, this.name, this.msgList,this.userList});

}

class MsgModel {
  final String msg, time,createrId;

  MsgModel({this.msg, this.time, this.createrId});
}
