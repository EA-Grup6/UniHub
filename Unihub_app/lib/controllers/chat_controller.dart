import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/user.dart';
import '../models/message.dart';

class ChatController extends Model {
  ChatController(this.username);
  final String username;
  List<UserApp> friendList = [];
  List<Message> messages = [];
  SocketIO socketIO;

  void init() {
    // friendList = users.where((user) => user.chatID != username).toList();

    //getFriendList(username);

    socketIO = SocketIOManager().createSocketIO('147.83.7.164:4000', '/',
        query: 'username=${username}');
    socketIO.init();

    socketIO.subscribe('receive_message', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      messages.add(Message(
          data['content'], data['senderChatID'], data['receiverChatID']));
      notifyListeners();
    });

    socketIO.connect();
    print('connected');
  }

  void sendMessage(String text, String receiverChatID) {
    messages.add(Message(text, username, receiverChatID));
    socketIO.sendMessage(
      'send_message',
      json.encode({
        'receiverChatID': receiverChatID,
        'senderChatID': username,
        'content': text,
      }),
    );
    notifyListeners();
  }

  List<Message> getMessagesForChatID(String chatID) {
    return messages
        .where((msg) => msg.senderID == chatID || msg.receiverID == chatID)
        .toList();
  }
}
