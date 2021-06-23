import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:unihub_app/i18N/appTranslations.dart';
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
    return Row(
        mainAxisAlignment: message.senderID == widget.friend
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Flexible(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: message.senderID == widget.friend
                        ? Colors.grey[800]
                        : Theme.of(context).accentColor,
                  ),
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 1.5),
                  child: Text(message.text,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: message.senderID == widget.friend
                              ? Colors.grey[300]
                              : Theme.of(context).textTheme.headline6.color))))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friend),
      ),
      body: Builder(builder: (context) {
        List<Message> listMessage =
            widget.chatController.getMessagesForChatID(widget.friend);
        return Container(
          child: ListView.builder(
            itemCount: listMessage.length,
            itemBuilder: (BuildContext context, int index) {
              return buildSingleMessage(listMessage[index]);
            },
          ),
        );
      }),
      bottomSheet: TextField(
        style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
        controller: textEditingController,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(Icons.send_rounded,
                color: this.textEditingController.text == ''
                    ? Colors.grey
                    : Colors.blue[400]),
            onPressed: () async {
              if (textEditingController.text != '') {
                widget.chatController
                    .sendMessage(textEditingController.text, widget.friend);
                textEditingController.text = '';
                setState(() {});
              }
            },
          ),
          hintText: AppLocalizations.instance.text("message_newMessage"),
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.grey[400], width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.grey[500], width: 1),
          ),
        ),
      ),
    );
  }
}
