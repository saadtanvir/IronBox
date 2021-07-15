import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ironbox/src/controllers/chats_controller.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/userContact.dart';
import 'package:ironbox/src/widgets/contactsLoadingWidgets.dart';
import 'package:ironbox/src/widgets/conversationTileWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/showUserContactsListWidget.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;

class Messages extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  Messages({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  ChatsController _con = Get.put(ChatsController());
  FocusNode _chatSearchFocusNode;
  // FirebaseMethods firebaseMethods = FirebaseMethods();

  @override
  void initState() {
    _chatSearchFocusNode = new FocusNode();
    _con.getContacts(userRepo.currentUser.value.id);
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
        leading: widget.parentScaffoldKey != null
            ? IconButton(
                onPressed: () {
                  widget.parentScaffoldKey.currentState.openDrawer();
                },
                icon: Icon(Icons.notes_rounded),
              )
            : const SizedBox(
                height: 0.0,
                width: 0.0,
              ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBar(),
            const SizedBox(
              height: 5.0,
            ),
            Obx(() {
              return _con.contacts.isEmpty && !_con.doneFetchingContacts.value
                  ? ContactsLoadingWidget()
                  : _con.contacts.isEmpty && _con.doneFetchingContacts.value
                      ? const Center(child: const Text("You have no contacts!"))
                      : UserContactsListWidget(_con.contacts);
            }),
            const Divider(),
            const SizedBox(
              height: 0.0,
            ),
            Obx(() {
              return _con.contacts.isEmpty && _con.doneFetchingContacts.value
                  ? const Center(
                      child: const Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: const Text("No chats to display!"),
                      ),
                    )
                  : _con.contacts.isEmpty && !_con.doneFetchingContacts.value
                      ? const Center(
                          child: const CircularProgressIndicator(),
                        )
                      : Container(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _con.firebaseMethods
                                .fetchContacts(userRepo.currentUser.value.id),
                            builder: (context, snapShot) {
                              // print(userRepo.currentUser.value.id);
                              if (snapShot.hasData) {
                                print(snapShot.data.docs);
                                var contactDocs = snapShot.data.docs;

                                if (contactDocs.isEmpty) {
                                  // no chats
                                  return Center(
                                      child: Text(
                                    "No chats. Start chatting now",
                                  ));
                                } else {
                                  print("contacts list");
                                  print(contactDocs);
                                  return ListView.separated(
                                    itemCount: contactDocs.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      UserContact contact =
                                          new UserContact.fromMap(
                                              contactDocs[index].data());
                                      print(contact.contactId);
                                      return GestureDetector(
                                        onTap: () {
                                          // open chatting screen
                                          // pass current and clicked user
                                          FocusScope.of(context).unfocus();
                                          // Get.to(ChattingScreen(),
                                          //     transition: Transition.rightToLeft);
                                        },
                                        child: ConversationTileWidget(
                                          contactId: contact.contactId,
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider();
                                    },
                                  );
                                }
                              } else if (snapShot.hasError) {
                                return Center(
                                    child: Text(
                                        "Something went wrong. Check your internet connection and try again"));
                              } else {
                                return Center(
                                  child: Text(
                                    "No chats. Start chatting now",
                                  ),
                                );
                              }
                            },
                          ),
                        );
            }),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
          suffixIcon: const Icon(
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
    );
  }
}
