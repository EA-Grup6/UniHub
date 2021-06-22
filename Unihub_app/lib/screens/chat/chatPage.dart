import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:unihub_app/models/message.dart';
import '../../models/user.dart';
import '../../controllers/chat_controller.dart';

class ChatPage extends StatefulWidget {
  final ChatController chatController;
  final String friend;
  final String myUsername;
  ChatPage(this.chatController, this.friend, this.myUsername);
  @override
  _ChatPageState createState() => _ChatPageState();
}

//chatid fix need
class _ChatPageState extends State<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();

  Widget buildSingleMessage(Message message) {
    return Container(
      alignment: message.senderID == widget.friend
          ? Alignment.centerLeft
          : Alignment.centerRight,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: Text(message.text),
    );
  }

  Widget buildChatList() {
    return Builder(builder: (context) {
      List<Message> listMessage =
          widget.chatController.getMessagesForChatID(widget.friend);
      return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        child: ListView.builder(
          itemCount: listMessage.length,
          itemBuilder: (BuildContext context, int index) {
            return buildSingleMessage(listMessage[index]);
          },
        ),
      );
    });
  }

  Widget buildChatArea() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: textEditingController,
            ),
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () {
              widget.chatController
                  .sendMessage(textEditingController.text, widget.friend);
              textEditingController.text = '';
            },
            elevation: 0,
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friend),
      ),
      body: ListView(
        children: <Widget>[
          buildChatList(),
          buildChatArea(),
        ],
      ),
    );
  }
}
