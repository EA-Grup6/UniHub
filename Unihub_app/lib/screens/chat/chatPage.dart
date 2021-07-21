import 'package:flutter/material.dart';
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:unihub_app/models/message.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friend),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ChatStream(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 4.0, top: 2, bottom: 2, right: 4),
                      child: TextField(
                        minLines: 1,
                        maxLines: 4,
                        controller: textEditingController,
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                    shape: CircleBorder(),
                    color: Colors.blue,
                    onPressed: () async {
                      if (textEditingController.text != '') {
                        widget.chatController.sendMessage(
                            textEditingController.text, widget.friend);
                        textEditingController.clear();
                        setState(() {});
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  var kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: AppLocalizations.instance.text("message_newMessage", null),
    hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14.0),
    border: InputBorder.none,
  );
  var kMessageContainerDecoration = BoxDecoration(
    color: Colors.transparent,
  );

  Widget ChatStream() {
    return Builder(
      builder: (context) {
        List<SingleMessage> messageWidgets = [];
        List<Message> listMessage =
            widget.chatController.getMessagesForChatID(widget.friend);
        for (var message in listMessage) {
          final msgBubble = SingleMessage(message);
          messageWidgets.add(msgBubble);
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class SingleMessage extends StatelessWidget {
  final Message message;
  const SingleMessage(this.message);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Column(
        crossAxisAlignment: message.senderID != message.receiverID
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.5),
            child: Material(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                topLeft: message.senderID != message.receiverID
                    ? Radius.circular(40)
                    : Radius.circular(0),
                bottomRight: Radius.circular(40),
                topRight: message.senderID != message.receiverID
                    ? Radius.circular(0)
                    : Radius.circular(40),
              ),
              color: message.senderID != message.receiverID
                  ? Colors.blue
                  : Colors.white,
              elevation: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: message.senderID != message.receiverID
                        ? Colors.white
                        : Colors.blue,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
