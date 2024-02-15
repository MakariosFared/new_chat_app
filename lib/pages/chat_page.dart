import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_chat_app/models/message.dart';
import '../const.dart';
import '../widgets/chat_bubble_widget.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  static String id = "ChatPage";
  final _controller = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
              backgroundColor: kPrimaryColor,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Spacer(flex: 1),
                  Image.asset(
                    kLogo,
                    height: 65,
                  ),
                  const Text(' Chat'),
                  // const Spacer(
                  //   flex: 2,
                  // )
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubble(
                              message: messagesList[index],
                            )
                          : ChatBubbleForFriend(
                              message: messagesList[index],
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: const Icon(Icons.send, color: kPrimaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Loading...'));
        }
      },
    );
  }
}
