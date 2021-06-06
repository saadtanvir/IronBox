import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ironbox/src/controllers/chats_controller.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/message.dart';
import 'package:ironbox/src/widgets/availableChatsWidget.dart';
import 'package:ironbox/src/widgets/textMessageContainerWidget.dart';
import 'package:flutter/scheduler.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChattingScreen extends StatefulWidget {
  // it will receive recipient info
  final String userId;
  final String imgUrl;
  final String username;
  ChattingScreen(this.userId, this.imgUrl, this.username);
  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  ChatsController _con = Get.put(ChatsController());
  TextEditingController _textMessageController = new TextEditingController();
  ScrollController _listViewScrollCon = ScrollController();
  var _hasText = false.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: Theme.of(context).accentColor),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: UserCircularAvatar(
                50.0, 50.0, "${widget.imgUrl}", BoxFit.cover),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(5.0),
            child: Text(
              "${widget.username}",
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder<List<Message>>(
              stream: _con.firebaseMethods.getMessages(
                  sid: userRepo.currentUser.value.id, rid: "${widget.userId}"),
              builder: (context, messages) {
                if (messages.hasData) {
                  if (messages.data.length > 0) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      _listViewScrollCon
                          .jumpTo(_listViewScrollCon.position.maxScrollExtent);
                    });
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                        controller: _listViewScrollCon,
                        itemCount: messages.data.length,
                        itemBuilder: (context, index) {
                          return MessageContainer(messages.data[index]);
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Send your first message!",
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    );
                  }
                } else if (messages.hasError) {
                  return Center(
                    child: Text(
                      "${Constants.check_internet_connection}",
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: _messageTextbox(),
          ),
        ],
      ),
    );
  }

  Widget _messageTextbox() {
    return TextField(
      controller: _textMessageController,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: null,
      onChanged: (value) {
        // check if value is not empty
        // not contains only new lines and whitespaces
        _hasText.value = (value.length > 0 &&
                value.trim() != "" &&
                Helper.trimNewLine(value) != "")
            ? true
            : false;
      },
      decoration: InputDecoration(
        hintText: "${Constants.write_a_message}",
        hintStyle: TextStyle(color: Colors.grey[350]),
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: IconButton(
            onPressed: () {
              // check if hasText is true
              // send message
              // clear message box
              // hasText to false
              if (_hasText.value) {
                _con.message.body = _textMessageController.text;
                _con.message.senderId = userRepo.currentUser.value.id;
                _con.message.receiverId = "${widget.userId}";
                _con.message.type = "Text";
                _con.message.timeStamp = Helper.get12hrTime(DateTime.now());
                _con.message.serverTime = Timestamp.now();
                _con.sendMessage().then((value) {
                  _listViewScrollCon.animateTo(
                      _listViewScrollCon.position.maxScrollExtent,
                      duration: new Duration(milliseconds: 100),
                      curve: Curves.easeIn);
                }).catchError((e) {
                  Get.snackbar("Failed !", "Check internet connection");
                  print("Send Message Error: $e");
                });
                _textMessageController.text = "";
                _hasText.value = false;
              }
            },
            splashRadius: 20.0,
            icon: Obx(() {
              return Icon(
                Icons.send,
                size: 30.0,
                color: _hasText.value
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColor.withOpacity(0.5),
              );
            }),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(35.0),
          ),
        ),
      ),
    );
  }
}
