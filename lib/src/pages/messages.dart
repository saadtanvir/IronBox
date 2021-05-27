import 'package:ironbox/src/controllers/chats_controller.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/widgets/availableChatsWidget.dart';
import 'package:ironbox/src/widgets/chattingScreenWidget.dart';
import 'package:ironbox/src/widgets/conversationTileWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/searchBarWidget.dart';
import '../helpers/app_constants.dart' as Constants;

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  ChatsController _con = Get.put(ChatsController());
  FocusNode _chatSearchFocusNode;

  @override
  void initState() {
    _chatSearchFocusNode = new FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _chatSearchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title: Text(
          "Inbox",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _searchBar(),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: Helper.of(context).getScreenHeight() * 0.15,
              child: ListView.builder(
                itemCount: 7,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: AvailableUserChatsWidget(),
                  );
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              // this will wrap in stream builder
              // stream of user chats
              // from firebase documents
              // as new message send/receive
              // new conversation will be added
              child: ListView.separated(
                itemCount: 9,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // open chatting screen
                      // pass current and clicked user
                      FocusScope.of(context).unfocus();
                      Get.to(ChattingScreen(),
                          transition: Transition.rightToLeft);
                    },
                    child: ConversationTileWidget(),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: TextField(
          keyboardType: TextInputType.text,
          focusNode: _chatSearchFocusNode,
          onTap: () {
            print(MediaQuery.of(context).viewInsets.bottom);
          },
          decoration: InputDecoration(
            fillColor: Constants.messageSearchBarColor,
            filled: true,
            labelText: "Search User",
            labelStyle:
                Helper.of(context).textStyle(size: 15.0, color: Colors.grey),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
